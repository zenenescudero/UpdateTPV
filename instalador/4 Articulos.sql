
use [DB_Paraiso] 

go


INSERT INTO articulos(
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
            WHERE m.Marca =(SELECT TOP 1 Marca FROM  [DB_COMPIDTFAC].dbo.marcas m1 WHERE m1.CODIGOMARCA = a.CODIGOMARCA) 
            and m.Descripcion =(SELECT TOP 1 m2.DESCRIPCION FROM  [DB_COMPIDTFAC].dbo.marcas m2 WHERE m2.CODIGOMARCA = a.CODIGOMARCA)) MarcaId
,1 Activo
,a.Unidad,a.BARRAS
,(SELECT cc.C_CLAVEPRODSERV from [DB_COMPIDTFAC].dbo.CAT_CLAVEPRODSERV cc WHERE cc.DESCRIPCION = a.CLAVEPRODSERV) CLAVEPRODSERV
,a.CLAVEPRODSERV CLAVEPRODSERVDesc
,(SELECT ccM.C_CLAVEUNIDAD from [DB_COMPIDTFAC].dbo.CAT_CLAVEUNIDAD ccM WHERE ccM.NOMBRE = a.CLAVEUNIDAD) CLAVEUNIDAD
,a.CLAVEUNIDAD CLAVEUNIDADDesc
,cast(a.COSTOLISTA AS decimal(15,4)) as PrecioCompra
,cast(P.MARGEN AS decimal(15,4)) as margen 
, 0 as exento
,0 PUnitario
,cast( a.Impuesto1 AS decimal(15,4)) as Iva
,cast( isnull(a.Impuesto2,0) AS decimal(15,4)) Ieps
,0 as IvaVal
,cast(0 as decimal(15,4)) IepsVal
 , Pventa = 0
 ,cast(P.MARGENESPECIAL AS decimal(15,3)) Margen3
 ,0 precio3
 ,cast(P.MARGENMINIMO AS decimal(15,4)) Margen6
 ,0 precio6
 ,cast(P.MARGENMAYOREO AS decimal(15,4)) margen9
  ,Pecio9  = 0
 ,0 margen12
 ,Precio12 = 0
 ,0 margen18  
 ,Precio18 = 0
 ,0 as usuarioid
 ,a.QUIEN
 ,a.CUANDO
 ,a.DONDE
 ,1 as enviado
 ,1 as [Version]
 FROM [DB_COMPIDTFAC].dbo.ARTICULOS a
	left JOIN [DB_COMPIDTFAC].dbo.PREMARART P ON a.ARTICULO=P.ARTICULO 
 WHERE a.CLAVEPRODSERV IS NOT NULL

 go


-- MARGEN 3
 -- calcular precio unitario
update Articulos set PrecioUnitario = (PrecioCompra * (1 + (Margen3/100)))
go
-- calcular impuesto ieps
update Articulos set ImpuestoIepsVal = (PrecioUnitario * ((ImpuestoIeps/100)))
go
 -- calcular impuesto iva
 go
  update Articulos set ImpuestoIvaVal = ((PrecioUnitario + ImpuestoIepsVal) * ((ImpuestoIva/100)))
go
-- calcular precio de venta
update Articulos set Precio3 = round((PrecioUnitario + ImpuestoIvaVal + ImpuestoIepsVal),2)
go

-- MARGEN 6

 -- calcular precio unitario
update Articulos set PrecioUnitario = (PrecioCompra * (1 + (Margen6/100)))
go
-- calcular impuesto ieps
update Articulos set ImpuestoIepsVal = (PrecioUnitario * ((ImpuestoIeps/100)))
go
 -- calcular impuesto iva
 go
  update Articulos set ImpuestoIvaVal = ((PrecioUnitario + ImpuestoIepsVal) * ((ImpuestoIva/100)))
go
-- calcular precio de venta
update Articulos set Precio6 = round((PrecioUnitario + ImpuestoIvaVal + ImpuestoIepsVal),2)
go

-- CONTADO
 -- calcular precio unitario
update Articulos set PrecioUnitario = (PrecioCompra * (1 + (Margen/100)))
go
-- calcular impuesto ieps
update Articulos set ImpuestoIepsVal = (PrecioUnitario * ((ImpuestoIeps/100)))
go
 -- calcular impuesto iva
 go
  update Articulos set ImpuestoIvaVal = ((PrecioUnitario + ImpuestoIepsVal) * ((ImpuestoIva/100)))
go
-- calcular precio de venta
update Articulos set PrecioVenta = round((PrecioUnitario + ImpuestoIvaVal + ImpuestoIepsVal),2)
go