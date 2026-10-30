using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
// Using agregados para DataAnnotations y Serialization de Json
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace ViajesRepository.Domain
{
    [Table("Excursiones")] // Mapea la tabla [dbo].[Excursiones]
    public class Excursion
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Required(ErrorMessage = "El nombre de la excursión es obligatorio.")]
        [StringLength(100)]
        public string Nombre { get; set; } = string.Empty;

        [Required]
        [StringLength(1000)]
        public string Descripcion { get; set; } = string.Empty;

        [Required]
        [Column(TypeName = "decimal(18,2)")]
        [Range(0.01, double.MaxValue, ErrorMessage = "El precio debe ser mayor a 0.")]
        public decimal Precio { get; set; }

        // Propiedad de navegación inversa (opcional)
        //[JsonIgnore]
        //public virtual ICollection<ViajeDetalle> ViajeDetalles { get; set; } = new List<ViajeDetalle>();
    }
}
