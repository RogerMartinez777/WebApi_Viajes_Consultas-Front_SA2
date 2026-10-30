using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using ViajesRepository.Domain;

namespace ViajesRepository.Data
{
    public class ViajeDbContext : DbContext
    {
        public ViajeDbContext(DbContextOptions<ViajeDbContext> options) : base(options)
        {
        }

        public DbSet<Viaje> Viajes { get; set; }
        public DbSet<ViajeDetalle> ViajeDetalles { get; set; }
        public DbSet<Excursion> Excursiones { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // 1. Relación Maestro-Detalle: Viaje -> ViajeDetalle (1 a N)
            modelBuilder.Entity<ViajeDetalle>()
                .HasOne(d => d.Viaje)
                .WithMany(v => v.ViajeDetalles)
                .HasForeignKey(d => d.ViajeId)
                .OnDelete(DeleteBehavior.Cascade); // Si se elimina el Viaje, se eliminan sus Detalles

            // 2. Relación Detalle-Catálogo: ViajeDetalle -> Excursion (N a 1)
            modelBuilder.Entity<ViajeDetalle>()
                .HasOne(d => d.Excursion)
                .WithMany() // Una Excursion no necesita lista de Detalles de manera explícita
                .HasForeignKey(d => d.ExcursionId)
                .OnDelete(DeleteBehavior.Restrict); // Evita eliminar una Excursión que esté en uso en un detalle

            // Configuración adicional opcional de nombres de tablas / PKs
            // (Ajustar nombres según tu script SQL exacto si difieren)
            modelBuilder.Entity<Viaje>().ToTable("Viajes");
            modelBuilder.Entity<ViajeDetalle>().ToTable("ViajeDetalles");
            modelBuilder.Entity<Excursion>().ToTable("Excursiones");
        }
    }
}
