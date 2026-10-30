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
    public class ExcursionRepository : IExcursionRepository
    {
        private readonly ViajeDbContext _context;

        public ExcursionRepository(ViajeDbContext context)
        {
            _context = context;
        }

        public async Task<List<Excursion>> GetAllAsync()
        {
            return await _context.Excursiones.ToListAsync();
        }

        public async Task<Excursion?> GetByIdAsync(int id)
        {
            return await _context.Excursiones.FindAsync(id);
        }
    }
}
