# ✈️ Proyecto Integrador de Repaso: Sistema de Gestión de Viajes (`db_Viajes`)

## 📌 Contexto del Dominio

El sistema administra la reserva de paquetes turísticos organizados bajo una relación **Maestro-Detalle**:

1. **`Excursion`** *(Catálogo)*: Representa las excursiones individuales disponibles (ej. *Museo del Louvre*, *Subida a la Torre Eiffel*).
2. **`Viaje`** *(Maestro)*: Representa el paquete global contratado por un cliente (Destino, Fechas, Estado y Precio Total).
3. **`ViajeDetalle`** *(Detalle)*: Asocia un viaje con una o más excursiones, especificando la cantidad de personas contratadas y el subtotal correspondiente.

---

## ⚠️ Consideraciones de Dominio e Integridad

1. **Referencias Circulares (Serialización JSON):**
   * En la entidad `ViajeDetalle`, la propiedad de navegación `Viaje` **debe estar decorada con `[JsonIgnore]`**. De lo contrario, al consultar un viaje con sus detalles mediante la API, se generará una excepción por bucle infinito (`Viaje` $\rightarrow$ `ViajeDetalle` $\rightarrow$ `Viaje`).
2. **Cálculo de Precios y Subtotales:**
   * Al registrar un nuevo viaje (POST), los subtotales de los detalles y el precio total del viaje **deben calcularse en la capa de negocio/repositorio**:
     $$\text{Subtotal} = \text{Precio Excursión} \times \text{CantidadPersonas}$$
     $$\text{PrecioTotal} = \sum \text{Subtotales}$$
3. **Atomicidad y Transacciones:**
   * La inserción de un `Viaje` y sus `ViajeDetalles` debe realizarse como una **operación atómica**. Si falla el registro de un detalle, debe revertirse toda la transacción para no dejar cabeceras huérfanas en la base de datos.

---

## 🚀 Tareas a Desarrollar

Podés resolver la persistencia seleccionando una de las dos modalidades según la técnica trabajada:

---

### 🔹 Opción A: Resolución mediante Entity Framework Core (Recomendado)

Si decidís utilizar **EF Core (Database First / Code First)**, completá los siguientes pasos:

1. **Completar `ViajeDbContext.cs` (`ViajesRepository/Data`):**
   * Heredar de `DbContext`.
   * Declarar el constructor recibiendo `DbContextOptions<ViajeDbContext>`.
   * Mapear las colecciones `DbSet<Viaje>`, `DbSet<ViajeDetalle>` y `DbSet<Excursion>`.
2. **Configurar la Inyección de Dependencias en `Program.cs` (`ViajesWebApi_Repaso`):**
   * Registrar el `DbContext` utilizando la cadena de conexión definida en `appsettings.json` (`DefaultConnection`):
     ```csharp
     builder.Services.AddDbContext<ViajeDbContext>(options =>
         options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
     ```
   * Registrar la interfaz e implementación del repositorio (`AddScoped<IViajeRepository, ViajeRepository>()`).
3. **Implementar el Repositorio (`ViajeRepository.cs`):**
   * Desarrollar los métodos CRUD utilizando LINQ (`.Include()`, `.ToListAsync()`, `.FirstOrDefaultAsync()`, `.AddAsync()`, `.SaveChangesAsync()`).
4. **Construir los Controladores:**
   * Inyectar la interfaz del repositorio/servicio en `ViajesController` para exponer los endpoints HTTP.

---

### 🔹 Opción B: Resolución mediante DataHelper (ADO.NET / Stored Procedures)

Si optás por el enfoque con **DataHelper / ADO.NET**, completá los siguientes pasos:

1. **Implementar / Registrar `DataHelper.cs`:**
   * Configurar el `SqlConnection` utilizando la cadena de conexión de `appsettings.json`.
   * Garantizar el uso de **`SqlTransaction`** (`BeginTransaction()`, `Commit()`, `Rollback()`) para el método de guardado maestro-detalle.
2. **Configurar `Program.cs` (`ViajesWebApi_Repaso`):**
   * Registrar el servicio/helper y la implementación del repositorio en el contenedor de dependencias (`AddScoped`).
3. **Implementar el Repositorio con Stored Procedures:**
   * Utilizar los Stored Procedures provistos en el script SQL (`SP_OBTENER_VIAJE_POR_ID`, `SP_OBTENER_EXCURSIONES_POR_VIAJE`, `SP_ACTUALIZAR_ESTADO_VIAJE`, etc.) mapeando manualmente los registros del `SqlDataReader` a las clases de dominio.

---

## 🧪 Endpoints a Implementar en el Controller

1. `GET /api/viajes` – Listar todos los viajes (incluyendo sus excursiones/detalles).
2. `GET /api/viajes/{id}` – Obtener el detalle de un viaje específico por ID.
3. `GET /api/viajes/no-cancelados` – Listar viajes cuyo estado sea distinto de 'Cancelado'.
4. `POST /api/viajes` – Registrar un nuevo viaje completo (Cabecera + Lista de Detalles) recalculando totales y garantizando la transacción.
5. `PUT /api/viajes/{id}/estado` – Actualizar el estado de un viaje (ej. de 'Pendiente' a 'Confirmado').

---

## 🛠️ Requisitos Previos

1. La BD ya está creada en el Servidor de la Facu, Si lo vas a hacer en local: Ejecutar el script `viajes_script.sql` en SQL Server para crear la base de datos `db_Viajes` con sus datos iniciales y Stored Procedures.
2. Verificar en `appsettings.json` que el parámetro `Server` apunte a tu instancia local de SQL Server (ej. `.\\SQLEXPRESS`).
