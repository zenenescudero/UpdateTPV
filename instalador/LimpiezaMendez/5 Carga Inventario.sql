use DB_Mendez
go  

INSERT INTO DB_Mendez.dbo.[InventarioMovimientos]([Id]
      ,[IdTicket], [IdOrdenCompra]  ,[ArticuloId] ,[Articulo],[SucursalId]
      ,[Tipo] ,[ConceptoInvId] ,[FolioCompra] ,[Comentario]
      ,[Entrada] ,[Salida] ,[UsuarioId] ,[QUIEN]
      ,[CUANDO]  ,[EQUIPO] ,[Enviado]  ,[Version])
SELECT
ROW_NUMBER() over(order by a.Id) as id,
0 as Ticket,
0 as [IdOrdenCompra],
a.Id as articuloid,
e.ARTICULO,
(SELECT TOP 1 Id FROM sucursales) as usuarioid,
'E' as tipo,
204 as conceptoid,
'' as foliocompra,
'INICIO DE OPERACIONES, MIGRACIÓN DE SISTEMA' as comentario,
e.Existencias as entrada,
0 as salida,
null usuarioid,
'SCRIPT' as quien,
GETDATE() as cuando,
'DATABASE' as donde,
1 as enviado,
1 as version
FROM DB_MUEBLERIA.dbo.EXISTENCIAS e
INNER JOIN articulos a on(e.ARTICULO = a.ARTICULO)

go


INSERT INTO DB_Mendez.dbo.[Inventario]([Id]
      ,[ArticuloId],[SucursalId],[Saldo],[Enviado]  ,[Version])
SELECT
ROW_NUMBER() over(order by a.Id) as id,
a.Id as articuloid,
(SELECT TOP 1 Id FROM [Sucursales]) as Sucursal,
e.Existencias as entrada,
1 as enviado,
1 as version
FROM [DB_MUEBLERIA].dbo.EXISTENCIAS e
INNER JOIN Articulos a on(e.ARTICULO = a.ARTICULO)


go

/*

consultar maximo 

-- sucursal 2
select max(Id) from  DB_Mendez.dbo.Inventario;

insert into  DB_Mendez.dbo.Inventario(Id,ArticuloId,SucursalId, Saldo,Enviado, [Version])
select (Id + 1200) as Id, ArticuloId, 2, Saldo, Enviado, [Version] from  DB_Mendez.dbo.Inventario
where SucursalId = 1

-- sucursal 3
select max(Id) from  DB_Mendez.dbo.Inventario;

insert into  DB_Mendez.dbo.Inventario(Id,ArticuloId,SucursalId, Saldo,Enviado, [Version])
select (Id + 1200) as Id, ArticuloId, 3, Saldo, Enviado, [Version] from  DB_Mendez.dbo.Inventario
where SucursalId = 1

*/


/* CARGAR MOV INVENTARIO.

-- sucursal 2

SELECT MAX(Id) from DB_Mendez.dbo.InventarioMovimientos

insert into DB_Mendez.dbo.InventarioMovimientos
select ([Id] + 2384)
      ,[IdTicket]
      ,[IdOrdenCompra]
      ,[ArticuloId]
      ,[Articulo]
      ,2 [SucursalId]
      ,[Tipo]
      ,[ConceptoInvId]
      ,[FolioCompra]
      ,[Comentario]
      ,[Entrada]
      ,[Salida]
      ,[UsuarioId]
      ,[QUIEN]
      ,[CUANDO]
      ,[EQUIPO]
      ,[Enviado]
      ,[Version]
      ,[FolioInterno]
      ,[Costo]
      ,[Total] from DB_Mendez.dbo.InventarioMovimientos where SucursalId = 1

-- sucursal 3

SELECT MAX(Id) from DB_Mendez.dbo.InventarioMovimientos

insert into DB_Mendez.dbo.InventarioMovimientos
select ([Id] + 2384)
      ,[IdTicket]
      ,[IdOrdenCompra]
      ,[ArticuloId]
      ,[Articulo]
      ,3 [SucursalId]
      ,[Tipo]
      ,[ConceptoInvId]
      ,[FolioCompra]
      ,[Comentario]
      ,[Entrada]
      ,[Salida]
      ,[UsuarioId]
      ,[QUIEN]
      ,[CUANDO]
      ,[EQUIPO]
      ,[Enviado]
      ,[Version]
      ,[FolioInterno]
      ,[Costo]
      ,[Total] from DB_Mendez.dbo.InventarioMovimientos where SucursalId = 1

*/
