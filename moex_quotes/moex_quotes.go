package main

import (
	"bytes"
	"flag"
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"

	"github.com/buger/jsonparser"
)

var errCodes = []string{"400", "404", "402", "500", "502", "505"}

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

	strArr := strings.Split(string(val), ",")
	strArr[0] = strArr[0][1:]
	if len(strArr[1]) > 3 {
		strArr[1] = strArr[1][0:4]
	}

	if len(strArr[2]) > 4 {
		strArr[2] = strArr[2][:4]
	} else {
		strArr[2] = strArr[2][:len(strArr[2]) - 1]
	}

	fmt.Println(ticker, strArr[0], strArr[1], strArr[2])

	return
}

func main() {

	var ticker = flag.String("t", "TATNP", "Get quotes of current ticker")
	flag.Parse()

	src := "https://scanner.tradingview.com/russia/scan"

	getQuote(src, *ticker)
}

