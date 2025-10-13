
DECLARE
@XML XML


SELECT @XML = VALUE FROM INST_DATA_MEMO WITH(NOLOCK) WHERE DID = 20126 AND CIID = 160


SELECT

X.Rec.query('./ColumnData[1]').value('(//@datatext)[1]', 'NVARCHAR(100)') AS TUR,
X.Rec.query('./ColumnData[2]').value('.', 'NVARCHAR(100)') AS MALZEMEKODU,
X.Rec.query('./ColumnData[2]').value('(//@datatext)[1]', 'NVARCHAR(100)') AS MALZEMEADI,
X.Rec.query('./ColumnData[3]').value('.', 'FLOAT') AS MIKTAR,
X.Rec.query('./ColumnData[2]').value('(//@datatext)[1]', 'NVARCHAR(100)') AS SUTUN_2_TEXT,
X.Rec.query('./ColumnData[3]').value('.', 'FLOAT') AS SUTUN_3_VALUE,
X.Rec.query('./ColumnData[4]').value('.', 'NVARCHAR(100)') AS SUTUN_4_VALUE,
X.Rec.query('./ColumnData[5]').value('.', 'DATE') AS SUTUN_5_VALUE,
X.Rec.query('./ColumnData[6]').value('.', 'BIT') AS SUTUN_6_VALUE,
X.Rec.query('./ColumnData[7]').value('.', 'NVARCHAR(100)') AS SUTUN_7_VALUE,
X.Rec.query('.').value('(//@row)[1]', 'INT') AS ROW_ID
FROM @XML.nodes('/LineItemTable/TableData/Data') as x(Rec)
WHERE X.Rec.query('.').value('(//@row)[1]', 'INT') = 1





-- DECLARE Kullanılmadan ÖRNEK
SELECT 
	CIID,
	X.Rec.query('./ColumnData[1]').value('.', 'FLOAT') AS [ID],
	X.Rec.query('./ColumnData[2]').value('.', 'NVARCHAR(MAX)') AS [Ünvan],
	X.Rec.query('./ColumnData[3]').value('.', 'NVARCHAR(MAX)') AS [Sonuç],
	X.Rec.query('./ColumnData[4]').value('.', 'NVARCHAR(MAX)') AS [RefId]
FROM (SELECT CONVERT(XML,VALUE) AS T22, CIID from INST_DATA_MEMO where CIID = 0 AND DID = 0) T2
CROSS APPLY T2.T22.nodes('/LineItemTable/TableData/Data') X(Rec)



-- Başka bir LineItemTableParçalama Örneği;
DECLARE
@XML XML


SELECT @XML = VALUE FROM INST_DATA_MEMO WITH(NOLOCK) WHERE DID = 20264 AND CIID = @CIID

SELECT
	X.Rec.query('./ColumnData[1]').value('.', 'NVARCHAR(250)') AS [CARI],
	[CARI_TANIMI] = (SELECT DEFINITION_ FROM TIGERPLUS.DBO.LG_116_CLCARD WHERE CODE = X.Rec.query('./ColumnData[1]').value('.', 'NVARCHAR(250)')),
	X.Rec.query('./ColumnData[2]').value('.', 'FLOAT') AS [VADE_GUNU],
	X.Rec.query('./ColumnData[3]').value('.', 'FLOAT') AS [YUZDE_ORANI],
	X.Rec.query('./ColumnData[4]').value('.', 'DATE') AS [VADE_TARIHI],
	X.Rec.query('./ColumnData[5]').value('.', 'NVARCHAR(500)') AS [ACIKLAMA],
	@CIID AS [CIID]
FROM @XML.nodes('/LineItemTable/TableData/Data') as x(Rec) 





-- CTE oluşturulurken WITH kelimesinden önce ; koyulmalıdır. Aksi halde hata mesajı döner.
/*
	Incorrect syntax near the keyword 'with'. If this statement is a common table expression, an xmlnamespaces clause or a change tracking context clause, the previous statement must be terminated with a semicolon.
*/

DECLARE @XML XML
SELECT @XML = VALUE FROM INST_DATA_MEMO WITH(NOLOCK) WHERE DID = 10034 AND CIID = 34
;WITH LIT_CTE AS 
(
	SELECT
	X.Rec.query('.').value('(//@row)[1]', 'INT') AS ROW_ID,
	X.Rec.query('./ColumnData[1]').value('.', 'FLOAT') AS [A SUTUNU],
	X.Rec.query('./ColumnData[2]').value('.', 'NVARCHAR(100)') AS [B SUTUNU],
	X.Rec.query('./ColumnData[3]').value('.', 'NVARCHAR(100)') AS [C SUTUNU - VALUE],
	X.Rec.query('./ColumnData[3]').value('(//@datatext)[1]', 'NVARCHAR(100)') AS [C SUTUNU - VALUE_TEXT],
	X.Rec.query('./ColumnData[4]').value('.', 'NVARCHAR(100)') AS [D SUTUNU - VALUE],
	X.Rec.query('./ColumnData[4]').value('(//@datatext)[1]', 'NVARCHAR(100)') AS [D SUTUNU - VALUE_TEXT],
	X.Rec.query('./ColumnData[5]').value('.', 'DATE') AS SUTUN_5_VALUE,
	X.Rec.query('./ColumnData[6]').value('.', 'BIT') AS SUTUN_6_VALUE,
	X.Rec.query('./ColumnData[7]').value('.', 'NVARCHAR(100)') AS [G SUTUNU],
	X.Rec.query('./ColumnData[8]').value('.', 'NVARCHAR(100)') AS [H SUTUNU],
	X.Rec.query('./ColumnData[9]').value('.', 'NVARCHAR(100)') AS [I SUTUNU]
	FROM @XML.nodes('/LineItemTable/TableData/Data') as x(Rec)
	--WHERE X.Rec.query('.').value('(//@row)[1]', 'INT') = 1
)
SELECT * FROM LIT_CTE





-- Döngü içinde örnek Kullanım: [Fatura Dagıtım Sureci.ntl]
-- Where şartında SAYAÇ kullanımı
-- Bu kullanımdaki sorgu;
/*
	DİKKAT:
		Burada 4. sütun 17-05-2023 şeklindeki tarih verisi var ancak Alphanumeric alandan alıyor. DATE veri DEĞİL.
		Ancak değer Date veri elementine atılıyor.
		Aşağıdaki şekilde SUBSTRING kullanılarak yapıldı.
*/
DECLARE
@XML XML

SELECT @XML = VALUE FROM INST_DATA_MEMO WITH(NOLOCK) WHERE DID = 10263 AND CIID = %surecno%

SELECT
X.Rec.query('./ColumnData[1]').value('.', 'NVARCHAR(200)') AS FIRMA_UNVAN,
X.Rec.query('./ColumnData[2]').value('.', 'NVARCHAR(100)') AS VKN,
X.Rec.query('./ColumnData[2]').value('.', 'NVARCHAR(100)') AS TCKN,
X.Rec.query('./ColumnData[3]').value('.', 'NVARCHAR(40)') AS FaturaNo,
SUBSTRING(X.Rec.query('./ColumnData[4]').value('.', 'NVARCHAR(100)'),7,4)+'-'+
SUBSTRING(X.Rec.query('./ColumnData[4]').value('.', 'NVARCHAR(100)'),4,2)+'-'+
SUBSTRING(X.Rec.query('./ColumnData[4]').value('.', 'NVARCHAR(100)'),1,2) AS TARIH,
X.Rec.query('./ColumnData[5]').value('.', 'FLOAT') AS TUTAR,
'TL' AS PARA_BIRIMI
FROM @XML.nodes('/LineItemTable/TableData/Data') as x(Rec)
WHERE X.Rec.query('.').value('(//@row)[1]', 'INT')=%sayac%+1






-- ESKİ SORGU
SELECT 

sum(DT.TUTAR)
FROM (
SELECT 
x.Rec.query('./ColumnData[1]').value('.', 'NVARCHAR(300)')'FiyatGID' ,
x.Rec.query('./ColumnData[10]').value('.', 'FLOAT')'Tutar'

FROM (select cast(VALUE as XML) as xdt FROM EFLOW.DBO.INST_DATA_MEMO WHERE DID=11033  AND CIID=%surecno%
) e
CROSS APPLY e.xdt.nodes('/LineItemTable/TableData/Data') as x(Rec)
)DT


-- ESKİ SORGU X(Rec) İLE KULLANIM
DECLARE
@XML XML


SELECT @XML = VALUE FROM INST_DATA_MEMO WITH(NOLOCK) WHERE DID = 11033 AND CIID = 11047


SELECT
SUM(X.Rec.query('./ColumnData[10]').value('.', 'FLOAT')) AS ARA_TOPLAM
FROM @XML.nodes('/LineItemTable/TableData/Data') as x(Rec)





-- Skalar FONKSİYONUN Kullanımı;
SELECT [dbo].[GET_ARA_TUTAR](11048) AS ARATUTAR


-- Skaler Fonksiyon Örneği
CREATE FUNCTION [dbo].[GET_ARA_TUTAR](@CIID INT)
RETURNS FLOAT
AS
BEGIN
	DECLARE
	@XML XML, @ARA_TUTAR FLOAT


	SELECT @XML = VALUE FROM INST_DATA_MEMO WITH(NOLOCK) WHERE DID = 11033 AND CIID = @CIID


	SELECT
	@ARA_TUTAR = SUM(X.Rec.query('./ColumnData[10]').value('.', 'FLOAT'))
	FROM @XML.nodes('/LineItemTable/TableData/Data') as x(Rec)


	RETURN @ARA_TUTAR

END



-- Tablo Tipi Fonksiyon Örneği
CREATE FUNCTION [dbo].[FC_GET_SUPPLIER_QUOTE_EVALUATION](@CIID INT) 
RETURNS @TABLE TABLE(	PROCESS_ID INT,
						TEDARIKCI NVARCHAR(250),
						FINAL_PRICE FLOAT,
						QUOTATION_DATE_AND_REF NVARCHAR(250)
					)
AS
BEGIN

	DECLARE
	@XML XML
	
	SELECT @XML = VALUE FROM INST_DATA_MEMO WITH(NOLOCK) WHERE DID = 20368 AND CIID = @CIID

	INSERT INTO @TABLE
	SELECT
			@CIID AS [PROCESS_ID],
			X.Rec.query('./ColumnData[1]').value('.', 'NVARCHAR(250)') AS [TEDARIKCI],
			CAST(X.Rec.query('./ColumnData[2]').value('.', 'FLOAT') AS DECIMAL(10, 2)) AS [FINAL_PRICE],
			CONVERT(NVARCHAR(25), X.Rec.query('./ColumnData[3]').value('.', 'DATE'), 104) + ' / ' + X.Rec.query('./ColumnData[4]').value('.', 'NVARCHAR(100)') AS [QUOTATION_DATE_AND_REF]
	FROM @XML.nodes('/LineItemTable/TableData/Data') as x(Rec)

	RETURN
END




-- LineItemTable parçalayıp değer döndüren Stored Procedure
CREATE PROCEDURE [dbo].[sp_EF_OFFER](@ProcessId INT)
AS
BEGIN

DECLARE
@XML XML

SELECT @XML = VALUE FROM INST_DATA_MEMO WITH(NOLOCK) WHERE DID = 20126 AND CIID = @ProcessId

INSERT INTO EF_OFFER(PROCESS_ID ,
			LOGO_FIRMNR ,
			TYPEID ,
			MATERIAL_CODE ,
			QUANTITY ,
			UNIT_CODE ,
			REQUEST_DATE ,
			CENTER_CODE ,
			CERIFICATE_REQUEST,
			ROW_ID,
			CERTIFICATE_TYPE_ID)
SELECT
	@ProcessId,
	(SELECT VALUE FROM INST_DATA_STRING WITH(NOLOCK) WHERE DID = 20123 AND CIID = @ProcessId) AS LogoCompanyId,
	X.Rec.query('./ColumnData[1]').value('.', 'TINYINT') AS TYPEID,
	X.Rec.query('./ColumnData[2]').value('.', 'NVARCHAR(30)') AS MATERIAL_CODE,
	X.Rec.query('./ColumnData[3]').value('.', 'FLOAT') AS QUANTITY,
	X.Rec.query('./ColumnData[4]').value('.', 'NVARCHAR(20)') AS UNIT_CODE,
	X.Rec.query('./ColumnData[6]').value('.', 'DATE') AS REQUEST_DATE,
	X.Rec.query('./ColumnData[7]').value('.', 'NVARCHAR(30)') AS CENTER_CODE,
	X.Rec.query('./ColumnData[8]').value('.', 'BIT') AS CERTIFICATE_REQUEST,
	X.Rec.query('.').value('(//@row)[1]', 'INT') AS ROW_ID,
	X.Rec.query('./ColumnData[9]').value('.', 'NVARCHAR(100)')
FROM @XML.nodes('/LineItemTable/TableData/Data') as x(Rec)

END





-- UPDATE İŞLEMİNE ÖRNEK
DECLARE @V_XML XML, @CIID INT

SET @CIID = 6873006   
SELECT @V_XML = VALUE FROM EFLOW.DBO.INST_DATA_MEMO WHERE DID =17083 AND CIID =@CIID

UPDATE KY_BT_GENEL..KAMPANYA_YONETIM
SET MEVCUT_FIYAT = LIT_DATA.MEVCUT_FIYAT,
	KAMPANYALI_FIYAT = LIT_DATA.KAMPANYALI_FIYAT,
	KY_INDIRIM_BEDELI = LIT_DATA.KOFTECI_YUSUF_INDIRIM,
	PLATFORM_INDIRIM_BEDELI = LIT_DATA.PLATFORM_INDIRIM,
	SATIS_MIKTARI = LIT_DATA.KAMPANYA_SATIS_MIKTARI,
	DESTEK_BEDELI = LIT_DATA.KAMPANYA_DESTEK_BEDELI
FROM (
    SELECT 
		@CIID AS [SUREC_NO],
		x.Rec.query('./ColumnData[1]').value('.', 'DATETIME') AS 'KAMPANYA_BASLANGIC_TARIHI',
		x.Rec.query('./ColumnData[2]').value('.', 'DATETIME') AS 'KAMPANYA_BITIS_TARIHI',
		x.Rec.query('./ColumnData[3]').value('.', 'nvarchar(250)') AS 'GECERLI_OLDUGU_PLATFORM',
		x.Rec.query('./ColumnData[4]').value('.', 'nvarchar(250)') AS 'GECERLI_OLDUGU_SUBE',
		x.Rec.query('./ColumnData[5]').value('.', 'nvarchar(250)') AS 'KAMPANY_ADI',
		x.Rec.query('./ColumnData[6]').value('.', 'FLOAT') AS 'MEVCUT_FIYAT',
		x.Rec.query('./ColumnData[7]').value('.', 'FLOAT') AS 'KAMPANYALI_FIYAT',
		x.Rec.query('./ColumnData[8]').value('.', 'FLOAT') AS 'KOFTECI_YUSUF_INDIRIM',
		x.Rec.query('./ColumnData[9]').value('.', 'FLOAT') AS 'PLATFORM_INDIRIM',
		x.Rec.query('./ColumnData[10]').value('.', 'FLOAT') AS 'KAMPANYA_SATIS_MIKTARI',
		x.Rec.query('./ColumnData[11]').value('.', 'FLOAT') AS 'KAMPANYA_DESTEK_BEDELI',
		x.Rec.query('./ColumnData[13]').value('.', 'nvarchar(250)') AS 'ACIKLAMA'
	FROM @V_XML.nodes('/LineItemTable/TableData/Data') as x(Rec)
	) AS LIT_DATA
WHERE LIT_DATA.SUREC_NO = KY_BT_GENEL..KAMPANYA_YONETIM.CIID




-- CROSS APPLY Örneği
SELECT 
    COURSE.CIID AS SUREC_NO,
    TALEP_NO.VALUE AS TALEP_NO,
    FIRMALAR.VALUE AS FIRMA_NO,
    FIRMALAR.VALUE_TEXT AS FIRMA_ADI,
    PROJELER.VALUE AS PROJE_NO,
    PROJELER.VALUE_TEXT AS PROJE_ADI,
	TALEP_BASLIGI.VALUE AS TALEP_BASLIGI,
	--SATINALMA_PERSONELI.VALUE,
	SATINALMACI.FIRSTNAME + ' ' + SATINALMACI.LASTNAME AS SATINALMA_PERSONELI,
    VADE.CARI,
    VADE.CARI_TANIMI,
    VADE.VADE_GUNU,
    VADE.YUZDE_ORANI,
    VADE.VADE_TARIHI,
    VADE.ACIKLAMA
FROM INST_COURSE COURSE WITH (NOLOCK)
LEFT JOIN INST_DATA_STRING TALEP_NO WITH (NOLOCK)
    ON TALEP_NO.CIID = COURSE.CIID AND TALEP_NO.DID = 20122
LEFT JOIN INST_DATA_STRING FIRMALAR WITH (NOLOCK)
    ON FIRMALAR.CIID = COURSE.CIID AND FIRMALAR.DID = 20123
LEFT JOIN INST_DATA_STRING PROJELER WITH (NOLOCK)
    ON PROJELER.CIID = COURSE.CIID AND PROJELER.DID = 20124
LEFT JOIN INST_DATA_NUMERIC SATINALMA_PERSONELI WITH (NOLOCK)
    ON SATINALMA_PERSONELI.CIID = COURSE.CIID AND SATINALMA_PERSONELI.DID = 20194
LEFT JOIN SEC_USERS SATINALMACI WITH (NOLOCK) ON SATINALMACI.USERID = SATINALMA_PERSONELI.VALUE
LEFT JOIN INST_DATA_STRING TALEP_BASLIGI WITH (NOLOCK)
    ON TALEP_BASLIGI.CIID = COURSE.CIID AND TALEP_BASLIGI.DID = 20125
CROSS APPLY [eflow].[dbo].FC_GET_VADE_TABLOSU(COURSE.CIID) VADE
WHERE COURSE.CID = 413










-- DBGüncelle ile Stored Proceure ile Harici bir tabloya yazma işlemi yapılabilir. Dublicate kayıt oluşmaması için önce DELETE işlemi yapılabilir.
DELETE FROM SATINALMA_VADELER WHERE PROCESS_ID = %processid%
EXEC sp_ADD_SATINALMA_VADELER %processid%


-- Yukarıdaki stored procedure için örnek (Öncesinde tablo oluşturulur);
CREATE PROCEDURE [dbo].[sp_ADD_SATINALMA_VADELER](@PROCESS_ID INT)
AS
BEGIN

DECLARE @XML XML
SELECT @XML = VALUE FROM INST_DATA_MEMO WITH(NOLOCK) WHERE DID = 20264 AND CIID = @CIID

INSERT INTO SATINALMA_VADELER(PROCESS_ID, CARI, CARI_TANIMI, VADE_GUNU, YUZDE_ORANI, VADE_TARIHI, ACIKLAMA)
SELECT
			@CIID AS [CIID],
            X.Rec.query('./ColumnData[1]').value('.', 'NVARCHAR(250)') AS [CARI],
            [CARI_TANIMI] = (
                SELECT DEFINITION_
                FROM TIGERPLUS.DBO.LG_116_CLCARD WITH (NOLOCK)
                WHERE CODE = X.Rec.query('./ColumnData[1]').value('.', 'NVARCHAR(500)')
            ),
            X.Rec.query('./ColumnData[2]').value('.', 'FLOAT') AS [VADE_GUNU],
            X.Rec.query('./ColumnData[3]').value('.', 'FLOAT') AS [YUZDE_ORANI],
            X.Rec.query('./ColumnData[4]').value('.', 'DATETIME') AS [VADE_TARIHI],
            X.Rec.query('./ColumnData[5]').value('.', 'NVARCHAR(500)') AS [ACIKLAMA]
FROM @XML.nodes('/LineItemTable/TableData/Data') AS X(Rec);

END







-- Farklı CIID'lere ait süreçlerde aynı tabloların birleştirilerek bir tablo halinde listelenmesi
-- Örneğin 413 nolu CID'ye ait tüm süreçlerdeki Vadeler tablolarının parçalanarak tek bir tablo halinde listelenmesi vb. işlemlerde kullanılacak örnek sorgu
DECLARE @CID INT = 413;
DECLARE @XML XML;
DECLARE @CIID INT;

DECLARE @Results TABLE (
    CARI NVARCHAR(250),
    CARI_TANIMI NVARCHAR(500),
    VADE_GUNU FLOAT,
    YUZDE_ORANI FLOAT,
    VADE_TARIHI DATETIME,
    ACIKLAMA NVARCHAR(500),
    CIID INT
);


DECLARE CIID_CURSOR CURSOR FOR
    SELECT COURSE.CIID
    FROM INST_COURSE COURSE WITH (NOLOCK)
	--INNER JOIN INST_DATA_STRING AS Status_ WITH (NOLOCK) ON Status_.CIID = COURSE.CIID AND Status_.DID = 20116
    WHERE COURSE.CID = @CID-- AND COURSE.COMPLETED IS NOT NULL AND Status_.VALUE = 'Logoya aktarım tamamlandı.';


OPEN CIID_CURSOR;

FETCH NEXT FROM CIID_CURSOR INTO @CIID;


WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @XML = VALUE FROM INST_DATA_MEMO WITH (NOLOCK) WHERE DID = 20264 AND CIID = @CIID;

    IF @XML IS NOT NULL
    BEGIN
        INSERT INTO @Results
        SELECT
            X.Rec.query('./ColumnData[1]').value('.', 'NVARCHAR(250)') AS [CARI],
            [CARI_TANIMI] = (
                SELECT DEFINITION_
                FROM TIGERPLUS.DBO.LG_116_CLCARD WITH (NOLOCK)
                WHERE CODE = X.Rec.query('./ColumnData[1]').value('.', 'NVARCHAR(250)')
            ),
            X.Rec.query('./ColumnData[2]').value('.', 'FLOAT') AS [VADE_GUNU],
            X.Rec.query('./ColumnData[3]').value('.', 'FLOAT') AS [YUZDE_ORANI],
            X.Rec.query('./ColumnData[4]').value('.', 'DATETIME') AS [VADE_TARIHI],
            X.Rec.query('./ColumnData[5]').value('.', 'NVARCHAR(500)') AS [ACIKLAMA],
            @CIID AS [CIID]
        FROM @XML.nodes('/LineItemTable/TableData/Data') AS X(Rec);
    END;

    FETCH NEXT FROM CIID_CURSOR INTO @CIID;
END;

CLOSE CIID_CURSOR;
DEALLOCATE CIID_CURSOR;