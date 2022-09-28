USE [DB_Paraiso]
GO

INSERT INTO NotasCreditoDetalle(Id,NotaCreditoId
      ,[Serie],[Folio],[SucursalId],[Partida]
      ,[ClaveProdServ],[ClaveUnidad],[Articulo]
      ,[Descripcion],[Cantidad],[Unidad],[ValorUnitario]
      ,[Importe] ,[Descuento],[ObjetoImp],[Iva]
      ,[IvaVal] ,[Ieps] ,[IepsVal],[Enviado],[version])

select ROW_NUMBER() over(order by d.Folio) as id, 0 as NotaId,d.NCRSERIE , d.Folio,1 sucursal,d.Partida,
(SELECT cc.C_CLAVEPRODSERV from [DB_COMPIDTFAC].dbo.CAT_CLAVEPRODSERV
   cc WHERE cc.DESCRIPCION = d.CLAVEPRODSERV) servicio,
(SELECT cc.C_CLAVEUNIDAD from dbo.CAT_CLAVEUNIDAD cc WHERE cc.NOMBRE = d.CLAVEUNIDAD) unidadc,
d.Articulo,d.DescripArt,d.Cantidad,
d.Unidad,d.Precio,(CASE when d.IMPORTE IS NULL THEN 0 ELSE d.IMPORTE end),d.Descuento,'' objim, d.Impuesto1,  0 val, 0 val, 0 val,
1 enviado, 1 as versione
 FROM [DB_COMPIDTFAC].dbo.DETNCR d
