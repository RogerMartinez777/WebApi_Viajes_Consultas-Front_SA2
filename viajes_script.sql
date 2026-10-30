USE [master]
GO
/****** Object:  Database [db_Viajes]    Script Date: 10/1/2025 8:24:05 AM ******/
CREATE DATABASE [db_Viajes]
GO
ALTER DATABASE [db_Viajes] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_Viajes].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db_Viajes] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db_Viajes] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db_Viajes] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db_Viajes] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db_Viajes] SET ARITHABORT OFF 
GO
ALTER DATABASE [db_Viajes] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [db_Viajes] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db_Viajes] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db_Viajes] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db_Viajes] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db_Viajes] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db_Viajes] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db_Viajes] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db_Viajes] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db_Viajes] SET  DISABLE_BROKER 
GO
ALTER DATABASE [db_Viajes] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db_Viajes] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db_Viajes] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db_Viajes] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db_Viajes] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db_Viajes] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db_Viajes] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db_Viajes] SET RECOVERY FULL 
GO
ALTER DATABASE [db_Viajes] SET  MULTI_USER 
GO
ALTER DATABASE [db_Viajes] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db_Viajes] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db_Viajes] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db_Viajes] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [db_Viajes] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [db_Viajes] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'db_Viajes', N'ON'
GO
ALTER DATABASE [db_Viajes] SET QUERY_STORE = ON
GO
ALTER DATABASE [db_Viajes] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [db_Viajes]
GO
/****** Object:  Table [dbo].[Excursiones]    Script Date: 10/1/2025 8:24:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Excursiones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](1000) NOT NULL,
	[Precio] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Excursiones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ViajeDetalles]    Script Date: 10/1/2025 8:24:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ViajeDetalles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ViajeId] [int] NOT NULL,
	[ExcursionId] [int] NOT NULL,
	[CantidadPersonas] [int] NOT NULL,
	[Subtotal] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_ViajeDetalles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Viajes]    Script Date: 10/1/2025 8:24:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Viajes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Destino] [varchar](100) NOT NULL,
	[FechaInicio] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
	[PrecioTotal] [decimal](18, 2) NOT NULL,
	[Estado] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Viajes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Excursiones] ON 
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (1, N'Museo del Louvre', N'Visita guiada por el Museo del Louvre con guía especializado.', CAST(25000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (2, N'Paseo en barco por el Sena', N'Paseo nocturno en barco por el río Sena con cena incluida.', CAST(40000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (3, N'Subida a la Torre Eiffel', N'Acceso prioritario a la Torre Eiffel con mirador nocturno.', CAST(20000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (4, N'Ciudadela Inca Machu Picchu', N'Caminata guiada por la Ciudadela Inca de Machu Picchu.', CAST(30000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (5, N'Valle Sagrado de los Incas', N'Excursión al Valle Sagrado con visita a Pisac y Ollantaytambo.', CAST(25000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (6, N'Camino Inca Corto', N'Trekking de 2 días por el Camino Inca.', CAST(50000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (7, N'Templo Senso-ji y Rickshaw', N'Tour por el Templo Senso-ji y paseo en rickshaw tradicional.', CAST(18000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (8, N'Monte Fuji y Lago Ashi', N'Excursión de un día completo al Monte Fuji y crucero por Lago Ashi.', CAST(45000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (9, N'Ceremonia del té japonesa', N'Experiencia cultural de ceremonia del té en Tokio.', CAST(15000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (10, N'Coliseo y Foro Romano', N'Visita guiada al Coliseo, Foro Romano y Palatino.', CAST(28000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (11, N'Ciudad del Vaticano', N'Tour por Museos Vaticanos y Capilla Sixtina.', CAST(35000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (12, N'Tour gastronómico en Roma', N'Degustación de pizza, pasta y gelato en un tour culinario.', CAST(25000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (13, N'Cerro Catedral', N'Excursión al Cerro Catedral para esquí o senderismo.', CAST(32000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (14, N'Lago Nahuel Huapi', N'Recorrido en barco por el Lago Nahuel Huapi hasta Isla Victoria.', CAST(30000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (15, N'Circuito Chico y Mirador Llao Llao', N'Excursión por Circuito Chico con miradores y chocolates.', CAST(18000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (16, N'Reloj Cucú y centro histórico', N'Visita guiada por el centro histórico y el famoso reloj Cucú.', CAST(12000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (17, N'Excursión al Lago San Roque', N'Paseo en catamarán por el Lago San Roque.', CAST(18000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (18, N'Aerosilla de Carlos Paz', N'Ascenso en aerosilla con vistas panorámicas de la ciudad.', CAST(15000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (19, N'Hollywood Walk of Fame', N'Recorrido a pie por el Paseo de la Fama de Hollywood.', CAST(25000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (20, N'Universal Studios Tour', N'Entrada y tour completo en Universal Studios Hollywood.', CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (21, N'Santa Monica Beach', N'Excursión a la playa de Santa Monica con guía.', CAST(20000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (22, N'Sydney Opera House Tour', N'Visita guiada a la icónica Ópera de Sídney.', CAST(35000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (23, N'Harbour Bridge Climb', N'Escalada guiada en el Sydney Harbour Bridge.', CAST(70000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (24, N'Blue Mountains Excursion', N'Excursión de día completo a las Montañas Azules.', CAST(55000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (25, N'Burj Khalifa Observation Deck', N'Entrada al mirador del Burj Khalifa.', CAST(50000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (26, N'Safari en el desierto', N'Excursión en 4x4 con cena en el desierto.', CAST(60000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (27, N'Dubai Mall y Acuario', N'Visita al Dubai Mall y entrada al acuario.', CAST(40000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (28, N'Faisal Mosque', N'Visita guiada a la Gran Mezquita Faisal.', CAST(15000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (29, N'Daman-e-Koh', N'Excursión al mirador Daman-e-Koh con vistas de Islamabad.', CAST(18000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[Excursiones] ([Id], [Nombre], [Descripcion], [Precio]) VALUES (30, N'Rawal Lake', N'Paseo en bote por el Lago Rawal.', CAST(20000.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[Excursiones] OFF
GO
SET IDENTITY_INSERT [dbo].[ViajeDetalles] ON 
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (1, 1, 1, 2, CAST(50000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (2, 1, 2, 2, CAST(80000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (3, 1, 3, 2, CAST(40000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (4, 2, 4, 5, CAST(150000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (5, 2, 5, 5, CAST(125000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (6, 2, 6, 5, CAST(250000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (7, 3, 7, 2, CAST(36000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (8, 3, 8, 2, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (9, 3, 9, 2, CAST(30000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (10, 5, 13, 3, CAST(96000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (11, 5, 14, 3, CAST(90000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (12, 5, 15, 3, CAST(54000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (13, 4, 10, 4, CAST(112000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (14, 4, 11, 4, CAST(140000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (15, 4, 12, 4, CAST(96000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (16, 6, 16, 3, CAST(36000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (17, 6, 17, 3, CAST(54000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (18, 6, 18, 3, CAST(45000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (19, 7, 19, 2, CAST(50000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (20, 7, 20, 2, CAST(120000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (21, 7, 21, 2, CAST(40000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (22, 8, 22, 4, CAST(140000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (23, 8, 23, 4, CAST(280000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (24, 8, 24, 4, CAST(220000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (25, 9, 25, 5, CAST(250000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (26, 9, 26, 5, CAST(300000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (27, 9, 27, 5, CAST(200000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (28, 10, 28, 3, CAST(45000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (29, 10, 29, 3, CAST(54000.00 AS Decimal(18, 2)))
GO
INSERT [dbo].[ViajeDetalles] ([Id], [ViajeId], [ExcursionId], [CantidadPersonas], [Subtotal]) VALUES (30, 10, 30, 3, CAST(60000.00 AS Decimal(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[ViajeDetalles] OFF
GO
SET IDENTITY_INSERT [dbo].[Viajes] ON 
GO
INSERT [dbo].[Viajes] ([Id], [Destino], [FechaInicio], [FechaFin], [PrecioTotal], [Estado]) VALUES (1, N'París, Francia', CAST(N'2025-09-28' AS Date), CAST(N'2025-10-06' AS Date), CAST(170000.00 AS Decimal(18, 2)), N'En Curso')
GO
INSERT [dbo].[Viajes] ([Id], [Destino], [FechaInicio], [FechaFin], [PrecioTotal], [Estado]) VALUES (2, N'Machu Picchu, Perú', CAST(N'2025-11-05' AS Date), CAST(N'2025-11-12' AS Date), CAST(545000.00 AS Decimal(18, 2)), N'Pendiente')
GO
INSERT [dbo].[Viajes] ([Id], [Destino], [FechaInicio], [FechaFin], [PrecioTotal], [Estado]) VALUES (3, N'Tokio, Japón', CAST(N'2025-12-01' AS Date), CAST(N'2025-12-08' AS Date), CAST(156000.00 AS Decimal(18, 2)), N'Confirmado')
GO
INSERT [dbo].[Viajes] ([Id], [Destino], [FechaInicio], [FechaFin], [PrecioTotal], [Estado]) VALUES (4, N'Roma, Italia', CAST(N'2025-07-10' AS Date), CAST(N'2025-07-17' AS Date), CAST(348000.00 AS Decimal(18, 2)), N'Cancelado')
GO
INSERT [dbo].[Viajes] ([Id], [Destino], [FechaInicio], [FechaFin], [PrecioTotal], [Estado]) VALUES (5, N'Bariloche, Argentina', CAST(N'2025-10-02' AS Date), CAST(N'2025-10-09' AS Date), CAST(150000.00 AS Decimal(18, 2)), N'En Curso')
GO
INSERT [dbo].[Viajes] ([Id], [Destino], [FechaInicio], [FechaFin], [PrecioTotal], [Estado]) VALUES (6, N'Carlos Paz, Argentina', CAST(N'2025-10-15' AS Date), CAST(N'2025-10-18' AS Date), CAST(135000.00 AS Decimal(18, 2)), N'Pendiente')
GO
INSERT [dbo].[Viajes] ([Id], [Destino], [FechaInicio], [FechaFin], [PrecioTotal], [Estado]) VALUES (7, N'Los Ángeles, EE. UU.', CAST(N'2025-09-25' AS Date), CAST(N'2025-10-05' AS Date), CAST(210000.00 AS Decimal(18, 2)), N'En Curso')
GO
INSERT [dbo].[Viajes] ([Id], [Destino], [FechaInicio], [FechaFin], [PrecioTotal], [Estado]) VALUES (8, N'Sídney, Australia', CAST(N'2025-08-10' AS Date), CAST(N'2025-08-20' AS Date), CAST(640000.00 AS Decimal(18, 2)), N'Cancelado')
GO
INSERT [dbo].[Viajes] ([Id], [Destino], [FechaInicio], [FechaFin], [PrecioTotal], [Estado]) VALUES (9, N'Dubái, Emiratos Árabes Unidos', CAST(N'2025-12-20' AS Date), CAST(N'2025-12-28' AS Date), CAST(550000.00 AS Decimal(18, 2)), N'Confirmado')
GO
INSERT [dbo].[Viajes] ([Id], [Destino], [FechaInicio], [FechaFin], [PrecioTotal], [Estado]) VALUES (10, N'Islamabad, Pakistán', CAST(N'2025-10-01' AS Date), CAST(N'2025-10-07' AS Date), CAST(159000.00 AS Decimal(18, 2)), N'En Curso')
GO
SET IDENTITY_INSERT [dbo].[Viajes] OFF
GO
ALTER TABLE [dbo].[ViajeDetalles]  WITH CHECK ADD  CONSTRAINT [FK_ViajeDetalles_Excursiones] FOREIGN KEY([ExcursionId])
REFERENCES [dbo].[Excursiones] ([Id])
GO
ALTER TABLE [dbo].[ViajeDetalles] CHECK CONSTRAINT [FK_ViajeDetalles_Excursiones]
GO
ALTER TABLE [dbo].[ViajeDetalles]  WITH CHECK ADD  CONSTRAINT [FK_ViajeDetalles_Viajes] FOREIGN KEY([ViajeId])
REFERENCES [dbo].[Viajes] ([Id])
GO
ALTER TABLE [dbo].[ViajeDetalles] CHECK CONSTRAINT [FK_ViajeDetalles_Viajes]
GO
USE [master]
GO
ALTER DATABASE [db_Viajes] SET  READ_WRITE 
GO
USE [db_Viajes]
GO
CREATE PROCEDURE SP_OBTENER_VIAJES_CAROS
AS
BEGIN
    SELECT 
        Id,
        Destino,
        FechaInicio,
        FechaFin,
        PrecioTotal,
        Estado
    FROM Viajes
    WHERE PrecioTotal > 100000
END
GO

CREATE PROCEDURE SP_OBTENER_PRIMER_VIAJE_POR_ESTADO
    @Estado VARCHAR(20)
AS
BEGIN
    SELECT TOP 1
        Id,
        Destino,
        FechaInicio,
        FechaFin,
        PrecioTotal,
        Estado
    FROM Viajes
    WHERE Estado = @Estado
    ORDER BY Id;
END
GO

CREATE PROCEDURE SP_OBTENER_EXCURSIONES_POR_VIAJE
    @ViajeId INT
AS
BEGIN
    SELECT 
        e.Id,
        e.Nombre,
        e.Descripcion,
        e.Precio
    FROM ViajeDetalles vd
    INNER JOIN Excursiones e ON vd.ExcursionId = e.Id
    WHERE vd.ViajeId = @ViajeId
    ORDER BY e.Nombre;
END
GO


CREATE PROCEDURE SP_ACTUALIZAR_FECHA_INICIO
    @Id INT,
    @NuevaFechaInicio DATE
AS
BEGIN
     UPDATE Viajes 
     SET FechaInicio = @NuevaFechaInicio
     WHERE Id = @Id;
END
GO

CREATE PROCEDURE SP_OBTENER_VIAJES_NO_CANCELADOS
AS
BEGIN
    SELECT 
        Id,
        Destino,
        FechaInicio,
        FechaFin,
        PrecioTotal,
        Estado
    FROM Viajes
    WHERE Estado != 'Cancelado'
    ORDER BY Estado, FechaInicio;
END
GO

CREATE PROCEDURE SP_OBTENER_VIAJE_POR_ID
    @Id INT
AS
BEGIN
    SELECT 
        Id,
        Destino,
        FechaInicio,
        FechaFin,
        PrecioTotal,
        Estado
    FROM Viajes
    WHERE Id = @Id;
END
GO

CREATE PROCEDURE SP_ACTUALIZAR_ESTADO_VIAJE
    @Id INT,
    @NuevoEstado VARCHAR(20)
AS
BEGIN
    UPDATE Viajes 
    SET Estado = @NuevoEstado
    WHERE Id = @Id;
END
GO