IF OBJECT_ID('dbo.Clients', 'U') IS NOT NULL DROP TABLE dbo.Clients;
IF OBJECT_ID('dbo.Consultants', 'U') IS NOT NULL DROP TABLE dbo.Consultants;
IF OBJECT_ID('dbo.Assignments', 'U') IS NOT NULL DROP TABLE dbo.Assignments;
GO

CREATE TABLE dbo.Clients
(
    ClientID INT IDENTITY(1,1) PRIMARY KEY,
    OrganizationNumber VARCHAR(12) NOT NULL UNIQUE,
    CompanyName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(20) NOT NULL
);
GO

CREATE TABLE dbo.Consultants
(
    ConsultantID INT IDENTITY(1,1) PRIMARY KEY,
    PersonalNumber CHAR(12) NOT NULL UNIQUE,
    FullName NVARCHAR(100) NOT NULL,
    HourlyRate DECIMAL(10,2) NOT NULL,
    Specialty NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE dbo.Assignments
(
    AssignmentID INT IDENTITY(1,1) PRIMARY KEY,
    ClientID INT NOT NULL,
    ConsultantID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    RoleDescription NVARCHAR(255) NOT NULL,

    CONSTRAINT FK_Assignments_Clients
        FOREIGN KEY (ClientID) REFERENCES dbo.Clients(ClientID),

    CONSTRAINT FK_Assignments_Consultants
        FOREIGN KEY (ConsultantID) REFERENCES dbo.Consultants(ConsultantID)
);
GO

-- CLients
INSERT INTO dbo.Clients
(OrganizationNumber, CompanyName, Email, PhoneNumber)
VALUES
('559321-4567', 'Arctic Data Solutions', 'contact@arcticdata.com', '08-7788990'),
('556654-2211', 'Digital Horizon Nordic', 'info@digitalhorizon.com', '031-4433221'),
('559876-5432', 'BluePeak Systems', 'support@bluepeak.com', '010-5432198'),
('558765-4321', 'Inactive Customer Ltd', 'admin@inactivecustomer.com', '08-1122334');

-- Consultants
INSERT INTO dbo.Consultants
(PersonalNumber, FullName, HourlyRate, Specialty)
VALUES
('198904151122', 'John Anderson', 1300.00, 'Cloud Security'),
('199203088899', 'Linda Svensson', 1200.00, 'Platform Engineering'),
('199511176655', 'David Carlson', 1100.00, 'Backend Development'),
('198707244433', 'Emma Holmes', 1500.00, 'Azure Architecture');

-- Assignments
INSERT INTO dbo.Assignments
(ClientID, ConsultantID, StartDate, EndDate, RoleDescription)
VALUES
(1, 1, '2026-01-10', '2026-05-30',
 'Cloud security assessment'),

(1, 2, '2026-02-15', '2026-07-31',
 'CI/CD platform implementation'),

(2, 2, '2026-03-05', '2026-09-15',
 'Container platform modernization'),

(2, 3, '2026-04-01', '2026-10-01',
 'REST API development'),

(3, 4, '2026-05-15', '2026-12-20',
 'Azure infrastructure design'),

(3, 1, '2026-06-10', '2026-08-15',
 'Internal web application security review');
GO

-- A
SELECT FullName, HourlyRate
FROM dbo.Consultants
WHERE HourlyRate > 1200.00
ORDER BY HourlyRate DESC;

-- B
SELECT
    c.CompanyName,
    co.FullName AS ConsultantName,
    a.StartDate,
    a.EndDate,
    a.RoleDescription
FROM dbo.Assignments a
INNER JOIN dbo.Clients c
    ON a.ClientID = c.ClientID
INNER JOIN dbo.Consultants co
    ON a.ConsultantID = co.ConsultantID;

-- C
SELECT
    c.CompanyName,
    COUNT(a.AssignmentID) AS TotalAssignments
FROM dbo.Clients c
LEFT JOIN dbo.Assignments a
    ON c.ClientID = a.ClientID
GROUP BY c.ClientID, c.CompanyName;

-- D
UPDATE dbo.Consultants
SET HourlyRate = 1350.00
WHERE PersonalNumber = '199203088899';

-- E
DELETE FROM dbo.Clients
WHERE ClientID NOT IN
(
    SELECT DISTINCT ClientID
    FROM dbo.Assignments
)
AND OrganizationNumber = '558765-4321';
GO