using Microsoft.EntityFrameworkCore;
using ViajesRepository.Data;
using ViajesRepository.Data.Implementations;
using ViajesRepository.Data.Interfaces;
using ViajesRepository.Services;

var builder = WebApplication.CreateBuilder(args);

// 1. Configuración de Inyección de Dependencias (Servicios)

// Registrar DbContext apuntando a SQL Server con la cadena de conexión de appsettings.json
builder.Services.AddDbContext<ViajeDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Registrar Repositorios (Inyección de Dependencias)
builder.Services.AddScoped<IExcursionRepository, ExcursionRepository>();
builder.Services.AddScoped<IViajeRepository, ViajeRepository>();
// Registrar Servicios
builder.Services.AddScoped<IViajeService, ViajeService>();

// Agregar controladores y OpenAPI/Swagger
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

// 1. Permite que la raíz (/) busque automáticamente index.html -------------
app.UseDefaultFiles();

// 2. Habilita los archivos estáticos de wwwroot
app.UseStaticFiles();

app.UseAuthorization();
app.MapControllers();

app.Run();