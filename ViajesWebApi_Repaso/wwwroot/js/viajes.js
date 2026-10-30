document.addEventListener('DOMContentLoaded', () => {
    // Como estamos sirviendo el frontend desde la misma API, la URL base es relativa o absoluta al puerto actual
    const API_URL = '/api/viajes';

    // Función principal para obtener los viajes mediante fetch (GET)
    async function fetchViajes() {
        try {
            const response = await fetch(API_URL);
            if (!response.ok) throw new Error('Error al obtener los viajes del servidor.');

            const viajes = await response.json();
            cargarViajesEnTabla(viajes);
        } catch (error) {
            console.error('Error:', error);
            alert('No se pudo conectar con la API para cargar los viajes.');
        }
    }

    // Función auxiliar para formatear fechas de ISO a formato local legible
    function formatearFecha(fechaISO) {
        if (!fechaISO) return '-';
        const fecha = new Date(fechaISO);
        const dia = String(fecha.getDate()).padStart(2, '0');
        const mes = String(fecha.getMonth() + 1).padStart(2, '0');
        const anio = fecha.getFullYear();
        return `${dia}/${mes}/${anio}`;
    }

    // Función para renderizar los datos en la tabla HTML dinámicamente
    function cargarViajesEnTabla(viajes) {
        const tbody = document.getElementById('viajes-body');
        tbody.innerHTML = ''; // Limpiamos la tabla antes de insertar

        viajes.forEach(viaje => {
            const row = document.createElement('tr');

            // 1. Columna ID
            const idTd = document.createElement('td');
            idTd.textContent = viaje.id;
            row.appendChild(idTd);

            // 2. Columna Destino
            const destinoTd = document.createElement('td');
            destinoTd.textContent = viaje.destino;
            row.appendChild(destinoTd);

            // 3. Columna Fecha Inicio
            const inicioTd = document.createElement('td');
            inicioTd.textContent = formatearFecha(viaje.fechaInicio);
            row.appendChild(inicioTd);

            // 4. Columna Fecha Fin
            const finTd = document.createElement('td');
            finTd.textContent = formatearFecha(viaje.fechaFin);
            row.appendChild(finTd);

            // 5. Columna Precio Total
            const precioTd = document.createElement('td');
            precioTd.textContent = `$ ${viaje.precioTotal.toLocaleString('es-AR')}`;
            row.appendChild(precioTd);

            // 6. Columna Estado con Badges de Bootstrap de distintos colores
            const estadoTd = document.createElement('td');
            const estadoBadge = document.createElement('span');
            estadoBadge.classList.add('badge', 'px-2', 'py-1');

            switch (viaje.estado) {
                case 'Pendiente':
                    estadoBadge.classList.add('bg-warning', 'text-dark'); // Amarillo
                    estadoBadge.textContent = 'Pendiente';
                    break;
                case 'Confirmado':
                    estadoBadge.classList.add('bg-success'); // Verde
                    estadoBadge.textContent = 'Confirmado';
                    break;
                case 'En Curso':
                    estadoBadge.classList.add('bg-primary'); // Azul
                    estadoBadge.textContent = 'En Curso';
                    break;
                case 'Cancelado':
                    estadoBadge.classList.add('bg-danger'); // Rojo
                    estadoBadge.textContent = 'Cancelado';
                    break;
                default:
                    estadoBadge.classList.add('bg-secondary');
                    estadoBadge.textContent = viaje.estado || 'Desconocido';
            }
            estadoTd.appendChild(estadoBadge);
            row.appendChild(estadoTd);

            // 7. Columna Acciones (Cancelar / Borrado Lógico)
            const accionesTd = document.createElement('td');

            // Botón Cancelar (Solo activo si está Pendiente por regla de negocio)
            const cancelarBtn = document.createElement('button');
            cancelarBtn.classList.add('btn', 'btn-danger', 'btn-sm');
            cancelarBtn.innerHTML = '<i class="bi bi-x-circle"></i> Cancelar';

            cancelarBtn.addEventListener('click', () => {
                // Validación previa por regla de negocio   ----------------
                if (viaje.estado !== 'Pendiente') {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Acción no permitida',
                        text: `El viaje está en estado '${viaje.estado}' y no se puede cancelar. Solo se permiten cancelar viajes en estado 'Pendiente'.`,
                        confirmButtonColor: '#0d6efd'
                    });
                    return;
                }

                // Modal de confirmación con SweetAlert2   ------------
                Swal.fire({
                    title: '¿Estás seguro?',
                    text: `Se cancelará el viaje con destino a "${viaje.destino}" (ID: ${viaje.id}).`,
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#dc3545',
                    cancelButtonColor: '#6c757d',
                    confirmButtonText: 'Sí, cancelar viaje',
                    cancelButtonText: 'Volver'
                }).then((result) => {
                    if (result.isConfirmed) {
                        cancelarViaje(viaje.id);
                    }
                });
            });

            accionesTd.appendChild(cancelarBtn);
            row.appendChild(accionesTd);

            // Añadimos la fila completa al cuerpo de la tabla
            tbody.appendChild(row);
        });
    }

    // Función para invocar el DELETE /api/viajes/{id} que configuramos en la Web API
    async function cancelarViaje(id) {
        try {
            const response = await fetch(`${API_URL}/${id}`, {
                method: 'DELETE'
            });

            const resultado = await response.json();

            if (response.ok) {
                Swal.fire({ // Sweet Alert 2 -------------------------
                    icon: 'success',
                    title: '¡Viaje Cancelado!',
                    text: resultado.mensaje || 'El estado cambió a Cancelado correctamente.',
                    timer: 2200,
                    showConfirmButton: false
                });
                fetchViajes();
            } else { // tambien lo mejoramos con SweetAlert2 y que no parezca un modal de los años 90 ------------------
                Swal.fire({
                    icon: 'error',
                    title: 'No se pudo procesar',
                    text: resultado.mensaje || 'Ocurrió un error al intentar cancelar.',
                    confirmButtonColor: '#0d6efd'
                });
            }
        } catch (error) { // SweetAlert2 -----------------
            console.error('Error al cancelar:', error);
            Swal.fire({
                icon: 'error',
                title: 'Error de red',
                text: 'Ocurrió un fallo de conexión con el servidor de la API.',
                confirmButtonColor: '#0d6efd'
            });
        }
    }

    // Ejecutamos la carga inicial al abrir la página
    fetchViajes();
});