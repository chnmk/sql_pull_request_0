/*
   Создание трёх таблиц в соответствии с указанными требованиями
*/

-- Может быть необходимо для установки ограничения уникальности на вычисляемом поле
set quoted_identifier on 

if object_id('dbo.SKU') is null
begin
   create table dbo.SKU (
      ID int not null identity,
      Code as 's' + CONVERT(varchar(255), ID),
      Name varchar(255) not null,
      constraint PK_SKU primary key clustered (ID)
   )
   alter table dbo.SKU add constraint UK_SKU_Code unique (Code)
end

if object_id('dbo.Family') is null
begin
  create table dbo.Family (
     ID int not null identity,
     SurName varchar(255) not null,
     BudgetValue int not null,
     constraint PK_Family primary key clustered (ID)
  )
end

if object_id('dbo.Basket') is null
begin
  create table dbo.Basket (
     ID int not null identity,
     ID_SKU int not null,
     ID_Family int not null,
     Quantity int not null,
     Value int not null,
     PurchaseDate datetime not null,
     DiscountValue int not null,
     constraint PK_Basket primary key clustered (ID)
  )
    alter table dbo.Basket add constraint DF_Basket_PurchaseDate default current_timestamp for PurchaseDate
    alter table dbo.Basket add constraint FK_Basket_ID_SKU_SKU foreign key (ID_SKU) references dbo.SKU(ID)
    alter table dbo.Basket add constraint FK_Basket_ID_Family_Family foreign key (ID_Family) references dbo.Family(ID)
    alter table dbo.Basket add constraint CK_Basket_Quantity_Value check (Quantity >= 0 and Value >= 0)
end