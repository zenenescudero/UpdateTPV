USE [DB_Paraiso]
GO

 INSERT INTO EstadoCuenta(Id,[SucursalId],[Historico],[TicketId]
      ,[ConceptoCXC],[ConceptoCXCDesc],[Serie],[Folio],[uuid],[ClienteId],[Moneda],[TipoCambio],[Fecha],[FechaCancelacion],[Plazo]
      ,[SeriePadre],[FolioPadre],[UUID_Padre],[EsPadre],[Cargo],[Abono],[SubTotal],[Iva],[Ieps],[Total],[Saldo]
      ,[Observaciones],[UsuarioId],[QUIEN],[CUANDO],[EQUIPO],[Cancelado],[Enviado],[Version])
SELECT ROW_NUMBER() over(order by sucursal) id, SUCURSAL, 
1,0,
c.CONCEPTOCXC,
(SELECT c2.DESCRIPCION from [DB_COMPIDTFAC].dbo.CONCEPTOCXC c2 WHERE c2.CONCEPTOCXC = c.CONCEPTOCXC),'' serie,
c.FOLIO,'' as UUUID,c.CLIENTE,'MXN' MONEDA,c.TIPOCAMBIO,c.FECHA,c.FECHACANCEL, c.PLAZO,c.CPTOPADRE,
c.FOLIOPADRE,'' as UUIDPadre,c.ESPADRE,c.CARGO,c.ABONO,c.SUBTOTAL,c.IVA,0 IEPS ,c.TOTAL,c.SALDO,
c.OBSERVACIONES, NULL userid,c.QUIEN,c.CUANDO,c.DONDE,
(CASE when c.FECHACANCEL IS NOT null THEN 1 ELSE 0 end) cancelado,1 enviado ,1
FROM [DB_COMPIDTFAC].dbo.COBRAR c