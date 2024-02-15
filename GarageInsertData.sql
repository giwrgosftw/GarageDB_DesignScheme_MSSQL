USE GarageDB;

-- Inserting data into UserRole
DECLARE @i INT = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO UserRole (RoleName)
    VALUES ('Role' + CAST(@i AS VARCHAR(10)));
    
    SET @i = @i + 1;
END;

-- Inserting data into Permission
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO Permission (PermissionName)
    VALUES ('Permission' + CAST(@i AS VARCHAR(10)));
    
    SET @i = @i + 1;
END;

-- Inserting data into GarageUser
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO GarageUser (Username, PasswordHash, Email, RoleId)
    VALUES ('User' + CAST(@i AS VARCHAR(10)), 0x, 'user' + CAST(@i AS VARCHAR(10)) + '@example.com', @i);
    
    SET @i = @i + 1;
END;

-- Inserting data into Role_Permission
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO Role_Permission (RoleId, PermissionId)
    VALUES (@i, @i);
    
    SET @i = @i + 1;
END;

-- Inserting data into VAT
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO VAT (VatDescription, VatPercentage)
    VALUES ('VATDesc' + CAST(@i AS VARCHAR(10)), 5.0);
    
    SET @i = @i + 1;
END;

-- Inserting data into Outfitter
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO Outfitter (OutfitterDescription)
    VALUES ('OutfitDesc' + CAST(@i AS VARCHAR(10)));
    
    SET @i = @i + 1;
END;

-- Inserting data into MainVehicleInfo
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO MainVehicleInfo (
        MainVehicleInfoId, OnwerFullName, SupplierVehicleDescription, SupplierVehicleCode, BrandName, ModelName, Mileage, ManufactureYear,
        FuelType, VehicleWeight, VehicleLength, VehicleWidth, VehicleHeight, DeliveryDate, EngineSize, EngineType, HorsePower, 
        isRecyclable, WarrantyAmount, WarrantyExpirationDate, VatId, OutfitterId)
    VALUES (
        @i, 'Owner' + CAST(@i AS VARCHAR(10)), 'SupplierDesc' + CAST(@i AS VARCHAR(10)), 'SupplierCode' + CAST(@i AS VARCHAR(10)), 
        'Brand' + CAST(@i AS VARCHAR(10)), 'Model' + CAST(@i AS VARCHAR(10)), 10000, 2022, 'FuelType' + CAST(@i AS VARCHAR(10)), 
        1500.0, 4.5, 1.8, 1.6, GETDATE(), 'EngineSize' + CAST(@i AS VARCHAR(10)), 'EngineType' + CAST(@i AS VARCHAR(10)), 
        200, 1, 100.0, GETDATE(), @i, @i);
    
    SET @i = @i + 1;
END;

-- Inserting data into GarageService
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO GarageService (ServiceId, ServiceName, ServiceDescription, ServicePrice, DurationInMinutes, RequiredEquipment)
    VALUES (@i, 'Service' + CAST(@i AS VARCHAR(10)), 'ServiceDesc' + CAST(@i AS VARCHAR(10)), 50.0, 60, 'Equipment' + CAST(@i AS VARCHAR(10)));
    
    SET @i = @i + 1;
END;

-- Inserting data into PartReplacement
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO PartReplacement (ReplacementId, PartName, PartDescription, ReplacementDate, PartPrice, PartSupplierName)
    VALUES (@i, 'Part' + CAST(@i AS VARCHAR(10)), 'PartDesc' + CAST(@i AS VARCHAR(10)), GETDATE(), 100.0, 'Supplier' + CAST(@i AS VARCHAR(10)));
    
    SET @i = @i + 1;
END;

-- Inserting data into GarageVehicleInfo
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO GarageVehicleInfo (GarageVehicleInfoId, GarageName, GarageAddress, GarageContact, ServiceId, ReplacementId)
    VALUES (@i, 'Garage' + CAST(@i AS VARCHAR(10)), 'Address' + CAST(@i AS VARCHAR(10)), 'Contact' + CAST(@i AS VARCHAR(10)), @i, @i);
    
    SET @i = @i + 1;
END;

-- Inserting data into VehicleManager
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO VehicleManager (VehicleDescription)
    VALUES ('VehicleDesc' + CAST(@i AS VARCHAR(10)));
    
    SET @i = @i + 1;
END;

-- Inserting data into Invoice
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO Invoice (
        InvoiceId, CustomerFullName, InvoiceDate, PaymentMethod, SupplierPrice, DiscountUnit, DiscountAmount, TurnoverDiscountUnit, 
        TurnoverDiscountAmount, ChargeUnit, ChargeAmount, GeneralTaxUnit, GeneralTaxAmount, RecyclingTaxUnit, RecyclingTaxAmount, 
        TotalCostUnit, TotalCostAmount)
    VALUES (
        @i, 'Customer' + CAST(@i AS VARCHAR(10)), GETDATE(), 'PaymentMethod' + CAST(@i AS VARCHAR(10)), 1000.0, 10.0, 'Amount' + CAST(@i AS VARCHAR(10)),
        'DiscountUnit' + CAST(@i AS VARCHAR(10)), 20.0, 'ChargeUnit' + CAST(@i AS VARCHAR(10)), 30.0, 'TaxUnit' + CAST(@i AS VARCHAR(10)), 
        40.0, 'RecyclingUnit' + CAST(@i AS VARCHAR(10)), 50.0, 'TotalUnit' + CAST(@i AS VARCHAR(10)), 2000.0);
    
    SET @i = @i + 1;
END;

-- Inserting data into VehicleStatus
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO VehicleStatus (StatusDescription, UpdatedDate)
    VALUES ('Status' + CAST(@i AS VARCHAR(10)), GETDATE());
    
    SET @i = @i + 1;
END;

-- Inserting data into QuestionnaireBooleanAttribute
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO QuestionnaireBooleanAttribute (QuestionnaireBooleanDescription, QuestionnaireBooleanValue)
    VALUES ('Question' + CAST(@i AS VARCHAR(10)), 0);
    
    SET @i = @i + 1;
END;

-- Inserting data into Vehicle
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO Vehicle (
        hasQuestionnaire, Comments, UserId, StatusId, MainVehicleInfoId, GarageVehicleInfoId, VehicleManagerId, InvoiceId)
    VALUES (
        1, 'Comment' + CAST(@i AS VARCHAR(10)), @i, @i, @i, @i, @i, @i);
    
    SET @i = @i + 1;
END;

-- Inserting data into Vehicle_QuestionnaireBooleanAttribute
SET @i = 1;
WHILE @i <= 10
BEGIN
    INSERT INTO Vehicle_QuestionnaireBooleanAttribute (VehicleId, QuestionnaireBooleanAttributeId)
    VALUES (@i, @i);
    
    SET @i = @i + 1;
END;
