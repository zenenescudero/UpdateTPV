
declare @serieF varchar(10);
declare @folioF int;
declare @total decimal(15,2);

declare @idpago bigint;
declare @seriep varchar(20);
declare @foliop int;
declare @fecha date;
declare @uuid varchar(50);
declare @formapago varchar(250);
declare @numero int;
declare @procesado int;

	set @idpago = (select top 1 id from pagossinuuid)

	while @idpago is not null
	begin

	set @seriep = null;
	set @foliop = null;
	set @fecha = null;
	set @uuid = null;
	set @formapago = null;
	set @total = null;
	set @numero = null;
	set @procesado = 0;

select @serieF = SeriePadre,@folioF = FolioPadre,@total = Total
from EstadoCuenta where Id = @idpago and (UUID is null or UUID = '') and Cancelado = 0 and Historico = 1;

--select * from EstadoCuenta where Id = @idpago and (UUID is null or UUID = '') and Cancelado = 0;

if @serieF is not null
begin
/*
		select  dr.NumParcialidad,  cp.UUID,
		cp.Serie,  cp.Folio,cp.FormaPagoDesc
		from DocRelPago dr
		left join ComplementoPago cp on(dr.Serie = cp.Serie and dr.Folio = cp.Folio)
					where FolioF = @folioF  and SerieF = @serieF and ImpPagado = @total
					and LEN(cp.UUID) > 10 and cp.Cancelado = 0
					and cp.UUID not in(select UUID from EstadoCuenta where FolioPadre = @folioF
						and ConceptoCXC = 'PAG' and Total = @total and LEN(UUID) > 10 and Cancelado = 0)
					order by Fecha
					*/
		select top 1 @numero = dr.NumParcialidad, @uuid = cp.UUID,
		@seriep = cp.Serie, @foliop = cp.Folio,@formapago = cp.FormaPagoDesc
		from DocRelPago dr
		left join ComplementoPago cp on(dr.Serie = cp.Serie and dr.Folio = cp.Folio)
					where FolioF = @folioF  and SerieF = @serieF and ImpPagado = @total
					and LEN(cp.UUID) > 10 and cp.Cancelado = 0
					and cp.UUID not in(select UUID from EstadoCuenta where FolioPadre = @folioF
						and ConceptoCXC = 'PAG' and Total = @total and LEN(UUID) > 10 and Cancelado = 0)
					order by cp.Folio

					if LEN(@uuid) > 10
					begin			    
						set @procesado = 1;
						--select @uuid,@seriep,@foliop,@formapago,@total,@numero;						
						update EstadoCuenta set Numero = @numero, Serie = @seriep,
						Folio = @foliop,UUID = @uuid, FormaPagoDesc = @formapago, Enviado = 0, [Version] = ([Version] + 1)						
						where Id = @idpago and Historico = 1 and Total = @total
						
					end
end
		
	if @procesado = 0
	begin
	     insert into pagossinuuid(id,resultados) values(@idpago,0);
	end

	delete from pagossinuuid where id = @idpago;

	set @idpago = (select top 1 id from pagossinuuid);

end
