CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
    @FamilySurName VARCHAR(255)
AS
BEGIN 
    DECLARE @FamilyID INT
    
    -- Получаем ID семьи по переданному фамилии
    SELECT @FamilyID = ID
    FROM dbo.Family
    WHERE SurName = @FamilySurName

    -- Проверяем, существует ли семья с такой фамилией
    IF @FamilyID IS NULL
    BEGIN
        RAISERROR ('Семьи с фамилией "%s" не существует!', 16, 1, @FamilySurName)
        RETURN
    END

    -- Рассчитываем сумму покупок для семьи
    DECLARE @PurchaseTotal MONEY
    SELECT @PurchaseTotal = SUM(Value)
    FROM dbo.Basket
    WHERE ID_Family = @FamilyID

    -- Обновляем значение BudgetValue в таблице dbo.Family
    UPDATE dbo.Family
    SET BudgetValue = BudgetValue - @PurchaseTotal
    WHERE ID = @FamilyID
END

