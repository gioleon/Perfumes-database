-- =========================================
-- Create table template
-- =========================================
USE Perfumes
GO

IF OBJECT_ID('dbo.Compras', 'U') IS NOT NULL
  DROP TABLE dbo.Compras
GO

CREATE TABLE dbo.Compras
(
	VentaID int  NOT NULL, 
	Nombre varchar(25) NOT NULL, 
	Telefono varchar(10) NULL,
	PedID int NOT NULL,
	ProID int NOT NULL,
	Cantidad int NOT Null,
	Total numeric(18, 2) NOT NULL,
	Pagado numeric(18, 2) NOT NULL,
	Saldo numeric(18, 2) NOT NULL,
	Fecha date NOT NULL,
    CONSTRAINT PK_Cliente PRIMARY KEY (VentaID),
	CONSTRAINT CK_Compras_cantidad_mayor_cero CHECK(Cantidad > 0),
	CONSTRAINT FK_Proveedor FOREIGN KEY(PedID)
				REFERENCES Proveedor(PedID),
	CONSTRAINT FK_Productos FOREIGN KEY(ProID)
				REFERENCES Productos(ProID)

)
GO

