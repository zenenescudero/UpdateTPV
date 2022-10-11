select NoCliente,Cliente, sum(saldo) as saldo from(
select
  s.Descripcion Sucursal,
  (case when e.Historico = 1 then 'SI' else 'NO' end) as Historico,    
  Plazo,                    
                        e.Fecha,
						(Plazo * 30) DiasCredito,
						dateadd(day,(plazo*30),e.fecha) FechaVencimiento,
						(datediff(day,GETDATE(), dateadd(day,(plazo*30),e.fecha))) as DiasVencimiento,                      
                        c.Id as NoCliente,
                        c.Nombre as Cliente,  
						SeriePadre,
                        FolioPadre,
						Cargo,						
						(select sum(e1.Abono) from [EstadoCuenta](nolock) e1
								where e1.ClienteId = e.ClienteId  and (e1.[ConceptoCXC] = 'PAG' or e1.[ConceptoCXC] = 'NCA')
								and e1.FolioPadre = e.FolioPadre and e1.SeriePadre = e.SeriePadre
								and e1.Cancelado = 0) as Abonos,
						Saldo
						from EstadoCuenta(nolock) e
                        inner join Sucursales(nolock) s on(e.SucursalId = s.Id)
                        left join Clientes(nolock) c on (e.ClienteId = c.Id) 
                        where Plazo > 0 and Saldo > 0 and (e.Cancelado = 0) and e.EsPadre = 1                   
                        and SucursalId = isnull(1,SucursalId)      
                        and (datediff(day,GETDATE(), dateadd(day,(plazo*30),e.fecha))) < 1 
						and e.Historico = 1
					    --and e.saldo < 1
                         --order by e.Saldo desc
						 ) tb  
						  group by NoCliente,Cliente
						
						 order by saldo desc
						
                        



