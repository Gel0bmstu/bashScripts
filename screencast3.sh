
#!/bin/bash -e

while getopts "mnhv" o
do
	case "$o" in
	(\?) echo "Invalid option: -$OPTARG" >&2 ;;
	(h) less $(readlink -f $(dirname $0))/README.md; exit;;
	(v) verbose="";; # funnily ffmpeg is verbose by default
	(*) break;;
	esac
done
shift $((OPTIND - 1))

lockfile=/tmp/r2d2

if test -f $lockfile
then
	pid=$(awk '{print $1}' $lockfile)
	if kill -0 $pid
	then
		kill -INT $pid
		echo Killed $(cat $lockfile)
		logger x11captured: $(du -h $(awk '{print $2}' $lockfile))
		rm $lockfile
		exit
	else
		rm $lockfile
	fi
fi

#output="$(dirname $(readlink -f $0))/$(date +%Y-%m-%d)/${1:-$(date +%s)}.mkv"
output="/home/gel0/Videos/screencast/$(date +%Y-%m-%d)/${1:-$(date +%s)}.mkv"
mkdir -p $(dirname $output)

# Only create RAW file if one does not exist
if test -f "$output"
then
	echo $output already exists
	logger $(basename $0): $output already exists
	exit 1
fi

die() { echo "$@"; exit 1; }
require() { which $1 &> /dev/null; }
for prg in xdpyinfo ffmpeg; do
	require $prg || die "needs ${prg} installed"
done

res="$(xdpyinfo | awk '/dimensions:/ { print $2; exit }')"

# https://trac.ffmpeg.org/wiki/Capture/Desktop
#FFREPORT=file=/tmp/$(basename $output).log ffmpeg -report -hide_banner -loglevel quiet \
#	-f x11grab -video_size $res -i $DISPLAY -f pulse -i default -acodec pcm_s16le -c:v lib#x264 \
#	$output &


# https://trac.ffmpeg.org/wiki/Capture/Desktop
X11GRAB=$(xrectsel "-f x11grab -s %wx%h -i :0.0+%x,%y") || exit -1
FFREPORT=file=/tmp/$(basename $output).log ffmpeg -report -hide_banner -loglevel quiet \
	-framerate 25 $X11GRAB  -f alsa -ac 2 -i hw:0 \
	$output &


echo "$! $(readlink -f $output)" > $lockfile
echo -e "\033[1;34m$0\033[m Capturing $res to $output kill $(awk '{print $1}' $lockfile) to kill capture or run $0 again"
