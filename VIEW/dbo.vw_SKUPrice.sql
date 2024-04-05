/*
   Создание представления в соответствии с указанными требованиями
*/

create view dbo.vw_SKUPrice 
as 
select *, dbo.udf_GetSKUPrice(ID) as Price from dbo.SKU