
set nocount on

declare @clientes as table(clienteid bigint);
declare @pagos as table(idpago bigint,SeriePadre varchar(20),FolioPadre int, total decimal(15,2));
declare @idCliente bigint = 0;

declare @idpago bigint = 0;
declare @seriep varchar(20);
declare @foliop int;
declare @uuid varchar(50);
declare @formapago varchar(250);
declare @total decimal(15,2);


insert @clientes
select ClienteId from(
select ClienteId, max(Fecha) fecha 
from EstadoCuenta where Plazo > 0
group by ClienteId) tab
--where fecha > '2018-01-01'
where fecha > '2020-01-01' and ClienteId = 663
order by fecha

set @idCliente = (select top 1 clienteid from @clientes)

while @idCliente is not null
begin
	
	delete from @pagos

	insert into @pagos
    select Id, SeriePadre, FolioPadre,Total from EstadoCuenta where (UUID is null or UUID = '')
	and ConceptoCXC = 'PAG' and ClienteId = @idCliente
	
	/* recorrer pagos */
	
	
	set @idpago = (select top 1 idpago from @pagos)

	while @idpago is not null
	begin
		set @seriep = null;
		set @foliop = null;
		set @uuid = null;
		set @formapago = null;
		set @total = null;

		declare @resultados int = 0;

		select @seriep = SeriePadre, @foliop = FolioPadre, @total = total from @pagos where idpago = @idpago
		
		set @resultados = (select count(dr.Id) from DocRelPago dr
		left join ComplementoPago cp on(dr.Serie = cp.Serie and dr.Folio = cp.Folio)
		where FolioF = @foliop and SerieF = @seriep and ImpPagado = @total and LEN(cp.UUID) > 10 and cp.Cancelado = 0);

		if(@resultados) = 1
		begin 
			/*
			
			select 'relacionado UUID',cp.UUID,cp.Serie,cp.Folio,cp.FormaPagoDesc, dr.Serie, dr.Folio, dr.* from DocRelPago dr
			left join ComplementoPago cp on(dr.Serie = cp.Serie and dr.Folio = cp.Folio)
			where FolioF = @foliop and SerieF = @seriep
				
			*/

			select @uuid = cp.UUID,@seriep = cp.Serie,@foliop = cp.Folio,@formapago = cp.FormaPagoDesc from DocRelPago dr
			left join ComplementoPago cp on(dr.Serie = cp.Serie and dr.Folio = cp.Folio)
			where FolioF = @foliop and SerieF = @seriep and ImpPagado = @total and LEN(cp.UUID) > 10 and cp.Cancelado = 0

			select @uuid,@seriep,@foliop,@formapago,@total

			if LEN(@uuid) > 10
			begin
				update EstadoCuenta set Serie = @seriep,Folio = @foliop,UUID = @uuid, FormaPagoDesc = @formapago			
				where Id = @idpago and ClienteId = @idCliente and Historico = 1 and Total = @total
			end
				
		end
		if @resultados > 1
		begin
			print 'resultados ' + cast(@resultados as varchar(10)) + ' @seriep=' + @seriep + ' @foliop=' + cast(@foliop as varchar(20))
		end

		delete from @pagos where idpago = @idpago

		set @idpago = (select top 1 idpago from @pagos)

	end

	delete from @clientes where clienteid = @idCliente

	set @idCliente = (select top 1 clienteid from @clientes)

end
