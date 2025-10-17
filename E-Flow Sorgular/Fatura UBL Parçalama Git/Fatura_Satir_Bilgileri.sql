DECLARE
@V_XML XML,
@V_COUNT INT = 0,
@V_ROW_COUNT INT = 1,
@V_SUREC_NO INT = 1429
DECLARE
@V_TABLE TABLE(MALZEME_KODU NVARCHAR(100),MALZEME_ADI NVARCHAR(100),MIKTAR FLOAT,KDV_HARIC_TUTAR FLOAT,KDV_ORAN INT,KDV_TUTAR FLOAT,KDV_DAHIL_TUTAR FLOAT)
BEGIN
SELECT @V_XML = REPLACE(VALUE,'-<','<') FROM INST_DATA_MEMO WHERE DID = 11264 AND CIID = @V_SUREC_NO
select
@V_COUNT = I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:LineCountNumeric[1]','INT')
from @V_XML.nodes('declare default element namespace "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"; /Invoice') as emp(I)
WHILE
@V_ROW_COUNT<@V_COUNT+1
BEGIN
INSERT INTO @V_TABLE(MALZEME_KODU,MALZEME_ADI,MIKTAR,KDV_HARIC_TUTAR,KDV_ORAN,KDV_TUTAR)
select
CASE WHEN ISNULL(I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:InvoiceLine[cbc:ID=sql:variable("@V_ROW_COUNT")]/cac:Item/cbc:Description)[1]','varchar(70)'),'') = ''
THEN I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:InvoiceLine[cbc:ID=sql:variable("@V_ROW_COUNT")]/cac:Item/cbc:Name)[1]','varchar(70)')
ELSE I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:InvoiceLine[cbc:ID=sql:variable("@V_ROW_COUNT")]/cac:Item/cbc:Description)[1]','varchar(70)') END AS ModelName,
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:InvoiceLine[cbc:ID=sql:variable("@V_ROW_COUNT")]/cac:Item/cbc:Name)[1]','varchar(70)') AS [Name],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:InvoiceLine[cbc:ID=sql:variable("@V_ROW_COUNT")]/cbc:InvoicedQuantity)[1]','FLOAT') AS InvoicedQuantity,
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:InvoiceLine[cbc:ID=sql:variable("@V_ROW_COUNT")]/cac:Price/cbc:PriceAmount)[1]','FLOAT') AS PriceAmount,
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:InvoiceLine[cbc:ID=sql:variable("@V_ROW_COUNT")]/cac:TaxTotal/cac:TaxSubtotal/cbc:Percent)[1]','FLOAT') AS KDV_ORAN,
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:InvoiceLine[cbc:ID=sql:variable("@V_ROW_COUNT")]/cac:TaxTotal/cbc:TaxAmount)[1]','FLOAT') AS KDV_TUTAR
from @V_XML.nodes('declare default element namespace "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"; /Invoice') as emp(I)
SET @V_ROW_COUNT = @V_ROW_COUNT+1
END
SELECT MALZEME_KODU AS ACIKLAMA,MIKTAR,KDV_HARIC_TUTAR,KDV_ORAN,KDV_TUTAR,KDV_HARIC_TUTAR +KDV_TUTAR AS KDV_DAHIL_TUTAR FROM @V_TABLE
END