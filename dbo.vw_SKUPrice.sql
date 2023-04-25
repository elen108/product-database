CREATE VIEW dbo.vw_SKUPrice
AS
SELECT
    SKU.*,
    dbo.udf_GetSKUPrice(SKU.ID) AS SKUPrice
FROM dbo.SKU AS SKU;