-- =============================================
-- Create basic stored procedure template
-- =============================================

use Perfumes
-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'sp_insert_compra' 
)
   DROP PROCEDURE dbo.sp_insert_compra
GO

CREATE PROCEDURE dbo.sp_insert_compra
	@Nombre varchar(25) = ' ',
	@telefono varchar(10),
	@PedID int,
	@nombre_producto varchar(25),
	@Cantidad int, 
	@Pagado numeric(18, 2),
	@Fecha date

AS
	declare @ProID int
	declare @razon varchar(30)
	declare @insert bit = 1
	--ver si el pedido existe
	select PedID from Proveedor
	where PedID = @PedID

	if (@@ROWCOUNT = 0)	
			begin
				select 'El pedido no existe' 
				set @insert = 0
				set @razon = CONCAT_WS(' ', 'El pedido', @PedID, 'no se encuentra en la base de datos')
			end
		else
			begin
				select 'El pedido existe'
				--comprobando si hay unidades del producto		
				set @ProID = (select ProID from Productos where Nombre like @nombre_producto and PedID = @PedID)
				set @nombre_producto = (select Nombre from Productos where ProID = @ProID and PedID = @PedID)
			
				select ProID, Cantidad from Productos
				where ProID = @ProID and Cantidad > 0 and PedID = @PedID

				if (@@ROWCOUNT = 0)
					begin
						set @razon =  CONCAT_WS(' ', 'No hay unidades del producto', (select Nombre from Productos where ProID = @ProID), 'identificado con el ID:', @ProID)
						set @insert = 0
					end
				else
					begin
						select CONCAT_WS(' ', 'El producto', (select Nombre from Productos where ProID = @ProID), 'se encuentra disponible' )
					end	
		end
declare @Total numeric(18, 2) = (select Precio from Productos where ProID = @ProID) * @Cantidad
declare @Saldo numeric(18, 2) = @Total - @Pagado
declare @VentaID int = case when (select max(VentaID) from Compras) is null then 1
									else (select max(VentaID) from Compras) + 1 end
if (@insert = 1)
	begin
		insert into Compras
		values
		(@VentaID, @Nombre, @telefono, @PedID, @ProID, @Cantidad, @Total, @Pagado, @Saldo, @Fecha)

		update Productos
		set Cantidad = Cantidad - @Cantidad
		where ProID = @ProID

		print 'Compra ingresada'
	end

else
	begin
		Print 'Compra no insertada.'+@razon
	end

-- =============================================
-- Example to execute the stored procedure
-- =============================================