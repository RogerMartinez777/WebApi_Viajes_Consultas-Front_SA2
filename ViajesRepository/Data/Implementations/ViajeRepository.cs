using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViajesRepository.Data.Interfaces;
using ViajesRepository.Domain;

namespace ViajesRepository.Data.Implementations
{
    public class ViajeRepository : IViajeRepository
    {
        private readonly ViajeDbContext _context;

        public ViajeRepository(ViajeDbContext context)
        {
            _context = context;
        }

        public async Task<List<Viaje>> GetAllAsync()
        {
            return await _context.Viajes
                .Include(v => v.ViajeDetalles)
                    .ThenInclude(d => d.Excursion)
                .ToListAsync();
        }

        public async Task<List<Viaje>> GetNoCanceladosAsync()
        {
            return await _context.Viajes
                .Include(v => v.ViajeDetalles)
                    .ThenInclude(d => d.Excursion)
                .Where(v => v.Estado != "Cancelado")
                .ToListAsync();
        }

        public async Task<Viaje?> GetByIdAsync(int id)
        {
            return await _context.Viajes
                .Include(v => v.ViajeDetalles)
                    .ThenInclude(d => d.Excursion)
                .FirstOrDefaultAsync(v => v.Id == id);
        }

        public async Task<bool> CreateAsync(Viaje viaje)
        {
            // Calculamos subtotales y total iterando los detalles
            decimal totalViaje = 0;

            foreach (var detalle in viaje.ViajeDetalles)
            {
                var excursion = await _context.Excursiones.FindAsync(detalle.ExcursionId);
                if (excursion == null)
                    return false; // O podés lanzar una excepción corta

                detalle.Subtotal = excursion.Precio * detalle.CantidadPersonas;
                totalViaje += detalle.Subtotal;
            }

            viaje.PrecioTotal = totalViaje;

            // agregamos el Viaje y se mapean automáticamente sus ViajeDetalles
            await _context.Viajes.AddAsync(viaje);

            // SaveChangesAsync ejecuta TODO en una sola transacción
            return await _context.SaveChangesAsync() > 0;
        }

        public async Task<bool> UpdateEstadoAsync(int id, string nuevoEstado)
        {
            var viaje = await _context.Viajes.FindAsync(id);
            if (viaje == null)
                return false;

            viaje.Estado = nuevoEstado;

            return await _context.SaveChangesAsync() > 0;
        }

        public async Task<bool> DeleteAsync(int id)
        {
            var viaje = await _context.Viajes.FindAsync(id);
            if (viaje == null) return false;

            _context.Viajes.Remove(viaje);
            return await _context.SaveChangesAsync() > 0;
        }
    }
}
