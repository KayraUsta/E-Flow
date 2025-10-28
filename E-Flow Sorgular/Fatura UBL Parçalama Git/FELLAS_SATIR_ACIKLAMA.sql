-- InvoiceLine (set-based, döngüsüz)
DECLARE
    @V_XML XML,
    @V_SUREC_NO INT = 222;

DECLARE
    @V_TABLE TABLE
    (
        MALZEME_KODU        NVARCHAR(100),
        MALZEME_ADI         NVARCHAR(100),
        MIKTAR              FLOAT,
        KDV_HARIC_TUTAR     FLOAT,
        KDV_ORAN            INT,
        KDV_TUTAR           FLOAT,
        KDV_DAHIL_TUTAR     FLOAT
    );

-- XML'i al
SELECT @V_XML = VALUE
FROM INST_DATA_MEMO
WHERE DID = 10012 AND CIID = @V_SUREC_NO;

;WITH XMLNAMESPACES (
    DEFAULT 'urn:oasis:names:specification:ubl:schema:xsd:Invoice-2',
    'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2' AS cac,
    'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2'    AS cbc
)
INSERT INTO @V_TABLE (MALZEME_KODU, MALZEME_ADI, MIKTAR, KDV_HARIC_TUTAR, KDV_ORAN, KDV_TUTAR, KDV_DAHIL_TUTAR)
SELECT
    -- MALZEME_KODU
    L.value('(cac:Item/cac:SellersItemIdentification/cbc:ID)[1]', 'nvarchar(100)'),

    -- MALZEME_ADI: Description varsa onu, yoksa Name
    COALESCE(
        NULLIF(L.value('(cac:Item/cbc:Description)[1]', 'nvarchar(100)'),''),
        L.value('(cac:Item/cbc:Name)[1]', 'nvarchar(100)')
    ) AS MALZEME_ADI,

    -- MIKTAR
    TRY_CONVERT(float, L.value('(cbc:InvoicedQuantity)[1]', 'varchar(50)')),

    -- KDV_HARIC_TUTAR (satır net tutar)
    TRY_CONVERT(float, L.value('(cbc:LineExtensionAmount)[1]', 'varchar(50)')) AS KDV_HARIC_TUTAR,

    -- KDV_ORAN (yuvarlanmış INT isterseniz)
    TRY_CONVERT(int,
        ROUND(TRY_CONVERT(float, L.value('(cac:TaxTotal/cac:TaxSubtotal/cbc:Percent)[1]', 'varchar(50)')), 0)
    ) AS KDV_ORAN,

    -- KDV_TUTAR
    TRY_CONVERT(float, L.value('(cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount)[1]', 'varchar(50)')) AS KDV_TUTAR,

    -- KDV_DAHIL_TUTAR = Net + KDV
    TRY_CONVERT(float, L.value('(cbc:LineExtensionAmount)[1]', 'varchar(50)'))
      + TRY_CONVERT(float, L.value('(cac:TaxTotal/cac:TaxSubtotal/cbc:TaxAmount)[1]', 'varchar(50)')) AS KDV_DAHIL_TUTAR
FROM @V_XML.nodes('//Invoice') AS I(X)
CROSS APPLY I.X.nodes('cac:InvoiceLine') AS T(L);

-- Sonuç
SELECT
    MALZEME_KODU  AS ACIKLAMA,
	MALZEME_ADI,-- İsterseniz burada ACIKLAMA yerine ADI'yı gösterin
    MIKTAR,
    KDV_HARIC_TUTAR,
    KDV_ORAN,
    KDV_TUTAR,
    KDV_DAHIL_TUTAR
FROM @V_TABLE;
