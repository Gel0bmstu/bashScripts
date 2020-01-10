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
./moex_quotes.sh -t YNDX
>> YNDX 2720 -8.4 -0.30

./moex_quotes.sh -t SBERP
>> SBERP 232.23 1.23 0.53
```
Цвет текста сообщения зависит от роста/падения цены на ценную бумагу компании.
