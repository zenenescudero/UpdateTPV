

SELECT Login,Sucursal FROM DB_MUEBLERIA.dbo.Usuarios

--LUCY

update DB_Mendez.dbo.facturas set sucursalid = 3 where QUIEN = 'LUCY'
update DB_Mendez.dbo.facturasDetalle set sucursalid = 3 where QUIEN = 'LUCY'
update DB_Mendez.dbo.ComplementoPago set sucursalid = 3 where QUIEN = 'LUCY'
update DB_Mendez.dbo.EstadoCuenta set sucursalid = 3 where QUIEN = 'LUCY'
update DB_Mendez.dbo.NotasCredito set sucursalid = 3 where QUIEN = 'LUCY'

--MARIBEL
update DB_Mendez.dbo.facturas set sucursalid = 2 where QUIEN = 'MARIBEL'
update DB_Mendez.dbo.facturasDetalle set sucursalid = 2 where QUIEN = 'MARIBEL'
update DB_Mendez.dbo.ComplementoPago set sucursalid = 2 where QUIEN = 'MARIBEL'
update DB_Mendez.dbo.EstadoCuenta set sucursalid = 2 where QUIEN = 'MARIBEL'
update DB_Mendez.dbo.NotasCredito set sucursalid = 2 where QUIEN = 'MARIBEL'

--- folios iniciales SUC 1

USE [DB_Mendez]
GO

DELETE FROM DB_Mendez.[dbo].[FoliosInternos]

SET IDENTITY_INSERT [dbo].[FoliosInternos] ON 

INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (1, N'OrdenCompra', 1)
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (2, N'Tickets', 1)
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (3, N'Presupuesto', 1)
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (4, N'InventarioMovimientos', 1)
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (6, N'Traspaso', 1)
-- 20k suc 1 40k suc 2, 60k suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (5, N'Clientes', 20000)
-- 2000 suc 1, 22000 suc 2 32000 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (7, N'Articulos', 2000)
-- 200 suc 1, 300 suc 2 400 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (8, N'Marcas', 200)
-- 50 suc 1,  200 suc 2 300 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (9, N'Proveedores', 50)
-- 50 suc 1,  200 suc 2 300 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (10, N'Usuarios', 50)
-- 10 suc 1,  50 suc 2 100 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (11, N'Secciones', 10)
-- 10 suc 1,  20 suc 2 30 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (12, N'Pais', 10)
-- 100 suc 1,  200 suc 2 300 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (13, N'Estado', 100)
-- 3000 suc 1,  4000 suc 2 5000 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (14, N'Municipio', 3000)
-- 600 suc 1,  700 suc 2 800 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (15, N'ConceptoInventario', 600)
-- 600 suc 1,  700 suc 2 800 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (16, N'CAT_CONCEPTOSINV', 600)
SET IDENTITY_INSERT [dbo].[FoliosInternos] OFF
GO


--- folios iniciales SUC 2

USE [DB_Mendez]
GO

DELETE FROM DB_Mendez.[dbo].[FoliosInternos]

SET IDENTITY_INSERT [dbo].[FoliosInternos] ON 

INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (1, N'OrdenCompra', 1)
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (2, N'Tickets', 1)
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (3, N'Presupuesto', 1)
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (4, N'InventarioMovimientos', 1)
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (6, N'Traspaso', 1)
-- 20k suc 1 40k suc 2, 60k suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (5, N'Clientes', 40000)
-- 2000 suc 1, 22000 suc 2 32000 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (7, N'Articulos', 22000)
-- 200 suc 1, 300 suc 2 400 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (8, N'Marcas', 300)
-- 50 suc 1,  200 suc 2 300 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (9, N'Proveedores', 200)
-- 50 suc 1,  200 suc 2 300 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (10, N'Usuarios', 200)
-- 10 suc 1,  50 suc 2 100 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (11, N'Secciones', 50)
-- 10 suc 1,  20 suc 2 30 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (12, N'Pais', 20)
-- 100 suc 1,  200 suc 2 300 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (13, N'Estado', 200)
-- 3000 suc 1,  4000 suc 2 5000 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (14, N'Municipio', 4000)
-- 600 suc 1,  700 suc 2 800 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (15, N'ConceptoInventario', 700)
-- 600 suc 1,  700 suc 2 800 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (16, N'CAT_CONCEPTOSINV', 700)
SET IDENTITY_INSERT [dbo].[FoliosInternos] OFF
GO

--- folios iniciales SUC 3

USE [DB_Mendez]
GO

DELETE FROM DB_Mendez.[dbo].[FoliosInternos]

SET IDENTITY_INSERT [dbo].[FoliosInternos] ON 

INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (1, N'OrdenCompra', 1)
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (2, N'Tickets', 1)
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (3, N'Presupuesto', 1)
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (4, N'InventarioMovimientos', 1)
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (6, N'Traspaso', 1)
-- 20k suc 1 40k suc 2, 60k suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (5, N'Clientes', 60000)
-- 2000 suc 1, 22000 suc 2 32000 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (7, N'Articulos', 32000)
-- 200 suc 1, 300 suc 2 400 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (8, N'Marcas', 400)
-- 50 suc 1,  200 suc 2 300 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (9, N'Proveedores', 300)
-- 50 suc 1,  200 suc 2 300 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (10, N'Usuarios', 300)
-- 10 suc 1,  50 suc 2 100 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (11, N'Secciones', 100)
-- 10 suc 1,  20 suc 2 30 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (12, N'Pais', 30)
-- 100 suc 1,  200 suc 2 300 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (13, N'Estado', 300)
-- 3000 suc 1,  4000 suc 2 5000 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (14, N'Municipio', 5000)
-- 600 suc 1,  700 suc 2 800 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (15, N'ConceptoInventario', 800)
-- 600 suc 1,  700 suc 2 800 suc 3
INSERT [dbo].[FoliosInternos] ([Id], [Tabla], [Folio]) VALUES (16, N'CAT_CONCEPTOSINV', 800)
SET IDENTITY_INSERT [dbo].[FoliosInternos] OFF
GO


m2QjMQJx7KXmZp9CC4uWghdUvWoxSU5cRj/sA/pbfwhtUUUnCHjlJpZAGip+JrxTxUlX702KX5X3UB2gcJaREa/OH+AtI6SRRU2t8gf6L9uh66UCpUtBBnv229NjaRa346YV3XrUY/mguPNI5OUgDEck0nUKCFPLkWUbmmEYtBI=

R7U1bbFHn45619zeJNg+bHTAbv+/knd2iKRq6PVafpqMf3GSwJxMjZfRaAcZqvUCTyE2IHODrdqGrynV2imYrVL2D/Gf4mVKv/I3xsDsvKEs8txIinzR5Jcuv48aWTN/0dCopSNU/3hqCbaj2c0Oi9Uprmzq58TkibObPITlCRc=
