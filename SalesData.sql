USE [master]
GO
/****** Object:  Database [LumelTestDb]    Script Date: 11-05-2025 17:52:48 ******/
CREATE DATABASE [LumelTestDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LumelTestDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS10\MSSQL\DATA\LumelTestDb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LumelTestDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS10\MSSQL\DATA\LumelTestDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [LumelTestDb] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LumelTestDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LumelTestDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LumelTestDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LumelTestDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LumelTestDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LumelTestDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [LumelTestDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LumelTestDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LumelTestDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LumelTestDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LumelTestDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LumelTestDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LumelTestDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LumelTestDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LumelTestDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LumelTestDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [LumelTestDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LumelTestDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LumelTestDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LumelTestDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LumelTestDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LumelTestDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LumelTestDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LumelTestDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LumelTestDb] SET  MULTI_USER 
GO
ALTER DATABASE [LumelTestDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LumelTestDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LumelTestDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LumelTestDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LumelTestDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LumelTestDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [LumelTestDb] SET QUERY_STORE = OFF
GO
USE [LumelTestDb]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 11-05-2025 17:52:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Address] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataRefreshLogs]    Script Date: 11-05-2025 17:52:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataRefreshLogs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RefreshTime] [varchar](50) NULL,
	[IsSuccess] [varchar](50) NULL,
	[Message] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItems]    Script Date: 11-05-2025 17:52:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[QuantitySold] [int] NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[Discount] [decimal](5, 2) NULL,
	[ShippingCost] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 11-05-2025 17:52:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [nvarchar](50) NOT NULL,
	[DateOfSale] [date] NOT NULL,
	[Region] [nvarchar](100) NULL,
	[PaymentMethod] [nvarchar](50) NULL,
	[CustomerId] [int] NOT NULL,
	[Discount] [varchar](50) NULL,
	[ProductId] [varchar](50) NULL,
	[QuantitySold] [varchar](50) NULL,
	[ShippingCost] [varchar](50) NULL,
	[UnitPrice] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 11-05-2025 17:52:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [nvarchar](50) NOT NULL,
	[ProductName] [nvarchar](100) NULL,
	[Category] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [CustomerId], [Name], [Email], [Address]) VALUES (58, N'C456', N'John Smith', N'johnsmith@email.com', N'123 Main St, Anytown, CA 12345')
INSERT [dbo].[Customers] ([Id], [CustomerId], [Name], [Email], [Address]) VALUES (59, N'C789', N'Emily Davis', N'emilydavis@email.com', N'456 Elm St, Otherville, NY 54321')
INSERT [dbo].[Customers] ([Id], [CustomerId], [Name], [Email], [Address]) VALUES (60, N'C101', N'Sarah Johnson', N'sarahjohnson@email.com', N'789 Oak St, New City, TX 75024')
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[DataRefreshLogs] ON 

INSERT [dbo].[DataRefreshLogs] ([Id], [RefreshTime], [IsSuccess], [Message]) VALUES (1, N'2025-05-11 11:40:25.0020695', N'1', N'Data loaded successfully')
SET IDENTITY_INSERT [dbo].[DataRefreshLogs] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([Id], [OrderId], [DateOfSale], [Region], [PaymentMethod], [CustomerId], [Discount], [ProductId], [QuantitySold], [ShippingCost], [UnitPrice]) VALUES (1, N'1001', CAST(N'2023-12-15' AS Date), N'North America', N'Credit Card', 58, N'0.10', N'41', N'2', N'10.00', N'180.00')
INSERT [dbo].[Orders] ([Id], [OrderId], [DateOfSale], [Region], [PaymentMethod], [CustomerId], [Discount], [ProductId], [QuantitySold], [ShippingCost], [UnitPrice]) VALUES (2, N'1002', CAST(N'2024-01-03' AS Date), N'Europe', N'PayPal', 59, N'0.00', N'42', N'1', N'15.00', N'1299.00')
INSERT [dbo].[Orders] ([Id], [OrderId], [DateOfSale], [Region], [PaymentMethod], [CustomerId], [Discount], [ProductId], [QuantitySold], [ShippingCost], [UnitPrice]) VALUES (3, N'1003', CAST(N'2024-02-28' AS Date), N'Asia', N'Debit Card', 58, N'0.20', N'43', N'3', N'5.00', N'59.99')
INSERT [dbo].[Orders] ([Id], [OrderId], [DateOfSale], [Region], [PaymentMethod], [CustomerId], [Discount], [ProductId], [QuantitySold], [ShippingCost], [UnitPrice]) VALUES (4, N'1004', CAST(N'2024-03-10' AS Date), N'South America', N'Credit Card', 60, N'0.00', N'41', N'1', N'8.00', N'180.00')
INSERT [dbo].[Orders] ([Id], [OrderId], [DateOfSale], [Region], [PaymentMethod], [CustomerId], [Discount], [ProductId], [QuantitySold], [ShippingCost], [UnitPrice]) VALUES (5, N'1005', CAST(N'2024-04-22' AS Date), N'North America', N'PayPal', 59, N'0.15', N'44', N'1', N'12.00', N'349.99')
INSERT [dbo].[Orders] ([Id], [OrderId], [DateOfSale], [Region], [PaymentMethod], [CustomerId], [Discount], [ProductId], [QuantitySold], [ShippingCost], [UnitPrice]) VALUES (6, N'1006', CAST(N'2024-05-18' AS Date), N'Asia', N'Debit Card', 60, N'0.05', N'42', N'2', N'20.00', N'1299.00')
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [ProductId], [ProductName], [Category]) VALUES (41, N'P123', N'UltraBoost Running Shoes', N'Shoes')
INSERT [dbo].[Products] ([Id], [ProductId], [ProductName], [Category]) VALUES (42, N'P456', N'iPhone 15 Pro', N'Electronics')
INSERT [dbo].[Products] ([Id], [ProductId], [ProductName], [Category]) VALUES (43, N'P789', N'Levi''s 501 Jeans', N'Clothing')
INSERT [dbo].[Products] ([Id], [ProductId], [ProductName], [Category]) VALUES (44, N'P234', N'Sony WH-1000XM5 Headphones', N'Electronics')
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Customer__066785219668F383]    Script Date: 11-05-2025 17:52:48 ******/
ALTER TABLE [dbo].[Customers] ADD UNIQUE NONCLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Orders__999B5229CE573254]    Script Date: 11-05-2025 17:52:48 ******/
ALTER TABLE [dbo].[Orders] ADD UNIQUE NONCLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Products__2F4E024F626A1CED]    Script Date: 11-05-2025 17:52:48 ******/
ALTER TABLE [dbo].[Products] ADD UNIQUE NONCLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderItems] ADD  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[OrderItems] ADD  DEFAULT ((0)) FOR [ShippingCost]
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([Id])
GO
ALTER TABLE [dbo].[OrderItems]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
GO
USE [master]
GO
ALTER DATABASE [LumelTestDb] SET  READ_WRITE 
GO
