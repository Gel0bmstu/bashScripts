#!/bin/sh

getQuotes () {
    # Выполняем go скрипт, получаем строку, содержащую информацю о текущих
    # котировках тикера
    goScriptPath=$(go run /media/d/bashScripts/moex_quotes/moex_quotes.go -t $1)
    res=$goScriptPath

    # Обрабатываем возможные возвращаемые ошибки
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

        # Сплитим строку по пробелам, получаем массив слов
        arr=($res)
    
        # Получаем текущий день недели и врмя
        begin=$(date --date="9:55" +%s)
        end=$(date --date="19:00" +%s)
        now=$(date +%s)

        day=$(date +%u)
        
        # Если биржа сейчас рабоатет, выводим "раскрашенные" значения котировок
        if [ "$begin" -le "$now" -a "$now" -le "$end" -a "$day" -ne 6 -a "$day" -ne 7 ]; then
            if [[ $(echo "${arr[2]} < 0" | bc) -eq "1" ]]; then
                echo "${arr[0]}%{F#ff4d4d} ${arr[1]}  | ${arr[2]}₽ | ${arr[3]}%%{F-}"
            elif [[ $(echo "${arr[2]} > 0" | bc) -eq "1" ]]; then
                echo "${arr[0]}%{F#69f56e} ${arr[1]}  | ${arr[2]}₽ | ${arr[3]}%%{F-}"
            elif [[ $(echo "${arr[2]} == 0" | bc) -eq "1" ]]; then
                echo "${arr[0]} ${arr[1]}  | ${arr[2]}₽ | ${arr[3]}%"
            fi
        else
            # Иначе выводим поледние полученные значения без цвета
            echo "${arr[0]} ${arr[1]} | ${arr[2]}₽ | ${arr[3]}%"
        fi
    fi
}

while test $# -gt 0; do
    
    # Парсим флаги которые мы указали в вызове скрипта
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
            echo " "
            echo "                          First number is current price of stock,"
            echo "                          Second is the change of price in ₽,"
            echo "                          Third - in %."
            break
            ;;
        -t|--ticker)
            shift
            if test $# -gt 0; then
                # Если у флага -t есть опция [TICKER], то вызываем
                # функцию getQuotes, в которую передаем тикер
                getQuotes $1
            else
                echo "Empty ticker"
                exit 1
            fi
            shift
            ;;
        *)
            echo "Please, set ticker. Type -h or --help, if you"
            echo "have questions about how that script work"
            break
            ;;
    esac
done