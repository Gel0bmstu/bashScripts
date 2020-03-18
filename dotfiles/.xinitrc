userresources=$HOME/.Xresources

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

exec i3
exec setxkbmap -layout us,ru -option grp:alt_shift_toggle

