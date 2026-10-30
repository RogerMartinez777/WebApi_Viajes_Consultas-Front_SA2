using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
// Agregamos Using para DataAnnotations
using System.ComponentModel.DataAnnotations;

namespace ViajesRepository.Domain
{
    [Table("Viajes")]
    public class Viaje
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Required(ErrorMessage = "El destino es obligatorio.")]
        [StringLength(100)]
        public string Destino { get; set; } = string.Empty;

        [Required]
        [DataType(DataType.Date)]
        public DateTime FechaInicio { get; set; }

        [Required]
        [DataType(DataType.Date)]
        public DateTime FechaFin { get; set; }

        [Required]
        [Column(TypeName = "decimal(18,2)")]
        public decimal PrecioTotal { get; set; }

        [Required]
        [StringLength(20)]
        public string Estado { get; set; } = "Pendiente"; // Ej: "En Curso", "Pendiente", "Confirmado", "Cancelado"

        // Relación Maestro -> Detalle
        public virtual ICollection<ViajeDetalle> ViajeDetalles { get; set; } = new List<ViajeDetalle>();
    }
}
