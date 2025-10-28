-- Süreç Numarasý ve DID Numarasýna Dikkat!
-- AccountingSupplierParty
DECLARE
@V_XML XML,
@V_COUNT INT = 0,
@V_ROW_COUNT INT = 1,
@V_SUREC_NO INT = 1335
DECLARE
@V_TABLE TABLE(Website_URI varchar(50), VKN varchar(50), TICARET_SICIL_NO varchar(50), [Name] varchar(100), Postal_Address_ID varchar(50), Postal_Address_Room varchar(50), Postal_Address_Street_Name varchar(250), Postal_Address_Building_Name varchar(50), Postal_Address_Building_Number FLOAT, Postal_Address_City_Subdivision_Name varchar(50), Postal_Address_City_Name varchar(50), Postal_Address_Postal_Zone varchar(50), Postal_Address_Region varchar(50), Country_Name varchar(50), Tax_Scheme_Name varchar(50), Telephone varchar(50), Telefax varchar(50), Electronic_Mail  varchar(50))
BEGIN
SELECT @V_XML = REPLACE(VALUE,'-<','<') FROM INST_DATA_MEMO WHERE DID = 10906 AND CIID = @V_SUREC_NO
select
@V_COUNT = I.value('declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; cbc:LineCountNumeric[1]','INT')
from @V_XML.nodes('declare default element namespace "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"; /Invoice') as emp(I)
WHILE
@V_ROW_COUNT<@V_COUNT+1
BEGIN
INSERT INTO @V_TABLE(Website_URI, VKN, TICARET_SICIL_NO, [Name], Postal_Address_ID, Postal_Address_Room, Postal_Address_Street_Name, Postal_Address_Building_Name, Postal_Address_Building_Number, Postal_Address_City_Subdivision_Name, Postal_Address_City_Name, Postal_Address_Postal_Zone, Postal_Address_Region, Country_Name, Tax_Scheme_Name, Telephone, Telefax, Electronic_Mail)
select
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cbc:WebsiteURI)[1]','varchar(50)') AS [WebsiteURI],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PartyIdentification[1]/cbc:ID)[1]','varchar(50)') AS [VKN],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PartyIdentification[2]/cbc:ID)[1]','varchar(50)') AS [TICARETSICILNO],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PartyName[1]/cbc:Name)[1]','varchar(100)') AS [Name],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PostalAddress/cbc:ID)[1]','varchar(50)') AS [PostalAddressID],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PostalAddress/cbc:Room)[1]','varchar(50)') AS [PostalAddressRoom],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PostalAddress/cbc:StreetName)[1]','varchar(250)') AS [PostalAddressStreetName],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PostalAddress/cbc:BuildingName)[1]','varchar(50)') AS [PostalAddressBuildingName],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PostalAddress/cbc:BuildingNumber)[1]','FLOAT') AS [PostalAddressBuildingNumber],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PostalAddress/cbc:CitySubdivisionName)[1]','varchar(50)') AS [PostalAddressCitySubdivisionName],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PostalAddress/cbc:CityName)[1]','varchar(50)') AS [PostalAddressCityName],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PostalAddress/cbc:PostalZone)[1]','varchar(50)') AS [PostalAddressPostalZone],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PostalAddress/cbc:Region)[1]','varchar(50)') AS [PostalAddressRegion],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PostalAddress/cac:Country/cbc:Name)[1]','varchar(50)') AS [CountryName],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:PartyTaxScheme/cac:TaxScheme/cbc:Name)[1]','varchar(50)') AS [TaxSchemeName],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:Contact/cbc:Telephone)[1]','varchar(50)') AS [Telephone],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:Contact/cbc:Telefax)[1]','varchar(50)') AS [Telefax],
I.value('declare namespace cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2";declare namespace cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"; (cac:AccountingSupplierParty/cac:Party[1]/cac:Contact/cbc:ElectronicMail)[1]','varchar(50)') AS [ElectronicMail]
from @V_XML.nodes('declare default element namespace "urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"; /Invoice') as emp(I)
SET @V_ROW_COUNT = @V_ROW_COUNT+1
END
SELECT Website_URI, VKN, TICARET_SICIL_NO, [Name], Postal_Address_ID, Postal_Address_Room, Postal_Address_Street_Name, Postal_Address_Building_Name, Postal_Address_Building_Number, Postal_Address_City_Subdivision_Name, Postal_Address_City_Name, Postal_Address_Postal_Zone, Postal_Address_Region, Country_Name, Tax_Scheme_Name, Telephone, Telefax, Electronic_Mail FROM @V_TABLE
END