-- =========================================
-- Create table template
-- =========================================
USE Perfumes
GO

IF OBJECT_ID('dbo.Abonos', 'U') IS NOT NULL
  DROP TABLE dbo.Abonos
GO

CREATE TABLE dbo.Abonos
(
	VentaID int NOT NULL, 
	Nombre_Cliente varchar(20) NOT NULL,
	Abono numeric(18, 2) NOT NULL, 
	Fecha datetime NOT NULL,   
	CONSTRAINT FK_Abono_Compra FOREIGN KEY(VentaID)
			REFERENCES Compras(VentaID)
)
GO
