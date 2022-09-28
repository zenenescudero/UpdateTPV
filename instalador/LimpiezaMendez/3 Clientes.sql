
use DB_Mendez
go

INSERT into Clientes([Id],[Nombre],[Direccion]
      ,[Colonia],[Ciudad] ,[Estado],[CP]
      ,[RFC] ,[UsoCFDI] ,[UsoCFDIDesc] ,[LADA]
      ,[Telefono1],[Telefono2] ,[Limite],[Observaciones]
      ,[Email] ,[Pais] ,[FormaPago],[FormaPagoDesc],[Activo],Enviado, [Version], [QUIEN],[CUANDO],[EQUIPO])
SELECT c.CLIENTE,c.NOMBRE,c.DIRECCION,c.COLONIA,c.CIUDAD,c.ESTADO,c.CP
, c.RFC,'G03','Gastos en general',c.LADA,c.TEL1,c.TEL2,c.LIMITE,c.OBSERVACIONES,c.EMAIL,c.PAIS,
(SELECT cf.C_FORMAPAGO from DB_MUEBLERIA.dbo.CAT_FORMAPAGO cf WHERE cf.DESCRIPCION = c.FORMA_PAGO),
(SELECT cf.DESCRIPCION from DB_MUEBLERIA.dbo.CAT_FORMAPAGO cf WHERE cf.DESCRIPCION = c.FORMA_PAGO),
c.ACTIVO,1,1,c.QUIEN,c.CUANDO, c.DONDE
 FROM DB_MUEBLERIA.dbo.Clientes c

 go

  update Clientes set RegimenFiscal = '616', RegimenFiscalDescripcion = 'Sin obligaciones fiscales' where RFC = 'XAXX010101000'