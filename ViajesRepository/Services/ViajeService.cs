using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViajesRepository.Data.Interfaces;
using ViajesRepository.Domain;

namespace ViajesRepository.Services
{
    public class ViajeService : IViajeService
    {
        private readonly IViajeRepository _viajeRepository;
        private readonly IExcursionRepository _excursionRepository;

        public ViajeService(IViajeRepository viajeRepository, IExcursionRepository excursionRepository)
        {
            _viajeRepository = viajeRepository;
            _excursionRepository = excursionRepository;
        }

        public async Task<List<Viaje>> GetAllViajesAsync()
        {
            return await _viajeRepository.GetAllAsync();
        }

        public async Task<List<Viaje>> GetNoCanceladosAsync()
        {
            return await _viajeRepository.GetNoCanceladosAsync();
        }

        public async Task<Viaje?> GetViajeByIdAsync(int id)
        {
            return await _viajeRepository.GetByIdAsync(id);
        }

        public async Task<bool> CreateViajeAsync(Viaje viaje)
        {
            // Validaciones de negocio del servicio si hicieran falta
            if (viaje.ViajeDetalles == null || !viaje.ViajeDetalles.Any())
                return false;

            return await _viajeRepository.CreateAsync(viaje);
        }

        public async Task<bool> UpdateEstadoViajeAsync(int id, string nuevoEstado)
        {
            return await _viajeRepository.UpdateEstadoAsync(id, nuevoEstado);
        }

        public async Task<(bool Exito, string Mensaje, bool Encontrado)> DeleteViajeAsync(int id)
        {
            // 1. Verificar si existe
            var viaje = await _viajeRepository.GetByIdAsync(id);
            if (viaje == null)
            {
                return (false, $"No se encontró el viaje con ID {id}.", false);
            }

            // 2. Regla de negocio: Solo cancelar si está Pendiente
            if (viaje.Estado == null || !viaje.Estado.Equals("Pendiente", StringComparison.OrdinalIgnoreCase))
            {
                return (false, $"El viaje {id} está en estado '{viaje.Estado}' y no puede ser cancelado. Solo se pueden cancelar viajes en estado 'Pendiente'.", true);
            }

            // 3. Aplicar borrado lógico
            var actualizado = await _viajeRepository.UpdateEstadoAsync(id, "Cancelado");
            return (actualizado, $"El viaje {id} se canceló correctamente.", true);
        }

        public async Task<List<Excursion>> GetExcursionesAsync()
        {
            return await _excursionRepository.GetAllAsync();
        }
    }
}
