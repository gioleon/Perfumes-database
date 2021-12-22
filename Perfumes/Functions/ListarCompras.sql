--================================================
--  Create Inline Table-valued Function template
--================================================
USE Perfumes
GO

IF OBJECT_ID (N'dbo.ListarCompra') IS NOT NULL
    DROP FUNCTION dbo.ListarCompra
GO

CREATE FUNCTION dbo.ListarCompra
(
	@cliente varchar(25),
	@producto varchar(25)

)
RETURNS TABLE
AS RETURN
(
	select * from vw_compras_productos
	where Nombre like case when @cliente not like '0' then @cliente+'%'
					else Nombre end
		and Producto like case when @producto not like '0' then @producto+'%'
					else Producto end
)
GO
