using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViajesRepository.Domain;

namespace ViajesRepository.Services
{
    public interface IViajeService
    {
        Task<List<Viaje>> GetAllViajesAsync();
        Task<List<Viaje>> GetNoCanceladosAsync();
        Task<Viaje?> GetViajeByIdAsync(int id);
        Task<bool> CreateViajeAsync(Viaje viaje);
        Task<bool> UpdateEstadoViajeAsync(int id, string nuevoEstado);
        // Devolvemos una tupla (Exito, Mensaje) o un enum de resultado
        Task<(bool Exito, string Mensaje, bool Encontrado)> DeleteViajeAsync(int id);
        Task<List<Excursion>> GetExcursionesAsync();

    }
}
