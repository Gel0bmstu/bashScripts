### moex_quote
![](https://i.ibb.co/D1JtcNr/screenshoot.png)
![](https://i.ibb.co/Qn655Dn/screenshoot.png)
```
sudo snap install golang
go get github.com/buger/jsonparser
```
Пишет в stdout котировки компании, тикер которой был передан во флаге -t, --ticker.
Пример: 
```
./moex_quotes.go -t YNDX
>> YNDX 2720 -8.4 -0.30

./moex_quotes.sh -t SBERP
>> SBERP%{F#ff4d4d} 236.43  | -2.0₽ | -0.86%%{F-}
```
Цвет текста сообщения зависит от роста/падения цены на ценную бумагу компании.
