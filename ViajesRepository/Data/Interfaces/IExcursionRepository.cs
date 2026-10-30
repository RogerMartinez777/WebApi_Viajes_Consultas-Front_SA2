using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ViajesRepository.Domain;

namespace ViajesRepository.Data.Interfaces
{
    public interface IExcursionRepository
    {
        Task<List<Excursion>> GetAllAsync();
        Task<Excursion?> GetByIdAsync(int id);
    }
}
