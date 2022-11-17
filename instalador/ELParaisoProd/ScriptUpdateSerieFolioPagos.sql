
set nocount on

declare @clientes as table(clienteid bigint);
declare @pagos as table(idpago bigint,
SeriePadre varchar(20),
FolioPadre int,
Fecha date, total decimal(15,2));
declare @idCliente bigint = 0;

declare @idpago bigint = 0;
declare @seriep varchar(20);
declare @foliop int;
declare @fecha date;
declare @uuid varchar(50);
declare @formapago varchar(250);
declare @total decimal(15,2);
declare @numero int;

insert @clientes
select top 300 * from clientesupdate --where clienteid = 11542

set @idCliente = (select top 1 clienteid from @clientes)

while @idCliente is not null
begin
	
	delete from @pagos

	insert into @pagos
    select Id, SeriePadre, FolioPadre,cast(Fecha as date),Total from EstadoCuenta where (UUID is null or UUID = '')
	and ConceptoCXC = 'PAG' and ClienteId = @idCliente and Cancelado = 0
	--select * from @pagos
	/* recorrer pagos */
	
	
	set @idpago = (select top 1 idpago from @pagos)

	while @idpago is not null
	begin
		set @seriep = null;
		set @foliop = null;
		set @fecha = null;
		set @uuid = null;
		set @formapago = null;
		set @total = null;
		set @numero = null;

		declare @resultados int = 0;

		select @seriep = SeriePadre, @foliop = FolioPadre,@fecha = Fecha, @total = total from @pagos where idpago = @idpago
		
		set @resultados = (select count(dr.Id) from DocRelPago dr
		left join ComplementoPago cp on(dr.Serie = cp.Serie and dr.Folio = cp.Folio)
		where FolioF = @foliop and SerieF = @seriep and ImpPagado = @total
		and LEN(cp.UUID) > 10 and cp.Cancelado = 0);

		if(@resultados) = 1
		begin 
			
			select @numero = dr.NumParcialidad, @uuid = cp.UUID,@seriep = cp.Serie,@foliop = cp.Folio,@formapago = cp.FormaPagoDesc from DocRelPago dr
			left join ComplementoPago cp on(dr.Serie = cp.Serie and dr.Folio = cp.Folio)
			where FolioF = @foliop and SerieF = @seriep and ImpPagado = @total
			and LEN(cp.UUID) > 10 and cp.Cancelado = 0

			--select @uuid,@seriep,@foliop,@formapago,@total,@numero
			
			if LEN(@uuid) > 10
			begin
				update EstadoCuenta set Numero = @numero, Serie = @seriep,Folio = @foliop,UUID = @uuid, FormaPagoDesc = @formapago			
				where Id = @idpago and ClienteId = @idCliente and Historico = 1 and Total = @total
			end
							
		end
		if @resultados > 1
		begin
			
			set @resultados = (select count(dr.Id) from DocRelPago dr
			left join ComplementoPago cp on(dr.Serie = cp.Serie and dr.Folio = cp.Folio)
			where FolioF = @foliop and SerieF = @seriep and ImpPagado = @total and cast(cp.Fecha as date) = @fecha
			and LEN(cp.UUID) > 10 and cp.Cancelado = 0);

			if @resultados = 1
			begin
				select @numero = dr.NumParcialidad, @uuid = cp.UUID,@seriep = cp.Serie,@foliop = cp.Folio,@formapago = cp.FormaPagoDesc from DocRelPago dr
				left join ComplementoPago cp on(dr.Serie = cp.Serie and dr.Folio = cp.Folio)
				where FolioF = @foliop and SerieF = @seriep and ImpPagado = @total and cast(cp.Fecha as date) = @fecha
				and LEN(cp.UUID) > 10 and cp.Cancelado = 0;

				--select @uuid,@seriep,@foliop,@formapago,@total,@numero
				
				if LEN(@uuid) > 10
				begin
					update EstadoCuenta set Numero = @numero, Serie = @seriep,Folio = @foliop,UUID = @uuid, FormaPagoDesc = @formapago			
					where Id = @idpago and ClienteId = @idCliente and Historico = 1 and Total = @total
				end
				
			end
			else
			begin
				insert into pagossinuuid(id,resultados) values(@idpago,@resultados);
		    end
		end

		delete from @pagos where idpago = @idpago

		set @idpago = (select top 1 idpago from @pagos)

	end

	select @idCliente
	delete from @clientes where clienteid = @idCliente
	delete from clientesupdate where clienteid = @idCliente
	set @idCliente = (select top 1 clienteid from @clientes)

end
