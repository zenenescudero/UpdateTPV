
use DB_Mendez
go

INSERT INTO DB_Mendez.dbo.[ComplementoPago]([Id],[TicketId],[SucursalId]
      ,[ClienteId],[Historico]
      ,[Version] ,[Serie] ,[Folio],[UUID],[Fecha]
      ,[NoCertificado] ,[LugarExpedicion] ,[Emisor_Rfc]
      ,[Emisor_RegimenFiscal],[Emisor_RegimenFiscalDesc]
      ,[Emisor_Nombre],[Receptor_Rfc]
      ,[Receptor_RegimenFiscal],[Receptor_RegimenFiscalDesc]
      ,[Receptor_Nombre],[Direccion] ,[DomicilioFiscalReceptor] ,
    [TotalTrasladosBaseIVA16]
      ,[TotalTrasladosImpuestoIVA16],
    [TotalTrasladosBaseIVA8]
      ,[TotalTrasladosImpuestoIVA8],
    [TotalTrasladosBaseIVA0]
      ,[TotalTrasladosImpuestoIVA0],[TotalTrasladosBaseIVAExento],[MontoTotalPagos],[FechaPago]
      ,[FormaPago],[FormaPagoDesc],[MonedaP],[TipoCambioP],[Monto],[NumOperacion],[RfcEmisorCtaOrd],
      [NomBancoOrdExt],[CtaOrdenante],[RfcEmisorCtaBen],[CtaBeneficiario],[TipoCadPago],[CertPago],
      [CadPago],[SelloPago],[UsuarioId],[QUIEN],[CUANDO],[EQUIPO],[Cancelado],[Enviado],[Facturado],VersionRegistro)

  SELECT
  ROW_NUMBER() over(order by p.Folio) as id,
  0,
1 suc,P.Cliente,1 historico,
 RP.VERSION, P.Serie,P.Folio,
D.UUID, d.FECHATIMBRADO AS FECHA,d.NOCERTIFICADO,
P.LUGAREXPEDICION,(SELECT vrs.RFC FROM DB_MUEBLERIA.dbo.VARSIS vrs) AS rfc,
(SELECT cr.C_REGIMENFISCAL from DB_MUEBLERIA.dbo.CAT_REGIMENFISCAL cr WHERE cr.DESCRIPCION = p.REGIMEN) AS rclave,
 P.REGIMEN,(SELECT vrs.contribuyente FROM DB_MUEBLERIA.dbo.VARSIS vrs) AS nombre,
 P.RFC,'' reg, '' regdes,P.Nombre,P.Direccion,P.CP domfiscal,
 0 base,0 imp16,0 base8,0 imp8,0 base0,0 imp0,0 impExcento, RP.MONTO, RP.FECHAPAGO,
 (SELECT cf.C_FORMAPAGO from DB_MUEBLERIA.dbo.CAT_FORMAPAGO cf WHERE cf.DESCRIPCION = rp.FORMADEPAGOP) AS clave,
  RP.FORMADEPAGOP,'MXN' AS moneda, RP.TIPOCAMBIOP,RP.MONTO,
  RP.NUMOPERACION,RP.RFCEMISORCTAORD, RP.NOMBANEXTORD, RP.CTAORDENANTE,
  RP.RFCEMISORCTABEN, RP.CTABENEFICIARIO, RP.TIPOCADPAGO,
  RP.CERTPAGO, RP.CADPAGO, RP.SELLOPAGO, null, P.QUIEN, P.CUANDO, P.DONDE,P.Cancelada, 1,1,1
 FROM DB_MUEBLERIA.dbo.PAGOS33 P INNER JOIN DB_MUEBLERIA.dbo.RECEPCION_PAGOS RP ON(P.Serie = RP.SERIE AND P.Folio = RP.FOLIO)
 LEFT JOIN DB_MUEBLERIA.dbo.DATOSELECTRONICA d ON(D.Serie = RP.SERIE AND D.Folio = RP.FOLIO)
