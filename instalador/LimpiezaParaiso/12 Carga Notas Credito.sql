USE [DB_Paraiso]
GO

 INSERT into NotasCredito(Id, TicketId, [SucursalId] ,[ClienteId]
      ,[Historico],[Version] ,[Serie] ,[Folio] ,[UUID] ,[Fecha]  ,[FormaPago] ,[FormaPagoDesc]
      ,[NoCertificado] ,[SubTotal]    ,[Descuento]  ,[Moneda] ,[TipoCambio] ,[Total]  ,[TipoDeComprobante]
      ,[TipoDeComprobanteDesc] ,[MetodoPago],[MetodoPagoDesc]
      ,[LugarExpedicion] ,[Emisor_Rfc],[Emisor_RegimenFiscal] ,[Emisor_RegimenFiscalDesc]
      ,[Emisor_Nombre]  ,[Receptor_Rfc] ,[Receptor_Nombre],[Direccion]
      ,[DomicilioFiscalReceptor]  ,[RegimenFiscalReceptor]
      ,[RegimenFiscalReceptorDesc] ,[UsoCFDI] ,[UsoCFDIDesc] ,
    [UsuarioId] ,[QUIEN]  ,[CUANDO]   ,[EQUIPO] ,[Cancelado] ,[Enviado],Facturado, VersionRegistro)

SELECT row_number() over(order by n.fecha) as Id, 0 as ticket, 1 sucursal,n.CLIENTE,1 hist,'' ver,n.NCRSERIE,d.FOLIO,
 d.UUID,n.FECHA,
 (SELECT cf.C_FORMAPAGO from dbo.CAT_FORMAPAGO cf WHERE cf.DESCRIPCION = n.FORMAPAGO) AS fpag,
 n.FORMAPAGO,d.NOCERTIFICADO,n.SUBTOTAL, n.TOTALDESCUENTO,
 'MXN' moneda,1 cambio,
  n.TOTAL,
 (SELECT ct.C_TIPODECOMPROBANTE FROM [DB_COMPIDTFAC].dbo.CAT_TIPODECOMPROBANTE ct WHERE ct.DESCRIPCION = n.TIPODECOMPROBANTE) AS tipo
 , n.TIPODECOMPROBANTE,(SELECT cm.C_METODOPAGO from dbo.CAT_METODOPAGO cm WHERE cm.C_METODOPAGO = n.METODOPAGO) mclave,
  n.METODOPAGO, (SELECT v.CP from [DB_COMPIDTFAC].dbo.VARSIS v) expedicion,
  (SELECT v.RFC from [DB_COMPIDTFAC].dbo.VARSIS v) emirsorrfc,
  (SELECT cr.C_REGIMENFISCAL from dbo.CAT_REGIMENFISCAL cr WHERE cr.DESCRIPCION = n.REGIMEN) regimen,
   n.REGIMEN ,(SELECT v.contribuyente from [DB_COMPIDTFAC].dbo.VARSIS v) emirsornombre,
   (SELECT c.rfc FROM dbo.Clientes c WHERE c.id = n.cliente) AS rfc,
   (SELECT c.Nombre FROM dbo.Clientes c WHERE c.id = n.cliente) AS nombrere,
   (SELECT c.Direccion FROM dbo.Clientes c WHERE c.id = n.cliente) AS nombrere,
    (SELECT c.CP FROM dbo.Clientes c WHERE c.id = n.cliente) AS domfiscal,
   '' regimenres,
   '' regrecept,
   (SELECT cu.C_USOCFDI from dbo.CAT_USOCFDI cu WHERE cu.DESCRIPCION = n.USOCFDI) usocve,
   n.USOCFDI,
   0 ussa,n.QUIEN, n.CUANDO, n.DONDE,0,1,1,1   
     FROM [DB_COMPIDTFAC].dbo.NCRDEVOLUCION n LEFT JOIN
[DB_COMPIDTFAC].dbo.DATOSELECTRONICA d on(n.NCRSERIE = d.SERIE AND n.FOLIO = d.FOLIO) 
