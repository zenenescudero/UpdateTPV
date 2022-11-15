
declare @clienteid int = 1223;
declare @serie varchar(20) = 'A'
declare @folio varchar(20) = '193319' --'192493'--'199899'

select 'factura', * from facturas where folio = @folio --and ClienteId = @clienteid
select 'estadocuenta', * from EstadoCuenta where ConceptoCXC = 'PAG' and
FolioPadre = @folio --and ClienteId = @clienteid

select 'relacionado UUID Uni',cp.UUID,cp.Serie,cp.Folio, dr.Serie, dr.Folio, dr.* from DocRelPago dr
left join ComplementoPago cp on(dr.Serie = cp.Serie and dr.Folio = cp.Folio)
where FolioF = @folio and LEN(cp.UUID) > 10 and cp.Cancelado = 0
--order by VersionRegistro desc

select dr.* from DocRelPago dr
left join ComplementoPago cp on(dr.Serie = cp.Serie and dr.Folio = cp.Folio)
where FolioF = @folio

/*
select 'relacionado', dr.* from DocRelPago dr
where dr.FolioF = @folio order by VersionRegistro desc

select 'complemento ultimo', * from ComplementoPago where Folio in (select Folio from DocRelPago where FolioF = @folio)
order by VersionRegistro desc
select 'complementos pago', * from ComplementoPago where Folio in (select top 1 Folio from DocRelPago where FolioF = @folio order by VersionRegistro desc)
*/

/*
select * from DocRelPago where FolioPago = @folio order by VersionRegistro desc
select * from ComplementoPago where Folio = (select top 1 Folio from DocRelPago where FolioPago = @folio order by VersionRegistro desc)
order by VersionRegistro desc

select * from DocRelPago where FolioPago > 0

select * from DocRelPago where FolioPago = 33281

select * from DB_COMPIDTFAC.dbo.PAGOS33 where Folio = 42011

update EstadoCuenta set 

				  select * from DB_COMPIDTFAC.dbo.PAGOS_DETDR where FOLIO = 42011

select distinct Serie from EstadoCuenta where 

select * from EstadoCuenta where 

declare @tablapagos as table(serie varchar(20),folio int)
*/