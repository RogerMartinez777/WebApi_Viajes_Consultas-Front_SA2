using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViajesRepository.Domain;

namespace ViajesRepository.Data.Interfaces
{
    public interface IViajeRepository
    {
        Task<List<Viaje>> GetAllAsync();
        Task<List<Viaje>> GetNoCanceladosAsync();
        Task<Viaje?> GetByIdAsync(int id);
        Task<bool> CreateAsync(Viaje viaje);
        Task<bool> UpdateEstadoAsync(int id, string nuevoEstado);
        Task<bool> DeleteAsync(int id);
    }
}
