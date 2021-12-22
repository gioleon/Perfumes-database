
--Insertando Proveedor

exec sp_insert_proveedor 2, 39000, 39000, '2021/09/17'


--Insertando Productos

exec sp_insert_productos 4, '212 VIP', 'Masculino', 1, 25000
exec sp_insert_productos 5, 'Issey miyake', 'Masculino', 1, 25000

--Insertando Compras
exec sp_insert_compra 'Goyo', null, 5, 'Issey%', 1, 25000, '2021/10/4'

--Insertando Abonos
exec sp_insert_abono 42, 19980, '2021/10/4'


--ver tabla proveedor
select * from Proveedor

--ver tabla productos

select * from Productos




--ver tabla compras
select * from Compras

--ver tabla  abonos
select * from Abonos


UPDATE Compras
set Saldo = Total
where Nombre like 'Rey%' and ProID = 6


--Cuentas
select SUM(Pagado) Pagado, SUM(Saldo) Deben, SUM(Pagado) + SUM(Saldo) total from Compras
select SUM(Precio) as Dinero from Productos

Select SUM(Pago)-sum(c.total)
from Proveedor as pv
inner join Compras  c
on pv.PedID = c.PedID
group by Pago

--Eliminar venta
delete from Compras
where Nombre like 'Meu%'

--actualizar precios
update Productos
set Cantidad = Cantidad + 1
where ProID =  22
