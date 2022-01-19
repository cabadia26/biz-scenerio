use BombShellDB
go
drop table if exists BombShell
go
create table dbo.BombShell(
    BombShellId int  not null identity primary key,
    DateTimeSaved datetime default getdate(),
    Style varchar(10) not Null
        constraint ck_bombshell_style_cannot_be_blank check(Style <> ''),
    Color varchar(10) not null
        constraint ck_bombshell_Color_cannot_be_blank check(Color <> ''),
    Size varchar(10) not null
        constraint ck_bombshell_size_cannot_be_blank check(Size <> ''), 
    DatePurchased date not null
        constraint ck_bombshell_date_purchased_cannot_be_blank check(DatePurchased <> ''),
    PricePurchased int not null
        constraint ck_bombshell_Price_Purchased_cannot_be_blank check(PricePurchased <> ''),
        constraint ck_BombShell_price_purchased_must_be_higher_than_zero check(pricepurchased > 0),
    DateSold date,
    PriceSold decimal(4,2)
        constraint ck_BombShell_price_sold_must_be_higher_than_zero check(pricesold > 0),
        constraint ck_Bombshell_price_sold_must_be_bigger_than_price_purchased check(pricesold > pricepurchased),
        constraint ck_BombShell_Date_Sold_must_be_after_Date_purchased check(datesold > datepurchased)

)
