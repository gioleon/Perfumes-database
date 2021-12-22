-- =========================================
-- Create table template
-- =========================================
USE Perfumes
GO

IF OBJECT_ID('dbo.Productos', 'U') IS NOT NULL
  DROP TABLE dbo.Productos
GO

CREATE TABLE dbo.Productos
(	
	ProID int  NOT NULL,
	PedID int NOT NULL,
	Nombre varchar(25) NOT NULL,
	Genero varchar(10) NOT NULL,
	Cantidad int NOT NULL, 
	Precio numeric(18, 2) NOT NULL, 
    CONSTRAINT PK_sample_table PRIMARY KEY (ProID),
	CONSTRAINT CK_Productos_cantidad_mayor_cero CHECK (Cantidad > 0),
	CONSTRAINT UQ_pedID_proID UNIQUE(PedID, ProID),
	CONSTRAINT FK_Productos_Proveedor FOREIGN KEY (PedID)
		REFERENCES Proveedor (PedID)
)
GO

alter table Productos
add constraint CK_Productos_cantidad_mayor_o_igual_cero CHECK(cantidad >= 0)


