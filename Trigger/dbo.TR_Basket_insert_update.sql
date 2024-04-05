/*
    Создание триггера в соответствии с указанными требованиями
*/

create or alter trigger dbo.TR_Basket_insert_update on dbo.Basket
after insert
as
begin
  update dbo.Basket
  set DiscountValue = Value / 100 * 5
  where ID_SKU in (
    select ID_SKU
    from inserted 
    group by ID_SKU
    having count(ID_SKU) >= 2
  );

  update dbo.Basket
  set DiscountValue = 0
    where ID_SKU in (
      select ID_SKU
      from inserted 
      group by ID_SKU
      having count(ID_SKU) < 2
    );
end