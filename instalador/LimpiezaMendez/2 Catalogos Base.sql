use DB_Mendez

go

INSERT INTO CAT_CLAVEUNIDAD
SELECT * FROM DB_MUEBLERIA.dbo.CAT_CLAVEUNIDAD WHERE NOMBRE in
(SELECT DISTINCT CLAVEUNIDAD FROM DB_MUEBLERIA.dbo.ARTICULOS a WHERE a.CLAVEUNIDAD IS NOT NULL)

go

INSERT INTO CAT_CLAVEPRODSERV
SELECT * FROM DB_MUEBLERIA.dbo.CAT_CLAVEPRODSERV WHERE DESCRIPCION in
(SELECT DISTINCT CLAVEPRODSERV FROM DB_MUEBLERIA.dbo.ARTICULOS a WHERE a.CLAVEPRODSERV IS NOT NULL)

go

INSERT INTO CAT_MARCAS(Id,Marca,[Descripcion],[Enviado],[Version],[Activo])
SELECT distinct ROW_NUMBER() over(order by marca) as id, Marca,m2.DESCRIPCION,1,1,1 FROM DB_MUEBLERIA.dbo.MARCAS m2 WHERE m2.CODIGOMARCA in(
SELECT distinct a.CODIGOMARCA FROM DB_MUEBLERIA.dbo.ARTICULOS a WHERE a.CLAVEPRODSERV IS NOT null)

go


INSERT into CAT_SECCIONES(Id,[Seccion],[Descripcion],[Enviado],[Version],[Activo])
SELECT ROW_NUMBER() over(order by s.Seccion) as Id, s.SECCION,s.DESCRIPCION,1,1,1 FROM DB_MUEBLERIA.dbo.SECCIONES s 


go

  INSERT INTO [Proveedores]
    SELECT ROW_NUMBER() over(order by p.Proveedor) as id, p.Proveedor,p.Nombre,p.Beneficiario, p.DIRECCION,p.Colonia,p.Ciudad,p.Estado,p.CP,
    p.PAIS,p.RFC,p.lada,p.TEL1,p.TEL2,p.Fax,p.EMAIL,p.Observaciones,p.CONTACTO,'', 1,null,QUIEN,CUANDO,DONDE,1,1
     FROM DB_MUEBLERIA.dbo.PROVEEDORES p

go

INSERT INTO Sucursales
    SELECT p.SUCURSAL, p.DESCRIPCION, p.DIRECCION,p.Colonia,p.Ciudad,p.Estado,p.MUNICIPIO,
    p.PAIS, p.LADA, p.TELEFONO,'', p.FAX,p.CP,1,'FE',1000,'PA',1000,'NC',1000
     FROM DB_MUEBLERIA.dbo.SUCURSALES p
go

INSERT INTO Usuarios
    SELECT ROW_NUMBER() over(order by nombre) id, o.LOGIN, o.NOMBRE, o.PASSWORD, o.ACTIVO,null,QUIEN,CUANDO,DONDE,1,1
     FROM DB_MUEBLERIA.dbo.Usuarios o

go

insert into CAT_UNIDADES([Id]
      ,[Unidad],[Nombre],[Principal]
      ,[Activo] ,[UsuarioId]
      ,[QUIEN] ,[CUANDO]
      ,[EQUIPO],[Enviado]
      ,[Version])
select ROW_NUMBER() over(order by Unidad) as id,
Unidad,Nombre,1 as principal,1 as activo,0 usuarioid,QUIEN,CUANDO,DONDE,1,1 from DB_MUEBLERIA.dbo.UNIDADES

GO
