package main

import (
	"bytes"
	"flag"
	"fmt"
	"io/ioutil"
	"net/http"
	"strconv"
	"strings"
	"time"

	"github.com/buger/jsonparser"
)

var errCodes = []string{"400", "404", "402", "500", "502", "505"}

const (
	DownColor = "%s%%{F#ff4d4d}%s%%{F-}"
	UpColor   = "%s%%{F#69f56e}%s%%{F-}"
)

func checkResStatus(s string) bool {
	for _, code := range errCodes {
		if code == s {
			return true
		}
	}

	return false
}

func getQuote(s string, ticker string) {

	var (
		res *http.Response
		err error
	)

	ticker = strings.ToUpper(ticker)

	body := []byte(`{"symbols":{"tickers":["MOEX:` + ticker + `"],"query":{"types":[]}},"columns":["close", "change_abs", "change"]}`)
	r := bytes.NewReader(body)

	res, err = http.Post(s, "multipart/form-data", r)

	if err != nil || checkResStatus(res.Status) {
		// fmt.Println("Unable to make requeest: ", err)
		fmt.Println("X")
		return
	}

	defer res.Body.Close()

	htmlData, err := ioutil.ReadAll(res.Body)

	if err != nil {
		// fmt.Println("Unable to decode response body: ", err)
		fmt.Println("E")
		return
	}

	val, _, _, err := jsonparser.Get(htmlData, "data", "[0]", "d")

	if err != nil {
		// fmt.Println("Unable to parse response body: ", err)
		fmt.Println("W")
		return
	}

	str := strings.Replace(string(val), "[", "", -1)
	str1 := strings.Replace(str, "]", "", -1)
	strArr := strings.Split(str1, ",")

	quoteArr := []float64{}

	for _, str := range strArr {
		val, err := strconv.ParseFloat(str, 64)
		if err != nil {
			fmt.Println("W")
			return
		}

		quoteArr = append(quoteArr, val)
	}

	current_time := time.Now()
	hours := current_time.Format("15.04")
	hours_float, _ := strconv.ParseFloat(hours, 64)
	weekday := current_time.Weekday()

	if hours_float < 9.55 || hours_float > 19.00 || int(weekday) == 6 || int(weekday) == 7 {
		if quoteArr[1] < 0 {
			fmt.Println(fmt.Sprintf("%s %.2f  | %.2f₽ | %.2f%%", ticker, quoteArr[0], quoteArr[1], quoteArr[2]))
		} else if quoteArr[1] > 0 {
			fmt.Println(fmt.Sprintf("%s %.2f  | %.2f₽ | %.2f%%", ticker, quoteArr[0], quoteArr[1], quoteArr[2]))
		} else {
			fmt.Println(fmt.Sprintf("%s | %.2f  | %.2f₽ | %.2f%%", ticker, quoteArr[0], quoteArr[1], quoteArr[2]))
		}
	} else {
		if quoteArr[1] < 0 {
			fmt.Println(fmt.Sprintf(DownColor, ticker, fmt.Sprintf(" %.2f  | %.2f₽ | %.2f%%", quoteArr[0], quoteArr[1], quoteArr[2])))
		} else if quoteArr[1] > 0 {
			fmt.Println(fmt.Sprintf(UpColor, ticker, fmt.Sprintf(" %.2f  | %.2f₽ | %.2f%%", quoteArr[0], quoteArr[1], quoteArr[2])))
		} else {
			fmt.Println(fmt.Sprintf("%s | %.2f  | %.2f₽ | %.2f%%", ticker, quoteArr[0], quoteArr[1], quoteArr[2]))
		}
	}

	return
}

func main() {

	ticker := flag.String("t", "TATNP", "Get quotes of current ticker")
	flag.Parse()

	src := "https://scanner.tradingview.com/russia/scan"

	getQuote(src, *ticker)
}
