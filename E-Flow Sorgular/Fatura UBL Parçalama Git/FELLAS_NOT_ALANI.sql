DECLARE 
    @V_XML XML,
    @V_CIID INT = 222;

-- XML'i al
SELECT @V_XML = VALUE
FROM INST_DATA_MEMO
WHERE DID = 10012 AND CIID = @V_CIID;

-- Güvenli: gerçekten Invoice var mı?
SELECT ExistInvoice = @V_XML.exist('declare default element namespace "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"; //Invoice');

;WITH XMLNAMESPACES(
    DEFAULT 'urn:oasis:names:specification:ubl:schema:xsd:Invoice-2',
    'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2' AS cbc,
    'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2' AS cac
)
SELECT
    I.value('cbc:ProfileID[1]','varchar(50)')                                   AS [FATURA_TUR],
    I.value('cbc:ID[1]','varchar(50)')                                           AS [FATURA_NO],
    I.value('cbc:UUID[1]','varchar(50)')                                         AS [UUID],
    CONVERT(nvarchar(10), I.value('cbc:IssueDate[1]','date'), 104)               AS [FATURA_TARIH],
    I.value('cbc:InvoiceTypeCode[1]','varchar(50)')                               AS [FATURA_TIP],
    I.value('cbc:Note[1]','varchar(250)')                                         AS [NOT_1],
    I.value('cbc:Note[2]','varchar(100)')                                         AS [NOT_2],
    I.value('cbc:Note[3]','varchar(50)')                                          AS [Rez_No],
    I.value('cbc:Note[4]','varchar(50)')                                          AS [Ref_No],
    I.value('cbc:Note[5]','varchar(50)')                                          AS [NOT_5],
    I.value('cbc:Note[6]','varchar(250)')                                         AS [NOT_6],
    I.value('cbc:DocumentCurrencyCode[1]','varchar(20)')                          AS [DokumanKurKodu],
    I.value('cbc:AccountingCost[1]','varchar(50)')                                AS [AccountingCost],
    I.value('(cac:AccountingSupplierParty/cac:Party/cac:PartyIdentification/cbc:ID[@schemeID="VKN"])[1]','varchar(70)') AS [VKN],
    I.value('(cac:AccountingSupplierParty/cac:Party/cac:PartyName/cbc:Name)[1]','nvarchar(70)')                         AS [FIRMA],
    I.value('(cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount)[1]','float')        AS [KDV_HARIC_TUTAR],
    I.value('(cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount)[1]','float')        AS [KDV_DAHIL_TUTAR],
    I.value('(cac:LegalMonetaryTotal/cbc:TaxInclusiveAmount)[1]','float')
      - I.value('(cac:LegalMonetaryTotal/cbc:TaxExclusiveAmount)[1]','float')    AS [KDV_TUTAR],
    I.value('(cac:TaxTotal/cac:TaxSubtotal/cbc:Percent)[1]','float')             AS [KDV_ORAN],
    I.value('(cac:DespatchDocumentReference/cbc:ID)[1]','nvarchar(20)')          AS [IRSALIYE_NO],
    I.value('(cac:DespatchDocumentReference/cbc:IssueDate)[1]','date')           AS [IRSALIYE_TARIHI]
FROM @V_XML.nodes('//Invoice') AS T(I);
