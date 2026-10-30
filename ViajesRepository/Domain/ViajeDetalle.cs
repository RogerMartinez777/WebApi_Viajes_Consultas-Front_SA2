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
    [Table("ViajeDetalles")] // Mapea la tabla [dbo].[ViajeDetalles]. Conecta el viaje con la excursión contratada.
    public class ViajeDetalle
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [Required]
        public int ViajeId { get; set; }

        [Required(ErrorMessage = "Debe seleccionar una excursión válida.")]
        public int ExcursionId { get; set; }

        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "La cantidad de personas debe ser al menos 1.")]
        public int CantidadPersonas { get; set; }

        [Required]
        [Column(TypeName = "decimal(18,2)")]
        public decimal Subtotal { get; set; }

        // --- Propiedades de Navegación ---

        // IMPORTANTE: Se ignora la referencia al padre en la serialización JSON
        // para evitar el ciclo 'Viaje -> Detalle -> Viaje -> Detalle...' al devolver un GET.
        [JsonIgnore]
        [ForeignKey(nameof(ViajeId))]
        public virtual Viaje? Viaje { get; set; }

        [ForeignKey(nameof(ExcursionId))]
        public virtual Excursion? Excursion { get; set; }
    }
}
