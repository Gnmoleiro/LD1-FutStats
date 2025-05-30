USE [master]
GO
/****** Object:  Database [Futstats]    Script Date: 4/6/2025 6:05:31 PM ******/
CREATE DATABASE [Futstats]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Futstats', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS03\MSSQL\DATA\Futstats.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Futstats_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS03\MSSQL\DATA\Futstats_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Futstats] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Futstats].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Futstats] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Futstats] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Futstats] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Futstats] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Futstats] SET ARITHABORT OFF 
GO
ALTER DATABASE [Futstats] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Futstats] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Futstats] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Futstats] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Futstats] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Futstats] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Futstats] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Futstats] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Futstats] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Futstats] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Futstats] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Futstats] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Futstats] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Futstats] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Futstats] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Futstats] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Futstats] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Futstats] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Futstats] SET  MULTI_USER 
GO
ALTER DATABASE [Futstats] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Futstats] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Futstats] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Futstats] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Futstats] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Futstats] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Futstats] SET QUERY_STORE = ON
GO
ALTER DATABASE [Futstats] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Futstats]
GO
/****** Object:  User [NovoLogin]    Script Date: 4/6/2025 6:05:32 PM ******/
CREATE USER [NovoLogin] FOR LOGIN [NovoLogin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [NovoLogin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [NovoLogin]
GO
/****** Object:  Table [dbo].[favoritos]    Script Date: 4/6/2025 6:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[favoritos](
	[id_fav] [int] IDENTITY(1,1) NOT NULL,
	[id_users] [int] NOT NULL,
	[id_tipos_fav] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_fav] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nacionalidades]    Script Date: 4/6/2025 6:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nacionalidades](
	[id_nacion_] [int] IDENTITY(1,1) NOT NULL,
	[nome_nascion] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_nacion_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipos_favoritos]    Script Date: 4/6/2025 6:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipos_favoritos](
	[id_tipos_fav_] [int] IDENTITY(1,1) NOT NULL,
	[tipo] [varchar](25) NOT NULL,
	[id_fav] [varchar](25) NOT NULL,
 CONSTRAINT [PK__tipos_fa__E6DC12D633033669] PRIMARY KEY CLUSTERED 
(
	[id_tipos_fav_] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 4/6/2025 6:05:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_nacion] [int] NULL,
	[nome] [varchar](255) NOT NULL,
	[data_nas] [date] NOT NULL,
	[email] [varchar](255) NOT NULL,
	[senha] [varchar](255) NOT NULL,
	[is_admin] [bit] NOT NULL,
	[status_user] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[favoritos] ON 

INSERT [dbo].[favoritos] ([id_fav], [id_users], [id_tipos_fav]) VALUES (1147, 3, 1123)
INSERT [dbo].[favoritos] ([id_fav], [id_users], [id_tipos_fav]) VALUES (1156, 3, 1129)
INSERT [dbo].[favoritos] ([id_fav], [id_users], [id_tipos_fav]) VALUES (1157, 3, 1121)
SET IDENTITY_INSERT [dbo].[favoritos] OFF
GO
SET IDENTITY_INSERT [dbo].[nacionalidades] ON 

INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (1, N'Afegão')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (2, N'Albanês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (3, N'Alemão')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (4, N'Andorrano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (5, N'Angolano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (6, N'Antiguano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (7, N'Árabe')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (8, N'Argentino')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (9, N'Armênio')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (10, N'Australiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (11, N'Austríaco')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (12, N'Azerbaijano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (13, N'Bahamense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (14, N'Bahreinita')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (15, N'Bangladeshiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (16, N'Barbadiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (17, N'Belga')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (18, N'Belizenho')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (19, N'Beninense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (20, N'Bielorrusso')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (21, N'Birmanês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (22, N'Boliviano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (23, N'Bósnio')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (24, N'Botsuano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (25, N'Brasileiro')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (26, N'Bruneano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (27, N'Búlgaro')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (28, N'Burquinês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (29, N'Burundiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (30, N'Cabo-Verdiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (31, N'Camaronês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (32, N'Canadense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (33, N'Catarense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (34, N'Chinês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (35, N'Cipriota')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (36, N'Comorense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (37, N'Congolês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (38, N'Coreano do Norte')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (39, N'Coreano do Sul')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (40, N'Costa-Marfinense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (41, N'Costarriquenho')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (42, N'Croata')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (43, N'Cubano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (44, N'Dinamarquês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (45, N'Dominicano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (46, N'Egípcio')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (48, N'Emiratense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (49, N'Equatoriano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (50, N'Eritreu')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (51, N'Eslovaco')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (52, N'Esloveno')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (53, N'Espanhol')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (54, N'Estoniano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (55, N'Eswatini')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (56, N'Etíope')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (57, N'Fijiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (58, N'Filipino')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (59, N'Finlandês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (60, N'Gabonês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (61, N'Gambiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (62, N'Georgiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (63, N'Granadino')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (64, N'Grego')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (65, N'Guatemalteco')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (66, N'Guineano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (67, N'Guineense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (68, N'Guineu-equatoriano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (69, N'Haitiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (70, N'Hondurenho')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (71, N'Húngaro')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (72, N'Iemenita')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (73, N'Indiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (74, N'Indonésio')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (75, N'Iraniano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (76, N'Iraquiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (77, N'Irlandês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (78, N'Islandês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (79, N'Israelense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (80, N'Italiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (81, N'Jamaicano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (82, N'Japonês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (83, N'Jordano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (84, N'Kiribatiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (85, N'Kuwaitiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (86, N'Laociano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (87, N'Lesoto')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (88, N'Letão')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (89, N'Libanês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (90, N'Liberiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (91, N'Líbio')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (92, N'Lituano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (93, N'Luxemburguês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (94, N'Macedônio')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (95, N'Malásio')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (96, N'Malauiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (97, N'Maldivo')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (98, N'Maliano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (99, N'Maltês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (100, N'Marroquino')
GO
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (101, N'Mauriciano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (102, N'Mauritano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (103, N'Mexicano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (104, N'Micronésio')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (109, N'Moçambicano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (105, N'Moldavo')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (106, N'Monegasco')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (107, N'Mongol')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (108, N'Montenegrino')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (110, N'Namibiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (111, N'Nauruano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (113, N'Neozelandês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (112, N'Nepalês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (114, N'Nigeriano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (115, N'Nigerino')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (116, N'Norueguês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (117, N'Omani')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (118, N'Palauense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (119, N'Panamenho')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (120, N'Papua')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (121, N'Paquistanês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (122, N'Paraguaio')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (123, N'Peruano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (124, N'Polaco')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (125, N'Português')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (126, N'Queniano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (127, N'Quirguiz')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (129, N'Romeno')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (128, N'Ruandês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (130, N'Russo')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (131, N'Salomonense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (47, N'Salvadorenho')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (132, N'Samoano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (133, N'São-tomense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (134, N'São-vicentino')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (135, N'Senegalês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (136, N'Serra-leonino')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (137, N'Sérvio')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (138, N'Seychelense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (139, N'Sírio')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (140, N'Somali')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (145, N'Sueco')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (146, N'Suíço')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (141, N'Sul-africano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (142, N'Sul-coreano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (143, N'Sul-sudanês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (144, N'Surinamês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (149, N'Tailandês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (147, N'Tajique')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (148, N'Tanzaniano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (150, N'Timorense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (151, N'Togolês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (152, N'Tonganês')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (153, N'Trinitário')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (154, N'Tunisiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (155, N'Turco')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (156, N'Turcomeno')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (157, N'Tuvaluano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (158, N'Ucraniano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (159, N'Ugandense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (160, N'Uruguaio')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (161, N'Uzbeque')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (162, N'Vanuatuense')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (163, N'Venezuelano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (164, N'Vietnamita')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (165, N'Zambiano')
INSERT [dbo].[nacionalidades] ([id_nacion_], [nome_nascion]) VALUES (166, N'Zimbabuano')
SET IDENTITY_INSERT [dbo].[nacionalidades] OFF
GO
SET IDENTITY_INSERT [dbo].[tipos_favoritos] ON 

INSERT [dbo].[tipos_favoritos] ([id_tipos_fav_], [tipo], [id_fav]) VALUES (31, N'liga', N'CLI')
INSERT [dbo].[tipos_favoritos] ([id_tipos_fav_], [tipo], [id_fav]) VALUES (1052, N'liga', N'SA')
INSERT [dbo].[tipos_favoritos] ([id_tipos_fav_], [tipo], [id_fav]) VALUES (1059, N'clube', N'57')
INSERT [dbo].[tipos_favoritos] ([id_tipos_fav_], [tipo], [id_fav]) VALUES (1063, N'clube', N'397')
INSERT [dbo].[tipos_favoritos] ([id_tipos_fav_], [tipo], [id_fav]) VALUES (1068, N'jogador', N'28612')
INSERT [dbo].[tipos_favoritos] ([id_tipos_fav_], [tipo], [id_fav]) VALUES (1072, N'jogador', N'8279')
INSERT [dbo].[tipos_favoritos] ([id_tipos_fav_], [tipo], [id_fav]) VALUES (1121, N'liga', N'PL')
INSERT [dbo].[tipos_favoritos] ([id_tipos_fav_], [tipo], [id_fav]) VALUES (1123, N'clube', N'64')
INSERT [dbo].[tipos_favoritos] ([id_tipos_fav_], [tipo], [id_fav]) VALUES (1129, N'jogador', N'3754')
SET IDENTITY_INSERT [dbo].[tipos_favoritos] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [id_nacion], [nome], [data_nas], [email], [senha], [is_admin], [status_user]) VALUES (3, 4, N'jorge12', CAST(N'2006-03-26' AS Date), N'jorge@gmail.com', N'$2b$10$YdmMmTn22wrSwo0DedeiJO1hzmmwGSYzmuL0JgqUC7rEh1zzVX73m', 0, 1)
INSERT [dbo].[users] ([id], [id_nacion], [nome], [data_nas], [email], [senha], [is_admin], [status_user]) VALUES (14, 125, N'Admin FutStats', CAST(N'2006-05-21' AS Date), N'admin@futstats.com', N'$2b$10$fihhzr7Blwdx1viTaraFluGdvxTvKAr2wp7BYcHZnYPAFJ/PM1aDO', 1, 1)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__nacional__4403478FF9929381]    Script Date: 4/6/2025 6:05:33 PM ******/
ALTER TABLE [dbo].[nacionalidades] ADD UNIQUE NONCLUSTERED 
(
	[nome_nascion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__AB6E61645A005356]    Script Date: 4/6/2025 6:05:33 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [is_admin]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((1)) FOR [status_user]
GO
ALTER TABLE [dbo].[favoritos]  WITH CHECK ADD  CONSTRAINT [FK__favoritos__id_ti__5535A963] FOREIGN KEY([id_tipos_fav])
REFERENCES [dbo].[tipos_favoritos] ([id_tipos_fav_])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[favoritos] CHECK CONSTRAINT [FK__favoritos__id_ti__5535A963]
GO
ALTER TABLE [dbo].[favoritos]  WITH CHECK ADD FOREIGN KEY([id_users])
REFERENCES [dbo].[users] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD FOREIGN KEY([id_nacion])
REFERENCES [dbo].[nacionalidades] ([id_nacion_])
ON DELETE SET NULL
GO
USE [master]
GO
ALTER DATABASE [Futstats] SET  READ_WRITE 
GO
