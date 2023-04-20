--CREATE DB
CREATE DATABASE JustDoItDb
GO

--DROP DB
USE [master]
DROP DATABASE JustDoItDb
GO

--USE DB
USE JustDoItDb
GO

--ADD TABLE CATEGORY
CREATE TABLE Category (
	Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT (NEWSEQUENTIALID()),
	[Name] NVARCHAR(50) UNIQUE NOT NULL 
)
GO

--ADD CATEGORY
INSERT INTO Category ([Name])
VALUES (N'Family')

--SELECT ALL CATEGORIES
SELECT Category.Id, Category.[Name], COUNT(Job.CategoryId) AS CountOfJobs FROM Category LEFT JOIN Job ON Category.Id = Job.CategoryId GROUP BY Category.Id, Category.[Name] ORDER BY CountOfJobs DESC

--SELECT CATEGORY BY NAME
SELECT * FROM Category
WHERE [Name] = N'Girl'

--DELETE CATEGORY
DELETE FROM Category
WHERE Id = '8448E305-0EDA-ED11-A494-9F04D8B157FC'

--ADD TABLE JOB
CREATE TABLE Job (
	Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT (NEWSEQUENTIALID()),
	CategoryId UNIQUEIDENTIFIER NOT NULL REFERENCES Category(Id) ON DELETE CASCADE ON UPDATE CASCADE,

	[Name] NVARCHAR(100) NOT NULL,
	IsCompleted BIT NOT NULL DEFAULT 0,
	DueDate DATETIME NOT NULL,
)
GO

--ADD JOB
INSERT INTO Job (CategoryId, [Name], DueDate, IsCompleted) VALUES ('003A73CF-7DDB-ED11-A495-BE781799F978', N'Купити канцелярію', GETDATE() + 1, 0)

--SELECT ALL JOBS
SELECT Job.Id, Job.[Name], Category.[Name] AS CategoryName, Job.IsCompleted, Job.DueDate,  ABS(DATEDIFF(MINUTE, GETDATE(), Job.DueDate)) AS DateDifferenceInMinutes FROM Job INNER JOIN Category ON Category.Id = Job.CategoryId
ORDER BY  Job.IsCompleted, DateDifferenceInMinutes

SELECT Job.Id, Job.[Name], Category.[Name] AS CategoryName, Job.IsCompleted, Job.DueDate,  ABS(DATEDIFF(MINUTE, GETDATE(), Job.DueDate)) AS DateDifferenceInMinutes FROM Job INNER JOIN Category ON Category.Id = Job.CategoryId
WHERE CategoryId = '29755D94-A6DC-ED11-A496-C6D142DF2FCB'
ORDER BY  Job.IsCompleted, DateDifferenceInMinutes