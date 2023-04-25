CREATE FUNCTION dbo.udf_GetSKUPrice
(
    @ID_SKU INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalValue MONEY;
    DECLARE @TotalQuantity INT;
    DECLARE @SKUPrice DECIMAL(18, 2);

    SELECT @TotalValue = SUM(Value), @TotalQuantity = SUM(Quantity)
    FROM dbo.Basket
    WHERE ID_SKU = @ID_SKU;

    IF @TotalQuantity > 0
        SET @SKUPrice = CAST(@TotalValue AS DECIMAL(18, 2)) / @TotalQuantity;
    ELSE
        SET @SKUPrice = 0;

    RETURN @SKUPrice;
END;