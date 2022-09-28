
use DB_Mendez 

go


INSERT INTO DB_Mendez.dbo.articulos(
       [Id],[ARTICULO] ,[Descripcion]
      ,[ProveedorId] ,[SeccionId]
      ,[MarcaId] ,[Activo]
      ,[Unidad]  ,[BARRAS]
      ,[CLAVEPRODSERV]  ,[CLAVEPRODSERV_Desc]
      ,[CLAVEUNIDAD] ,[CLAVEUNIDAD_Desc]
      ,[PrecioCompra]  ,[Margen], [Exento]
      ,[PrecioUnitario] ,[ImpuestoIva]
      ,[ImpuestoIeps]    ,[ImpuestoIvaVal]
      ,[ImpuestoIepsVal],[PrecioVenta]
      ,[Margen3],[Precio3],[Margen6]
      ,[Precio6] ,[Margen9] ,[Precio9]
      ,[Margen12] ,[Precio12] ,[Margen18] ,[Precio18]
         ,[UsuarioId],[QUIEN],[CUANDO],[EQUIPO],[Enviado],[Version])
SELECT ROW_NUMBER()  over (order by a.ARTICULO) Id, a.ARTICULO,a.DESCRIPCION
,(SELECT TOP 1 Id FROM Proveedores p WHERE p.Proveedor = a.Proveedor) ProveedorId
,(SELECT TOP 1 Id FROM CAT_SECCIONES s WHERE s.Id = a.CODIGOSECCION) SeccionId
,(SELECT TOP 1 Id FROM CAT_MARCAS m 
            WHERE m.Marca =(SELECT TOP 1 Marca FROM  DB_MUEBLERIA.dbo.marcas m1 WHERE m1.CODIGOMARCA = a.CODIGOMARCA) 
            and m.Descripcion =(SELECT TOP 1 m2.DESCRIPCION FROM  DB_MUEBLERIA.dbo.marcas m2 WHERE m2.CODIGOMARCA = a.CODIGOMARCA)) MarcaId
,1 Activo
,a.Unidad,a.BARRAS
,(SELECT cc.C_CLAVEPRODSERV from DB_MUEBLERIA.dbo.CAT_CLAVEPRODSERV cc WHERE cc.DESCRIPCION = a.CLAVEPRODSERV) CLAVEPRODSERV
,a.CLAVEPRODSERV CLAVEPRODSERVDesc
,(SELECT ccM.C_CLAVEUNIDAD from DB_MUEBLERIA.dbo.CAT_CLAVEUNIDAD ccM WHERE ccM.NOMBRE = a.CLAVEUNIDAD) CLAVEUNIDAD
,a.CLAVEUNIDAD CLAVEUNIDADDesc
,cast(a.COSTOLISTA AS decimal(15,4)) as PrecioCompra
,cast(P.MARGEN AS decimal(15,4)) as margen 
, 0 as exento
,p.PRECIO PUnitario
,cast( a.Impuesto1 AS decimal(15,4)) as Iva
,cast(0 AS decimal(15,4)) Ieps
,0 as IvaVal
,cast(0 as decimal(15,4)) IepsVal
 , Pventa =p.PRECIO
 ,cast(P.MARGENESPECIAL AS decimal(15,3)) Margen3
 ,p.ESPECIAL precio3
 ,cast(P.MARGENMINIMO AS decimal(15,4)) Margen6
 ,p.PRECIOMINIMO precio6
 ,cast(P.MARGENMAYOREO AS decimal(15,4)) margen9
  ,Pecio9  = p.MAYOREO
 ,cast(P.MARGENDOCE AS decimal(15,4)) margen12
 ,Precio12 = p.DOCE
 ,cast(P.MARGENDIECIOCHO AS decimal(15,4)) margen18  
 ,Precio18 = p.DIECIOCHO
 ,0 as usuarioid
 ,a.QUIEN
 ,a.CUANDO
 ,a.DONDE
 ,1 as enviado
 ,1 as [Version]
 FROM DB_MUEBLERIA.dbo.ARTICULOS a
       left JOIN DB_MUEBLERIA.dbo.PREMARART P ON a.ARTICULO=P.ARTICULO 
 WHERE a.CLAVEPRODSERV IS NOT NULL

 go

-- MARGEN 3
-- calcular impuesto ieps
update DB_Mendez.dbo.Articulos set ImpuestoIepsVal = (Precio3 * ((ImpuestoIeps/100)))
go
 -- calcular impuesto iva
 go
  update DB_Mendez.dbo.Articulos set ImpuestoIvaVal = ((Precio3 + ImpuestoIepsVal) * ((ImpuestoIva/100)))
go
-- calcular precio de venta
update DB_Mendez.dbo.Articulos set Precio3 = round((Precio3 + ImpuestoIvaVal + ImpuestoIepsVal),2)
go

-- MARGEN 6

-- calcular impuesto ieps
update DB_Mendez.dbo.Articulos set ImpuestoIepsVal = (Precio6 * ((ImpuestoIeps/100)))
go
 -- calcular impuesto iva
 go
  update DB_Mendez.dbo.Articulos set ImpuestoIvaVal = ((Precio6 + ImpuestoIepsVal) * ((ImpuestoIva/100)))
go
-- calcular precio de venta
update DB_Mendez.dbo.Articulos set Precio6 = round((Precio6 + ImpuestoIvaVal + ImpuestoIepsVal),2)
go


-- MARGEN 9

-- calcular impuesto ieps
update DB_Mendez.dbo.Articulos set ImpuestoIepsVal = (Precio9 * ((ImpuestoIeps/100)))
go
 -- calcular impuesto iva
 go
  update DB_Mendez.dbo.Articulos set ImpuestoIvaVal = ((Precio9 + ImpuestoIepsVal) * ((ImpuestoIva/100)))
go
-- calcular precio de venta
update DB_Mendez.dbo.Articulos set Precio9 = round((Precio9 + ImpuestoIvaVal + ImpuestoIepsVal),2)
go


-- MARGEN 12

-- calcular impuesto ieps
update DB_Mendez.dbo.Articulos set ImpuestoIepsVal = (Precio12 * ((ImpuestoIeps/100)))
go
 -- calcular impuesto iva
 go
  update DB_Mendez.dbo.Articulos set ImpuestoIvaVal = ((Precio12 + ImpuestoIepsVal) * ((ImpuestoIva/100)))
go
-- calcular precio de venta
update DB_Mendez.dbo.Articulos set Precio12 = round((Precio12 + ImpuestoIvaVal + ImpuestoIepsVal),2)
go


-- MARGEN 12

-- calcular impuesto ieps
update DB_Mendez.dbo.Articulos set ImpuestoIepsVal = (Precio18 * ((ImpuestoIeps/100)))
go
 -- calcular impuesto iva
 go
  update DB_Mendez.dbo.Articulos set ImpuestoIvaVal = ((Precio18 + ImpuestoIepsVal) * ((ImpuestoIva/100)))
go
-- calcular precio de venta
update DB_Mendez.dbo.Articulos set Precio18 = round((Precio18 + ImpuestoIvaVal + ImpuestoIepsVal),2)
go

-- CONTADO
-- calcular impuesto ieps
update DB_Mendez.dbo.Articulos set ImpuestoIepsVal = (PrecioVenta * ((ImpuestoIeps/100)))
go
 -- calcular impuesto iva
 go
  update DB_Mendez.dbo.Articulos set ImpuestoIvaVal = ((PrecioVenta + ImpuestoIepsVal) * ((ImpuestoIva/100)))
go
-- calcular precio de venta
update DB_Mendez.dbo.Articulos set PrecioVenta = round((PrecioVenta + ImpuestoIvaVal + ImpuestoIepsVal),2)
go
