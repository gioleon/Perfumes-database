-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'sp_insert_proveedor' 
)
   DROP PROCEDURE dbo.sp_insert_proveedor
GO

CREATE PROCEDURE dbo.sp_insert_Proveedor
	@Cantidad int = 0, 
	@Total numeric(18, 2) = 0,
	@Pago numeric(18, 2),
	@fecha date
AS
	declare @Saldo numeric(18, 2) = @total - @Pago
	declare @PedID int = case when (select MAX(PedID) from Proveedor) is null then 1
										else (select MAX(PedID) from Proveedor)+1 end 
	insert into Proveedor
	values
	(@PedID, @Cantidad, @total, @Pago, @Saldo, @fecha)




