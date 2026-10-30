document.addEventListener('DOMContentLoaded', () => {
    const API_URL = '/api/viajes/excursiones';

    async function fetchExcursiones() {
        try {
            const response = await fetch(API_URL);
            if (!response.ok) throw new Error('Error al obtener las excursiones.');

            const excursiones = await response.json();
            renderizarExcursiones(excursiones);
        } catch (error) {
            console.error('Error:', error);
            alert('No se pudo conectar con la API para cargar las excursiones.');
        }
    }

    function renderizarExcursiones(excursiones) {
        const contenedor = document.getElementById('excursiones-container');
        contenedor.innerHTML = ''; // Limpiamos por si acaso

        excursiones.forEach(excursion => {
            // Creamos la columna responsiva para la card
            const col = document.createElement('div');
            col.classList.add('col');

            // Estructura interna de la Card con Bootstrap
            col.innerHTML = `
                <div class="card h-100 shadow-sm border-0">
                    <div class="card-body d-flex flex-column">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h5 class="card-title text-primary fw-bold mb-0">${excursion.nombre}</h5>
                            <span class="badge bg-success fs-6">$ ${excursion.precio.toLocaleString('es-AR')}</span>
                        </div>
                        <p class="card-text text-secondary mt-2 flex-grow-1">${excursion.descripcion || 'Sin descripción disponible.'}</p>
                        <div class="mt-3 pt-2 border-top text-muted small">
                            <i class="bi bi-tag-fill me-1"></i> ID de Excursión: <strong>${excursion.id}</strong>
                        </div>
                    </div>
                </div>
            `;

            contenedor.appendChild(col);
        });
    }

    // Ejecutamos la consulta al cargar la página
    fetchExcursiones();
});