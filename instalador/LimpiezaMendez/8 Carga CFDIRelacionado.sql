use DB_Mendez
go

INSERT INTO [CfdiRelacionado] ([Id],[UUIDRef]
      ,[TipoRelacion]
      ,[TipoRelacionDesc]
      ,[Serie]
      ,[Folio]
      ,[UUID]
      ,[Fecha]
	  ,[UsuarioId]
	  ,[QUIEN]
	  ,[CUANDO]
	  ,[EQUIPO]
      ,[Enviado]
	  ,[Version])
SELECT ROW_NUMBER() over(order by UUID) as id, UUID,
 (SELECT ct.C_TIPORELACION from dbo.CAT_TIPORELACION ct WHERE ct.DESCRIPCION = r.TIPORELACION) tipo,
 r.TIPORELACION, r.SERIE,r.FOLIO, r.UUID,r.FECHA,null,'SCRIPT',GETDATE(),'DATABASE',1 enviado, 1 AS VERSION1
 FROM DB_MUEBLERIA.dbo.COMP_RELACIONADOS r

 go