DECLARE
@V_XML XML,
@V_CIID INT = 1335
BEGIN
SELECT @V_XML = REPLACE(VALUE,'-<','<') FROM INST_DATA_MEMO WHERE DID = 10906 AND CIID = @V_CIID
select
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:ProfileID[1]','varchar(50)') as [FATURA_TUR (varchar(50))],
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:ID[1]','varchar(50)') as [FATURA_NO (varchar(50))],
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:UUID[1]','varchar(50)') as [UUID (varchar(50))],
CONVERT(NVARCHAR(10),I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:IssueDate[1]','DATE'),104) as [FATURA_TARIH (DATE)],
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:InvoiceTypeCode[1]','varchar(50)') AS [FATURA_TIP (varchar(50))],
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:Note[1]','varchar(250)') AS [NOT 1 (varchar(250))],
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:Note[2]','varchar(100)') AS [NOT 2 (varchar(100))],
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:Note[3]','varchar(50)') AS [Rez.No (varchar(50))],
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:Note[4]','varchar(50)') AS [Ref.No (varchar(50))],
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:Note[5]','varchar(50)') AS [NOT 5 (varchar(50))],
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:Note[6]','varchar(250)') AS [NOT 6 (varchar(250))],
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:DocumentCurrencyCode[1]','varchar(20)') AS [Doküman Kur Kodu (varchar(20))],
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:AccountingCost[1]','varchar(50)') AS [Accounting Cost (varchar(50))],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID)[@schemeID="VKN"][1]','varchar(70)') AS [VKN (varchar(70))],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name)[1]','Nvarchar(70)') AS [FIRMA (Nvarchar(50))],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount)[1]','FLOAT') AS [KDV_HARIC_TUTAR (FLOAT)],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount)[1]','FLOAT') AS [KDV_DAHIL_TUTAR (FLOAT)],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount)[1]','FLOAT')-I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount)[1]','FLOAT')
AS [KDV_TUTAR (FLOAT)],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:TaxTotal/cac:TaxSubtotal/cbc:Percent)[1]','FLOAT') AS [KDV_ORAN (FLOAT)],
I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:Note[1]','varchar(250)') AS [NOTE (varchar(250))],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:DespatchDocumentReference/cbc:ID)[1]','NVARCHAR(20)') AS [IRSALIYE_NO (NVARCHAR(20))],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:DespatchDocumentReference/cbc:IssueDate)[1]','DATE') AS [IRSALIYE_TARIHI (DATE)]
from @V_XML.nodes('declare default element namespace "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"; /Invoice') as emp(I)
END