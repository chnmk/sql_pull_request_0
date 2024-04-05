/*
   Создание процедуры в соответствии с указанными требованиями. 
   Процедура при вызове обновляет данные в таблице dbo.Family в поле BudgetValue
*/

create or alter procedure dbo.usp_MakeFamilyPurchase(
   @FamilySurName varchar(255)
)
as
begin
   if exists (
      select * 
      from dbo.Family as s 
      where s.SurName = @FamilySurName
   )
   begin
      update dbo.Family
      set BudgetValue = BudgetValue - s.sum
      from (
         select sum(b.value) 
         as sum 
         from dbo.Basket as b
            left join dbo.Family as f on f.ID = b.ID_Family
         where SurName = @FamilySurName
      ) s
      where SurName = @FamilySurName;
   end
   else
   begin
      raiserror ('Укзанная семья отсутствует в таблице.', 10, 1)
   end
end