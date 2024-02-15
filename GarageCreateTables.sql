USE GarageDB

/*
Note:
Frameworks like C# automatically convert NULL values to default values, such as 0 for integers and decimals. 
Therefore, it's worth reconsidering the use of the NOT NULL keyword in these SQL queries. 
Depending on your project requirements, you might want to remove the NOT NULL keyword 
and handle null values through backend server logic (allowing more flexibility). 
*/

-- Role table (connected with GarageUser AND Permission tables | one-to-one AND one-to-many, respectively)
CREATE TABLE UserRole (
    RoleId int IDENTITY(1,1) PRIMARY KEY,
    RoleName varchar(50) UNIQUE NOT NULL
);

-- Permission table (connected with Role table | one-to-'0 or many')
CREATE TABLE Permission (
    PermissionId int IDENTITY(1,1) PRIMARY KEY,
    PermissionName varchar(50) UNIQUE NOT NULL
);

-- User (connected with the UserRole and Vehicle Table | one-to-one and one-to-'0 or many', respectively)
CREATE TABLE GarageUser (
    UserId int IDENTITY(1,1) PRIMARY KEY,
    Username varchar(50) UNIQUE NOT NULL,
    PasswordHash varbinary(64) NOT NULL,
    Email varchar(255) UNIQUE NOT NULL,
    RoleId int FOREIGN KEY REFERENCES UserRole(RoleId)
);

-- Many-to-Many table between Role and Permission table
CREATE TABLE Role_Permission (
    RoleId int FOREIGN KEY REFERENCES UserRole(RoleId),
    PermissionId int FOREIGN KEY REFERENCES Permission(PermissionId),
    PRIMARY KEY (RoleId, PermissionId)
);

-- VAT table (connected with MainVehicleInfo table | one-to-many)
CREATE TABLE VAT (
    VatId int IDENTITY(1,1) PRIMARY KEY,
    VatDescription varchar(200) UNIQUE NOT NULL,
    VatPercentage decimal(5,2) NOT NULL
);

-- Outfitter table (connected with MainVehicleInfo table | one-to-many)
CREATE TABLE Outfitter (
    OutfitterId int IDENTITY(1,1) PRIMARY KEY,
    OutfitterDescription varchar(200) UNIQUE NOT NULL
);

-- MainVehicleInfo table (connected with Vehicle, VAT and Outfitter table | one-to-one and many-to-one, respectively)
CREATE TABLE MainVehicleInfo (
    MainVehicleInfoId int PRIMARY KEY,
	OnwerFullName varchar(255) NOT NULL, 
    SupplierVehicleDescription varchar(255) NOT NULL, 
    SupplierVehicleCode varchar(50) NOT NULL,
    BrandName varchar(100) NOT NULL,
    ModelName varchar(100) NOT NULL,
	Mileage int NOT NULL,
	ManufactureYear int NOT NULL,
    NumberOfDoors int NULL,
    NumberOfSeats int NULL,
    FuelCapacity decimal(18,2) NULL,
	FuelType varchar(50) NOT NULL,
	VehicleWeight decimal(18,2) NOT NULL,
    VehicleLength decimal(18,2) NOT NULL,
    VehicleWidth decimal(18,2) NOT NULL,
    VehicleHeight decimal(18,2) NOT NULL,
	Color varchar(50) NULL,
	DeliveryDate DATE NOT NULL,
	EngineSize varchar(50) NOT NULL,
	EngineType varchar(50) NOT NULL,
	HorsePower int NOT NULL,
	Torque int NULL,
	TransmissionType varchar(50) NULL,
	Wheelbase decimal(18,2) NULL,
    isRecyclable bit NOT NULL,
    WarrantyAmount decimal(18,2) NULL,
    WarrantyExpirationDate DATE NULL,
    VatId int FOREIGN KEY REFERENCES VAT(VatId) NOT NULL,
    OutfitterId int FOREIGN KEY REFERENCES Outfitter(OutfitterId) NOT NULL
);

-- Service table (connected with GarageVehicleInfo | many-to-one)
CREATE TABLE GarageService (
    ServiceId int PRIMARY KEY,
    ServiceName varchar(100) UNIQUE NOT NULL,
    ServiceDescription varchar(255) NULL,
    ServicePrice decimal(18,2) NOT NULL,
    DurationInMinutes int NOT NULL,
    RequiredEquipment varchar(255) NOT NULL
);

-- PartReplacement table (connected with GarageVehicleInfo | many-to-one)
CREATE TABLE PartReplacement (
    ReplacementId int PRIMARY KEY,
    PartName varchar(100) UNIQUE NOT NULL,
	PartDescription varchar(255) NULL,
    ReplacementDate DATE NOT NULL,
    PartPrice decimal(18,2) NOT NULL,
    PartSupplierName varchar(100) NOT NULL
);

-- GarageVehicleInfo table (connected with Vehicle, GarageService and PartReplacement | one-to-one, one-to-many, respectively)
CREATE TABLE GarageVehicleInfo (
    GarageVehicleInfoId int PRIMARY KEY,
	GarageName varchar(100) UNIQUE NOT NULL,
    GarageAddress varchar(255) NOT NULL,
	GarageContact varchar(100) NOT NULL,
    ServiceId int FOREIGN KEY REFERENCES GarageService(ServiceId),
    ReplacementId int FOREIGN KEY REFERENCES PartReplacement(ReplacementId),
);

-- VehicleManager table (connected with Vehicle table | one-to-one)
CREATE TABLE VehicleManager (
    VehicleManagerId int IDENTITY(1,1) PRIMARY KEY,
    VehicleDescription varchar(255) UNIQUE NOT NULL
);

-- Invoice table (connected with Vehicle table | one-to-one)
CREATE TABLE Invoice (
    InvoiceId int PRIMARY KEY,
    CustomerFullName varchar(50) NOT NULL,
    InvoiceDate DATE NOT NULL,
	PaymentMethod varchar(50) NOT NULL,
    SupplierPrice decimal(18,5) NULL,
    DiscountUnit decimal(18,2) NULL,
    DiscountAmount varchar(50) NULL,
    TurnoverDiscountUnit varchar(50) NULL,
    TurnoverDiscountAmount decimal(18,2) NULL,
    ChargeUnit varchar(50) NULL,
    ChargeAmount decimal (18,2) NULL,
    GeneralTaxUnit varchar (50) NULL,
    GeneralTaxAmount decimal (18,5) NULL,
    RecyclingTaxUnit varchar (50) NULL,
    RecyclingTaxAmount decimal (18,5) NULL,
	TotalCostUnit varchar (50) NOT NULL,
	TotalCostAmount decimal (18,5) NOT NULL
);

-- Vehicle Status table (connected with Vehicle table | one-to-'0 or many')
CREATE TABLE VehicleStatus (
    StatusId tinyint IDENTITY(1,1) PRIMARY KEY,
    StatusDescription varchar(50) UNIQUE NOT NULL,
	UpdatedDate DATE NOT NULL
);

-- QuestionnaireBooleanAttribute table (connected with Vehicle Table | one-to-'0 or many')
CREATE TABLE QuestionnaireBooleanAttribute (
    QuestionnaireBooleanAttributeId int IDENTITY(1,1) PRIMARY KEY,
    QuestionnaireBooleanDescription varchar(255) UNIQUE,
    QuestionnaireBooleanValue bit
);

-- Vehicle table (connected with User table, MainVehicleInfo, GarageVehicleInfo etc.)
CREATE TABLE Vehicle (
    VehicleId int IDENTITY(1,1) PRIMARY KEY,
    hasQuestionnaire bit NOT NULL,
    Comments varchar(500) NULL,
    UserId int FOREIGN KEY REFERENCES GarageUser(UserId),
	StatusId tinyint FOREIGN KEY REFERENCES VehicleStatus(StatusId),
	MainVehicleInfoId int UNIQUE FOREIGN KEY REFERENCES MainVehicleInfo(MainVehicleInfoId),
	GarageVehicleInfoId int UNIQUE FOREIGN KEY REFERENCES GarageVehicleInfo(GarageVehicleInfoId),
	VehicleManagerId int FOREIGN KEY REFERENCES VehicleManager(VehicleManagerId),
	InvoiceId int UNIQUE FOREIGN KEY REFERENCES Invoice(InvoiceId)
);

-- Vehicle_QuestionnaireBooleanAttribute table (connected with Vehicle and QuestionnaireBooleanAttribute tables| '0 or many'-to-one)
CREATE TABLE Vehicle_QuestionnaireBooleanAttribute (
    VehicleId int FOREIGN KEY REFERENCES Vehicle(VehicleId),
    QuestionnaireBooleanAttributeId int FOREIGN KEY REFERENCES QuestionnaireBooleanAttribute(QuestionnaireBooleanAttributeId),
    PRIMARY KEY (VehicleId, QuestionnaireBooleanAttributeId)
);