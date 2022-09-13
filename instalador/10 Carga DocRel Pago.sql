USE [DB_Paraiso]
GO
  INSERT INTO DocRelPago(Id,TicketId, [Partida]
      ,[Serie],[Folio],[IdDocumento],[SerieF],[FolioF],[FolioPago],[MonedaDR],[EquivalenciaDR],[NumParcialidad]
      ,[ImpSaldoAnt],[ImpPagado],[ImpSaldoInsoluto],[ObjetoImpDR],[ObjetoImpDRDesc],[Cancelado],[Facturado],[UsuarioId],[QUIEN],[CUANDO],[EQUIPO],[Enviado],[VersionRegistro])
  SELECT ROW_NUMBER() over(order by p.FOLIO) as Id,0, P.PARTIDA,
       P.SERIE,P.FOLIO,
     P.IDDOCUMENTO, P.SERIEF, P.FOLIOF,
     P.FOLPAGO,'MXN',P.TIPOCAMBIODR,
     P.NUMPARCIALIDAD,P.IMPSALDOANT, P.IMPPAGADO, 
     P.IMPSALDOINSOLUTO,'', '', 0 cancelado,1 facturado,null as usiarioid,'script',GETDATE(),'DATABASE',1 enviado, 1 versione
	 FROM [DB_COMPIDTFAC].dbo.PAGOS_DETDR P