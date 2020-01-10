### moex_quote
```
sudo snap install golang
go get github.com/buger/jsonparser
```
Пишет в stdout котировки компании, тикер которой был передан во флаге -t, --ticker.
Пример: 
```
./moex_quotes.sh -t YNDX
```