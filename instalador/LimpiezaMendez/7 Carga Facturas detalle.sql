use DB_Mendez
go

 INSERT INTO [FacturasDetalle](Id, [FacturaId]
      ,[Serie],[Folio],[IdTicket],[SucursalId],[Partida],[ClaveProdServ],[ClaveUnidad],[Articulo],[Descripcion]
      ,[Cantidad],[Unidad],[ValorUnitario],[Importe],[Descuento],[ObjetoImp],[BaseIva],Iva
      ,[IvaVal],BaseIeps,[Ieps],[IepsVal],[Total],[UsuarioId],[QUIEN],[CUANDO],[EQUIPO],[Enviado],[Version])

select ROW_NUMBER() over(order by serie) as Id, NULL factura,Serie,Folio,NULL IdTicket,1 sucursal,
partida, (SELECT cc.C_CLAVEPRODSERV from dbo.CAT_CLAVEPRODSERV cc WHERE cc.DESCRIPCION = d.CLAVEPRODSERV) CLAVEPRODSERV,
(SELECT cc.C_CLAVEUNIDAD from dbo.CAT_CLAVEUNIDAD cc WHERE cc.NOMBRE = d.CLAVEUNIDAD) CLAVEUNIDAD,ARTICULO, DESCRIPART,
cantidad,unidad,Precio,(case when Importe IS NULL THEN 0 ELSE IMPORTE end),Descuento,NULL ObjIpuesto,
0 base1,IMpuesto1 iva,Impuesto ivaval,
0 base2, 0 ieps,0 iepsval,0 as total,null usuarioid, d.QUIEN, d.CUANDO, d.DONDE,1 as enviado,1 as versionr
   FROM DB_MUEBLERIA.dbo.DETFAC d