-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'sp_insert_abono' 
)
   DROP PROCEDURE dbo.sp_insert_abono
GO

CREATE PROCEDURE dbo.sp_insert_abono
	@VentaID int = 0, 
	@Abono numeric(18, 2),
	@Fecha date
AS
	declare @nombre varchar(25) = (select Nombre from vw_compras_productos where VentaID = @VentaID)
	declare @razon varchar(25)
	declare @insert bit = 1

	--Verificando que exista la venta
	select VentaID from vw_compras_productos
	where VentaID = @VentaID

	if(@@ROWCOUNT = 0)
		begin
			set @razon = 'La venta no se encuentra en la base de datos'
			set @insert = 0
		end
	else
		begin
			--verificando que existe deuda
			declare @Total numeric(18, 2) = (select Total from vw_compras_productos where VentaID = @VentaID)
			declare @Pagado numeric(18, 2) = (select Pagado from vw_compras_productos where VentaID = @VentaID)

			if (@Total - @Pagado = 0)
				begin
					set @razon = 'No existe la deuda'
					set @insert = 0
				end
			else
				begin
				--verificando que se ingresa un abono aceptable
					if (@Abono > (@Total - @Pagado))
						begin
							set @razon = 'Ingrese un abono apropiado'
							set @insert = 0
						end
					else
						begin
							select 'Ingresando abono'
						end
				end
		end

if (@insert = 1)
	begin
		insert into Abonos
		values(@VentaID, @nombre, @Abono, @Fecha)

		update Compras 
		set Pagado = Pagado + @Abono
		where VentaID = @VentaID

		Update Compras
		set Saldo = Saldo - @Abono
		where VentaID = @VentaID

		print 'Abono ingresado'
	end
else
begin
	Print 'El abono no pudo ser ingresado. '+@razon
end
GO

-- =============================================
-- Example to execute the stored procedure
-- =============================================
--EXECUTE dbo.sp_insert_abono 1, 2
GO
