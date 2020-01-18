#!/bin/sh

getQuotes () {
    goScriptPath=$(go run /media/d/bashScripts/moex_quotes/moex_quotes.go -t $1)
    res=$goScriptPath

    if [[ $res == "X" ]]
    then
        echo "offline"
    elif [[ $res == "W" ]]
    then
        echo 'wrong ticker'
    elif [[ $res == "E" ]]
    then
        echo "error"
    else
        arr=($res)
        begin=$(date --date="9:55" +%s)
        end=$(date --date="19:00" +%s)
        now=$(date +%s)

        day=$(date +%u)
        
        if [ "$begin" -le "$now" -a "$now" -le "$end" -a "$day" -ne 6 -a "$day" -ne 7 ]; then
            if [[ $(echo "${arr[2]} < 0" | bc) -eq "1" ]]; then
                echo "${arr[0]}%{F#ff4d4d} ${arr[1]}  | ${arr[2]}₽ | ${arr[3]}%%{F-}"
            elif [[ $(echo "${arr[2]} > 0" | bc) -eq "1" ]]; then
                echo "${arr[0]}%{F#69f56e} ${arr[1]}  | ${arr[2]}₽ | ${arr[3]}%%{F-}"
            elif [[ $(echo "${arr[2]} == 0" | bc) -eq "1" ]]; then
                echo "${arr[0]} ${arr[1]}  | ${arr[2]}₽ | ${arr[3]}%"
            fi
        else
            echo "${arr[0]} ${arr[1]} | ${arr[2]}₽ | ${arr[3]}%"
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
            echo "                          quotes of Russian IT company Yandex."
            echo " "
            echo "                          Format of quote will be like:"
            echo "                          YNDX 2725 -3.4 -0.12"
            break
            ;;
        -t|--ticker)
            shift
            if test $# -gt 0; then
                getQuotes $1
            else
                echo "Empty ticker"
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