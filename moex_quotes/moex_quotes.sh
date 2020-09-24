#!/bin/bash

getQuotes () {
    # Выполняем go скрипт, получаем строку, содержащую информацю о текущих
    # котировках тикера
    go run /home/gel0/bashscripts/moex_quotes/moex_quotes.go -t $1
}

while test $# -gt -1; do
    
    # Парсим флаги которые мы указали в вызове скрипта
    case "$1" in
        -h|--help)
            echo "The script allows you to receive real-time quotes of MOEX companies:"
            echo " "
            echo "moex_quotes.sh [OPTIONS]"
            echo "options:"
            echo " "
            echo "  -t, --ticker [TICKER] - Get quotes of current [TICKER]"
            echo "                          For example: '-t YNDX' will give you"
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
