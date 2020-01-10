#!/bin/sh

getQuotes () {
    goScriptPath=$(go run /home/gel0/scripts/moex_quotes.go -t $1)

    if [[ $goScriptPath == "X" ]]; then
        echo offline
    else
        arr=($goScriptPath)

        # echo $1 | head -c1

        if [[ $(echo "${arr[2]} < 0" | bc) -eq "1" ]]; then
            echo "${arr[0]}%{F#ff4d4d} ${arr[1]}  | ${arr[2]}₽ | ${arr[3]}%%{F-}"
        elif [[ $(echo "${arr[2]} > 0" | bc) -eq "1" ]]; then
            echo "${arr[0]}%{F#69f56e} ${arr[1]}  | ${arr[2]}₽ | ${arr[3]}%%{F-}"
        elif [[ $(echo "${arr[2]} == 0" | bc) -eq "1" ]]; then
            echo "${arr[0]} ${arr[1]}  | ${arr[2]}₽ | ${arr[3]}%"
        fi
    fi
}

while test $# -gt 0; do
    case "$1" in
        -h|--help)
            echo "The script allows you to receive real-time quotes of MOEX companies:"
            echo " "
            echo "moex_quotes.hs [OPTIONS]"
            echo "options:"
            echo " "
            echo "  -t, --ticker [TICKER] - Get quotes of current [TICKER]"
            echo "                          For example: -t YNDX will give you"
            echo "                          quotes of Russian IT company Yndex."
            break
            ;;
        -t|--ticker)
            shift
            if test $# -gt 0; then
                getQuotes $1
            else
                echo "no process specified"
                exit 1
            fi
            shift
            ;;
        *)
            echo "Please, set ticker"
            break
            ;;
    esac
done