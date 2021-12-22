-- =========================================
-- Create table template
-- =========================================
USE Perfumes
GO

IF OBJECT_ID('dbo.Proveedor', 'U') IS NOT NULL
  DROP TABLE dbo.Proveedor
GO

CREATE TABLE dbo.Proveedor
(
	PedID int NOT NULL,
	Cantidad int NOT NULL,
	Total numeric(18, 2) NOT NULL,
	Pago numeric(18, 2) not NULL,
	Saldo numeric(18, 2) NOT NULL,
	fecha date NOT NULL, 
    CONSTRAINT PK_Proveedor PRIMARY KEY (PedID),
	CONSTRAINT CK_cantidad_mayor_cero CHECK(Cantidad > 0)
)
GO
