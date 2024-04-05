/*
  Создание функции в соответствии с указанными требованиями
*/

create or alter function dbo.udf_GetSKUPrice(
  @ID_SKU int
)
returns decimal(18, 2)
as
begin
  declare @result decimal(18, 2);
  select @result = SUM(s.Value) / SUM(s.Quantity)
  from dbo.Basket as s
  where s.ID_SKU = @ID_SKU
  return @result
end