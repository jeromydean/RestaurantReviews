USE [master]
GO
/****** Object:  Database [RestaurantReviews]    Script Date: 1/21/2016 1:40:05 PM ******/
CREATE DATABASE [RestaurantReviews]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RestaurantReviews', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\RestaurantReviews.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'RestaurantReviews_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\RestaurantReviews_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [RestaurantReviews] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RestaurantReviews].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RestaurantReviews] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RestaurantReviews] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RestaurantReviews] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RestaurantReviews] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RestaurantReviews] SET ARITHABORT OFF 
GO
ALTER DATABASE [RestaurantReviews] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RestaurantReviews] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [RestaurantReviews] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RestaurantReviews] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RestaurantReviews] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RestaurantReviews] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RestaurantReviews] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RestaurantReviews] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RestaurantReviews] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RestaurantReviews] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RestaurantReviews] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RestaurantReviews] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RestaurantReviews] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RestaurantReviews] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RestaurantReviews] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RestaurantReviews] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RestaurantReviews] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RestaurantReviews] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RestaurantReviews] SET RECOVERY FULL 
GO
ALTER DATABASE [RestaurantReviews] SET  MULTI_USER 
GO
ALTER DATABASE [RestaurantReviews] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RestaurantReviews] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RestaurantReviews] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RestaurantReviews] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'RestaurantReviews', N'ON'
GO
USE [RestaurantReviews]
GO
/****** Object:  StoredProcedure [dbo].[CreateMember]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateMember]
	@memberid bigint OUTPUT,
	@username nvarchar(50),
	@firstname nvarchar(50),
	@lastname nvarchar(50),
	@email nvarchar(50)
AS
BEGIN
	insert into Member(UserName,FirstName,LastName,Email)values(@username,@firstname,@lastname,@email);
	select @memberid = SCOPE_IDENTITY();
END

GO
/****** Object:  StoredProcedure [dbo].[CreateRestaurant]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateRestaurant]
	@restaurantid bigint OUTPUT,
	@name nvarchar(100)
AS
BEGIN
	insert into Restaurant(name)values(@name);
	select @restaurantid = SCOPE_IDENTITY();
END

GO
/****** Object:  StoredProcedure [dbo].[CreateRestaurantAddress]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateRestaurantAddress]
	@restaurantaddressid bigint OUTPUT,
	@restaurantid bigint,
	@street1 nvarchar(100),
	@street2 nvarchar(100),
	@city nvarchar(100),
	@region nvarchar(100),
	@postalcode nvarchar(10)
AS
BEGIN
	insert into RestaurantAddress
           (Restaurant_ID
           ,Street1
           ,Street2
           ,City
           ,Region
           ,PostalCode)
	values
		(
			@restaurantid,
			@street1,
			@street2,
			@city,
			@region,
			@postalcode
		);

	select @restaurantaddressid = SCOPE_IDENTITY();
END

GO
/****** Object:  StoredProcedure [dbo].[CreateReview]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateReview]
	@reviewId bigint OUTPUT,
	@restaurantid bigint,
	@memberid bigint,
	@body nvarchar(max)
AS
BEGIN
	insert into Review(Restaurant_Id,Member_Id,Body)values(@restaurantid,@memberid,@body);
	select @reviewId = SCOPE_IDENTITY();
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteMember]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteMember]
	@memberid bigint
AS
BEGIN
	delete from Member where id = @memberid
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteRestaurant]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteRestaurant]
	@restaurantid bigint
AS
BEGIN
	delete from Restaurant where id = @restaurantid
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteRestaurantAddress]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteRestaurantAddress]
	@restaurantid bigint,
	@restaurantaddressid bigint
AS
BEGIN
	delete from RestaurantAddress where id = @restaurantaddressid and Restaurant_Id = @restaurantid
END

GO
/****** Object:  StoredProcedure [dbo].[DeleteReview]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteReview]
	@reviewId bigint
AS
BEGIN
	delete from Review where ID = @reviewId
END

GO
/****** Object:  StoredProcedure [dbo].[GetMember]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetMember]
	@memberid bigint
AS
BEGIN
	select
		*
	from
		Member m
	where
		m.Id = @memberid
END

GO
/****** Object:  StoredProcedure [dbo].[GetRestaurant]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRestaurant]
	@restaurantid bigint
AS
BEGIN
	select
		*
	from
		Restaurant r
	where
		r.Id = @restaurantid
END

GO
/****** Object:  StoredProcedure [dbo].[GetRestaurantAddress]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRestaurantAddress]
	@restaurantId bigint,
	@restaurantaddressid bigint
AS
BEGIN
	select
		*
	from
		RestaurantAddress ra
	where
		ra.Restaurant_Id = @restaurantId
		and
		ra.Id = @restaurantaddressid
END

GO
/****** Object:  StoredProcedure [dbo].[GetRestaurantAddresses]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRestaurantAddresses]
	@restaurantId bigint
AS
BEGIN
	select
		*
	from
		RestaurantAddress ra
	where
		ra.Restaurant_Id = @restaurantId
END

GO
/****** Object:  StoredProcedure [dbo].[GetRestaurantsByCityRegion]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetRestaurantsByCityRegion]
	@city nvarchar(100),
	@region nvarchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select
		r.*
	from
		Restaurant r
		inner join
		(
		select
			distinct Restaurant_id
		from
			RestaurantAddress ra
		where
			ra.City like isnull(@city,'') + '%'
			and
			ra.Region like isnull(@region,'') + '%'
		) ids
		on ids.Restaurant_id = r.Id
	
END

GO
/****** Object:  StoredProcedure [dbo].[GetReview]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetReview]
	@reviewid bigint
AS
BEGIN
	select
		*
	from
		Review r
	where
		r.Id = @reviewid
END

GO
/****** Object:  StoredProcedure [dbo].[GetReviewsByMember]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetReviewsByMember]
	@memberId bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select
		*
	from
		Review r
	where
		r.Member_Id = @memberId
END


GO
/****** Object:  StoredProcedure [dbo].[GetReviewsByRestaurant]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetReviewsByRestaurant]
	@restaurantId bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select
		*
	from
		Review r
	where
		r.Restaurant_Id = @restaurantId
END


GO
/****** Object:  StoredProcedure [dbo].[UpdateMember]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateMember]
	@memberid bigint,
	@username nvarchar(50),
	@firstname nvarchar(50),
	@lastname nvarchar(50),
	@email nvarchar(50)
AS
BEGIN
	update member set UserName = @username, FirstName = @firstname, LastName = @lastname, Email = @email where id = @memberid
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateRestaurant]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateRestaurant]
	@restaurantid bigint,
	@name nvarchar(100)
AS
BEGIN
	update Restaurant set Name = @name where Id = @restaurantid
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateRestaurantAddress]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateRestaurantAddress]
	@restaurantaddressid bigint,
	@restaurantid bigint,
	@street1 nvarchar(100),
	@street2 nvarchar(100),
	@city nvarchar(100),
	@region nvarchar(100),
	@postalcode nvarchar(10)
AS
BEGIN
	update RestaurantAddress
	set 
		Street1 = @street1,
		Street2 = @street2,
		City = @city,
		Region = @region,
		PostalCode = @postalcode
	 where
		ID = @restaurantaddressid
		and
		Restaurant_Id = @restaurantid
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateReview]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateReview]
	@reviewid bigint,
	@restaurantid bigint,
	@memberid bigint,
	@body nvarchar(max)
AS
BEGIN
	update Review set Restaurant_Id = @restaurantid, Member_Id = @memberid, body = @body where ID = @reviewid
END

GO
/****** Object:  Table [dbo].[Member]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Restaurant]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurant](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Restaurant] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RestaurantAddress]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestaurantAddress](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Restaurant_ID] [bigint] NOT NULL,
	[Street1] [nvarchar](100) NULL,
	[Street2] [nvarchar](100) NULL,
	[City] [nvarchar](100) NOT NULL,
	[Region] [nvarchar](100) NOT NULL,
	[PostalCode] [nvarchar](10) NULL,
 CONSTRAINT [PK_RestaurantAddress] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Review]    Script Date: 1/21/2016 1:40:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Review](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Restaurant_ID] [bigint] NOT NULL,
	[Member_ID] [bigint] NOT NULL,
	[Body] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RestaurantAddress_City_Region]    Script Date: 1/21/2016 1:40:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_RestaurantAddress_City_Region] ON [dbo].[RestaurantAddress]
(
	[City] ASC,
	[Region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_RestaurantAddress_Restaurant_Id]    Script Date: 1/21/2016 1:40:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_RestaurantAddress_Restaurant_Id] ON [dbo].[RestaurantAddress]
(
	[Restaurant_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Member_Id]    Script Date: 1/21/2016 1:40:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_Member_Id] ON [dbo].[Review]
(
	[Member_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Review_Restaurant_Id]    Script Date: 1/21/2016 1:40:05 PM ******/
CREATE NONCLUSTERED INDEX [IX_Review_Restaurant_Id] ON [dbo].[Review]
(
	[Restaurant_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RestaurantAddress]  WITH CHECK ADD  CONSTRAINT [FK_RestaurantAddress_Restaurant] FOREIGN KEY([Restaurant_ID])
REFERENCES [dbo].[Restaurant] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RestaurantAddress] CHECK CONSTRAINT [FK_RestaurantAddress_Restaurant]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Member] FOREIGN KEY([Member_ID])
REFERENCES [dbo].[Member] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Member]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Restaurant] FOREIGN KEY([Restaurant_ID])
REFERENCES [dbo].[Restaurant] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Restaurant]
GO
USE [master]
GO
ALTER DATABASE [RestaurantReviews] SET  READ_WRITE 
GO
