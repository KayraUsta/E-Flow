-- Süreç Numarasý ve DID Numarasýna Dikkat!
-- LegalMonetaryTotal
DECLARE
@V_XML XML,
@V_COUNT INT = 0,
@V_ROW_COUNT INT = 1,
@V_SUREC_NO INT = 1335
DECLARE
@V_TABLE TABLE(Line_Extension_Amount FLOAT, Tax_Exclusive_Amount FLOAT, Tax_Inclusive_Amount FLOAT, Allowance_Total_Amount FLOAT, Payable_Rounding_Amount FLOAT, Payable_Amount FLOAT)
BEGIN
SELECT @V_XML = REPLACE(VALUE,'-<','<') FROM INST_DATA_MEMO WHERE DID = 10906 AND CIID = @V_SUREC_NO
select
@V_COUNT = I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:LineCountNumeric[1]','INT')
from @V_XML.nodes('declare default element namespace "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"; /Invoice') as emp(I)
WHILE
@V_ROW_COUNT<@V_COUNT+1
BEGIN
INSERT INTO @V_TABLE(Line_Extension_Amount, Tax_Exclusive_Amount, Tax_Inclusive_Amount, Allowance_Total_Amount, Payable_Rounding_Amount, Payable_Amount)
select
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:LegalMonetaryTotal/cbc:LineExtensionAmount)[1]','FLOAT') AS [LineExtensionAmount],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount)[1]','FLOAT') AS [TaxExclusiveAmount],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount)[1]','FLOAT') AS [TaxInclusiveAmount],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount)[1]','FLOAT') AS [AllowanceTotalAmount],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:LegalMonetaryTotal/cbc:PayableRoundingAmount)[1]','FLOAT') AS [PayableRoundingAmount],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:LegalMonetaryTotal/cbc:PayableAmount)[1]','FLOAT') AS [PayableAmount]
from @V_XML.nodes('declare default element namespace "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"; /Invoice') as emp(I)
SET @V_ROW_COUNT = @V_ROW_COUNT+1
END
SELECT Line_Extension_Amount, Tax_Exclusive_Amount, Tax_Inclusive_Amount, Allowance_Total_Amount, Payable_Rounding_Amount, Payable_Amount FROM @V_TABLE
END