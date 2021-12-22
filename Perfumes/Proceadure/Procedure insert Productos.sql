-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'sp_insert_productos' 
)
   DROP PROCEDURE dbo.sp_insert_productos
GO

CREATE PROCEDURE dbo.sp_insert_productos
	@PedID int = 0, 
	@Nombre varchar(25),
	@Genero varchar(10),
	@Cantidad int,
	@Precio numeric(18, 2)
AS
	declare @ProID int = case when (select max(ProID) from Productos) is null then 1
								else (select max(ProID) from Productos) + 1 end
	
	insert into Productos
	values
	(@ProID, @PedID, @Nombre, @Genero, @Cantidad, @Precio)
GO

-- =============================================
-- Example to execute the stored procedure
-- =============================================

