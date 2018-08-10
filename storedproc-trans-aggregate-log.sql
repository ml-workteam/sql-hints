CREATE PROCEDURE up_GenerateImpressions
AS
BEGIN TRAN
  INSERT INTO Impressions (Cnt, ImpressionDate, [ID], CategoryIDRef, Type)
  SELECT SUM(Cnt) AS Cnt, CONVERT(varchar(10),ImpressionDate,120) AS ImpressionDate, [ID], CategoryIDRef, Type
  FROM ImpressionsLog 
  GROUP BY CONVERT(varchar(10),ImpressionDate,120), Type, [ID], CategoryIDRef
  ORDER BY CONVERT(varchar(10),ImpressionDate,120), Type, [ID], CategoryIDRef

  DELETE FROM ImpressionsLog
COMMIT TRAN
GO