
USE [DB_Paraiso]
GO 

INSERT INTO
facturas (Id,[SucursalId],[ClienteId],[Historico],[Version],[Serie],[Folio],[UUID],[Fecha],[FormaPago],[FormaPagoDesc],
  [NoCertificado],[CondicionesDePago],[Plazo],[SubTotal],[Impuestos]
      ,[Descuento],[Moneda],[TipoCambio],[Total],[TipoDeComprobante],[TipoDeComprobanteDesc],
      [MetodoPago],[MetodoPagoDesc],[LugarExpedicion],[InformacionGlobal_Periodicidad],[InformacionGlobal_Mes],[Emisor_Rfc]
      ,[Emisor_RegimenFiscal],[Emisor_RegimenFiscalDesc],[Emisor_Nombre],[Receptor_Rfc],[Receptor_Nombre],
      [Direccion],[DomicilioFiscalReceptor],[RegimenFiscalReceptor],[RegimenFiscalReceptorDesc]
      ,[UsoCFDI] ,[UsoCFDIDesc],[UsuarioId],[QUIEN],[CUANDO] ,[EQUIPO],[Cancelado],[Enviado],[EnviadoCliente],VersionRegistro
    )
SELECT row_number() over(order by sucursal) as Id, 1 sucursal,f.cliente, 1 historico,'' version,f.Serie,cast(f.Folio AS int),
de.UUID,
f.Fecha,(SELECT cf.C_FORMAPAGO from  [DB_COMPIDTFAC].dbo.CAT_FORMAPAGO cf WHERE cf.DESCRIPCION = f.FORMAPAGO) FormaPago ,
 isnull(substring(f.FORMAPAGO,1,50),'') AS formapagodes ,de.NOCERTIFICADO,'',f.Plazo,f.SubTotal, f.TotalImpuesto,f.DESCUENTO,'MXN' moneda, 1 tpcambio,
 f.TOTAL,(SELECT ct.C_TIPODECOMPROBANTE FROM  [DB_COMPIDTFAC].dbo.CAT_TIPODECOMPROBANTE ct WHERE ct.DESCRIPCION = f.TIPODECOMPROBANTE) tipo,
  f.TIPODECOMPROBANTE,(SELECT cm.C_METODOPAGO FROM  [DB_COMPIDTFAC].dbo.CAT_METODOPAGO cm WHERE cm.DESCRIPCION = f.METODOPAGO) AS clave, 
  substring(f.METODOPAGO,1,50), (CASE when len(f.LUGAREXPEDICION) = 5 then f.LUGAREXPEDICION ELSE '' end), 
  '' periodicidad,'' mes, (SELECT vrs.RFC FROM [DB_COMPIDTFAC].dbo.VARSIS vrs) AS rfcemisor,
  (SELECT cr.C_REGIMENFISCAL from dbo.CAT_REGIMENFISCAL cr WHERE cr.DESCRIPCION= f.REGIMEN) regimen, f.REGIMEN reg,
   (SELECT vrs.contribuyente FROM [DB_COMPIDTFAC].dbo.VARSIS vrs) AS rfceminobr, f.RFC , f.Nombre,f.Direccion,f.CP,
  '' regimen, '' reg2,(SELECT cu.C_USOCFDI from  [DB_COMPIDTFAC].dbo.CAT_USOCFDI cu WHERE cu.DESCRIPCION = f.USOCFDI), f.USOCFDI,
  null,f.QUIEN,f.CUANDO,f.DONDE , f.Cancelada,1 as enviado,1 as enviadocliente,1 as versionregistro
 FROM [DB_COMPIDTFAC].dbo.FACTURAS f
 LEFT JOIN  [DB_COMPIDTFAC].dbo.DATOSELECTRONICA de on(f.Serie = de.SERIE AND f.Folio = de.FOLIO)

 order by f.Plazo desc

