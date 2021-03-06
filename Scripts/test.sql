USE [master]
GO
/****** Object:  Database [DWWeatherTracker]    Script Date: 2016/5/15 19:43:55 ******/
CREATE DATABASE [DWWeatherTracker]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DWWeatherTracker', FILENAME = N'your place\DWWeatherTracker.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DWWeatherTracker_log', FILENAME = N'your place\DWWeatherTracker_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DWWeatherTracker] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DWWeatherTracker].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DWWeatherTracker] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET ARITHABORT OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [DWWeatherTracker] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DWWeatherTracker] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DWWeatherTracker] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DWWeatherTracker] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DWWeatherTracker] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET RECOVERY FULL 
GO
ALTER DATABASE [DWWeatherTracker] SET  MULTI_USER 
GO
ALTER DATABASE [DWWeatherTracker] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DWWeatherTracker] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DWWeatherTracker] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DWWeatherTracker] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DWWeatherTracker', N'ON'
GO
USE [DWWeatherTracker]
GO
/****** Object:  Table [dbo].[DimEvents]    Script Date: 2016/5/15 19:43:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DimEvents](
	[EventKey] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [varchar](50) NOT NULL,
 CONSTRAINT [PK DimEvents] PRIMARY KEY CLUSTERED 
(
	[EventKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FactWeather]    Script Date: 2016/5/15 19:43:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FactWeather](
	[Date] [datetime] NOT NULL,
	[EventKey] [int] NOT NULL,
	[MaxTempF] [int] NOT NULL,
	[MinTempF] [int] NOT NULL,
 CONSTRAINT [PKFactWeathers] PRIMARY KEY CLUSTERED 
(
	[Date] ASC,
	[EventKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WeatherHistoryStaging]    Script Date: 2016/5/15 19:43:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WeatherHistoryStaging](
	[Date] [varchar](50) NULL,
	[Max TemperatureF] [varchar](50) NULL,
	[Min TemperatureF] [varchar](50) NULL,
	[Events] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[FactWeather]  WITH CHECK ADD  CONSTRAINT [FK FactWeather DimEvents] FOREIGN KEY([EventKey])
REFERENCES [dbo].[DimEvents] ([EventKey])
GO
ALTER TABLE [dbo].[FactWeather] CHECK CONSTRAINT [FK FactWeather DimEvents]
GO
USE [master]
GO
ALTER DATABASE [DWWeatherTracker] SET  READ_WRITE 
GO
