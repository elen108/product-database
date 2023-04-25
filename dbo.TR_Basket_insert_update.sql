CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Обновляем DiscountValue в зависимости от количества записей с одним ID_SKU
    UPDATE b
    SET DiscountValue = CASE
                            WHEN EXISTS (SELECT 1 FROM dbo.Basket WHERE ID_SKU = b.ID_SKU HAVING COUNT(*) >= 2)
                            THEN b.Value * 0.05
                            ELSE 0
                        END
    FROM dbo.Basket b
    INNER JOIN inserted i ON b.ID = i.ID;
END;