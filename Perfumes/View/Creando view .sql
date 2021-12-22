-- =============================================
-- Create View template
-- =============================================
USE Perfumes
GO

IF object_id(N'dbo.vw_compras_productos', 'V') IS NOT NULL
	DROP VIEW dbo.vw_compras_productos
GO

CREATE VIEW dbo.vw_compras_productos AS
select C.VentaID
		,C.Nombre
		,C.Telefono
		,P.PedID
		,P.ProID
		,P.Nombre as Producto
		,C.Cantidad
		,C.Total
		,C.Pagado
		,C.Saldo
		,C.Fecha
from Compras C
inner join 
Productos P
on C.ProID = P.ProID


select * from vw_compras_productos

