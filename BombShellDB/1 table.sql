use BombShellDB
go 
drop table if exists Shell
go 
create table dbo.Shell(
    ShellId int not null identity primary key, 
    Style varchar(20) not null constraint ck_Shell_Style_must_be_either_elbow_or_wrist check(Style in('Elbow','wrist')),
    Color varchar(20) not null constraint ck_Shell_Color_must_be_either_white_or_black_or_nude check(Color in('white','black','nude')),
    Size varchar(20) not null constraint ck_Shell_Size_must_be_either_small_or_medium_or_large check(Size in('small', 'medium', 'large')),
    DatePurchased date not null,
    PricePurchased decimal(6,2) not null constraint ck_Shell_PricePurchased_must_be_greater_than_0 check(PricePurchased > 0), 
    DateSold date null, 
    PriceSold decimal(6,2) null constraint ck_Shell_PriceSold_must_be_greater_than_0 check(PriceSold > 0),
    constraint ck_DateSold_and_PriceSold_are_both_null_or_both_not_null check((DateSold is null and PriceSold is null) or (DateSold is not null and PriceSold is not null)),
    constraint ck_DatePurchased_must_be_before_DateSold check(DatePurchased < DateSold),
    constraint ck_PriceSold_must_be_more_than_PricePurchased check(PricePurchased < PriceSold)
)
