using Microsoft.AspNetCore.Mvc;
using ViajesRepository.Domain;
using ViajesRepository.Services;
using ViajesWebApi_Repaso.DTOs;

namespace ViajesWebApi_Repaso.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ViajesController : ControllerBase
    {
        private readonly IViajeService _viajeService;

        // Inyectamos únicamente la capa de servicio
        public ViajesController(IViajeService viajeService)
        {
            _viajeService = viajeService;
        }

        // Excursiones ------------------------------------------------------
        [HttpGet("excursiones")]
        public async Task<IActionResult> GetExcursiones()
        {
            var excursiones = await _viajeService.GetExcursionesAsync();
            return Ok(excursiones);
        }

        // Viajes -------------------------------------------------------
        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var viajes = await _viajeService.GetAllViajesAsync();
            return Ok(viajes);
        }

        [HttpGet("no-cancelados")]
        public async Task<IActionResult> GetNoCancelados()
        {
            var viajes = await _viajeService.GetNoCanceladosAsync();
            return Ok(viajes);
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var viaje = await _viajeService.GetViajeByIdAsync(id);
            if (viaje == null)
                return NotFound(new { mensaje = $"No se encontró el viaje con ID {id}." });

            return Ok(viaje);
        }

        [HttpPost]
        public async Task<IActionResult> Create([FromBody] Viaje viaje)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            if (viaje.ViajeDetalles == null || !viaje.ViajeDetalles.Any())
                return BadRequest(new { mensaje = "Un viaje debe incluir al menos una excursión en sus detalles." });

            try
            {
                var resultado = await _viajeService.CreateViajeAsync(viaje);
                if (!resultado)
                    return StatusCode(500, new { mensaje = "Ocurrió un error al procesar el alta del viaje o faltan excursiones válidas." });

                return CreatedAtAction(nameof(GetById), new { id = viaje.Id }, viaje);
            }
            catch (Exception ex)
            {
                return BadRequest(new { mensaje = ex.Message });
            }
        }

        [HttpPut("{id}/estado")]
        public async Task<IActionResult> UpdateEstado(int id, [FromBody] ActualizarEstadoDto dto)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var actualizado = await _viajeService.UpdateEstadoViajeAsync(id, dto.NuevoEstado);
            if (!actualizado)
                return NotFound(new { mensaje = $"No se encontró el viaje con ID {id} para actualizar." });

            return Ok(new { mensaje = $"El estado del viaje {id} fue actualizado a '{dto.NuevoEstado}' correctamente." });
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var (exito, mensaje, encontrado) = await _viajeService.DeleteViajeAsync(id);

            if (!encontrado)
                return NotFound(new { mensaje });

            if (!exito)
                return BadRequest(new { mensaje });

            return Ok(new { mensaje });
        }
    }
}