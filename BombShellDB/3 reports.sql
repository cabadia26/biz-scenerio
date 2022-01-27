/*1. A daily printout every morning including the Inventory in stock, style, color, size,
date purchased, price purchased, date sold, price sold, and the date and time record of that printout to refer if i had to give a hardcopy to my partner.

2. Printout of sku, style, color, size, date purchase, price purchase, date sold, price sold

3. which style is giving me most profit 

4. which size sells the most

5. avg how long does it take for inventory to be sold per color each week
*/
use BombShellDB
go 

--1
--unsold items:
select s.style, s.color, s.size, s.datepurchased, s.pricepurchased, PrintoutDateTime = getdate()
from shell s
where s.pricesold is null

--sold items:
select s.style, s.color, s.size, s.datepurchased, s.pricepurchased, s.datesold, s.pricesold, PrintoutDateTime = getdate()
from shell s
where s.pricesold is not null

--2
select s.style, s.color, s.size, s.datepurchased, s.pricepurchased, s.datesold, s.pricesold
from shell s

--3
select AvgProfit = avg(PriceSold - PricePurchased), s.style
from shell s 
where s.datesold is not null
group by s.style
order by AvgProfit desc

--4
select top 1 AmountOfSoldShell = count(*), s.size
from shell s 
where s.datesold is not null
group by s.size
order by AmountOfSoldShell desc

--5
select AvgWeeksInInventory = avg(datediff(week, s.DatePurchased, isnull(s.dateSold, getdate()))), s.color
from shell s 
group by s.color
