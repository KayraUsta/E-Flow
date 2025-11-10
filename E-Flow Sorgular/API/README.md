## 🧾 Fatura Veri Yapısı

Bu dokümanda, harici sistemlerden fatura verisi alışverişi için kullanılacak olan veri yapısı tanımlanmıştır. Veriler, **Fatura Başlık Bilgileri (Header)** ve **Fatura Satır Bilgileri (Satırlar)** olmak üzere iki ana tabloya ayrılmıştır.

### 1. Fatura Başlık Bilgileri (Header)

Bu bölüm, entegrasyon için gerekli olan **kimlik doğrulama** ve **genel fatura üst verilerini** içerir.

| Alan Adı | Açıklama | Tür/Amaç | Notlar |
| :--- | :--- | :--- | :--- |
| **Api Anahtarı** | Harici sistem tarafından sağlanan **benzersiz API erişim anahtarı**. | Kimlik Doğrulama | |
| **Çalışma Yılı** | İşlemin gerçekleştirileceği mali yıl. | Genel | |
| **Firma Kodu** | Faturanın ait olduğu sistemdeki **firma/şube kodu**. | Firma Tespiti | |
| **Kullanıcı Kodu** | İşlemi yapan **kullanıcının kodu**. | Yetkilendirme | |
| **MD5 ile Hashlanmış Şifre** | Kullanıcı şifresinin **MD5 algoritmasıyla şifrelenmiş hali**. | Kimlik Doğrulama | Güvenlik sebebiyle hashlenmiş olarak iletilmelidir. |

---

### 2. Fatura Satır Bilgileri (Satırlar)

Bu bölüm, muhasebe fişinin ve faturanın detaylarını oluşturacak olan **ürün/hizmet satır verilerini** içerir. (Bazı veriler firmanın özel talepleri veya muhasebe fişinin doğruluğu için zorunludur.)

| Alan Adı | Açıklama | Amaç/Kullanım | Notlar |
| :--- | :--- | :--- | :--- |
| **cha_evrakno_seri** | Evrakın **Seri** numarası. | Fatura Numarası | |
| **cha_belge_no** | Belgenin **Numarası**. | Fatura Numarası | |
| **cha_tarihi** | Fatura/Belge **Tarihi**. | Muhasebe Kaydı | |
| **cha_cinsi** | Kaydedilen **Kalemin Cinsi** (Ürün/Hizmet). | Kalem Tanımı | |
| **cha_tip** | Fatura **Tipi** (Örn: Satış, Alış). | İşlem Tipi | |
| **cha_evrak_tip** | Belgenin **Evrak Tipi**. | Belge Sınıflandırması | |
| **cha_kod** | Ürün/Hizmet **Kodu**. | Muhasebe Hesap Kodu | |
| **cha_miktari** | Ürün/Hizmet **Miktarı**. | Hesaplama | |
| **cha_aratoplam** | Satırın **Vergisiz Ara Toplam** tutarı. | Hesaplama | |
| **cha_aciklama** | Satır **Açıklaması**. | Detaylı Bilgi | |
| **cha_smrkkodu** | **Sorumluluk Merkezi Kodu**. | Maliyet Takibi (Firma İst.) | |
| **cha_d_cins** | **Döviz Cinsi** (Örn: USD, EUR). | Kur Bilgisi | |
| **cha_d_kur** | İşlem **Döviz Kuru**. | Değerleme | |
| **cha_vergipntr** | **Vergi Pointer/Oranı**. | Vergi Hesaplaması | |
| **cha_kasa_hizkod** | Kasa **Hizmet Kodu** (Varsa). | Kasa İşlemleri | |
| **cha_kasa_hizmet** | Kasa **Hizmet Açıklaması**. | Kasa İşlemleri | |
| **cha_vade** | Faturanın **Vade Tarihi**. | Ödeme Planı | |
| **cha_projekodu** | **Proje Kodu**. | Proje Takibi (Firma İst.) | |
| **cha_karsisrmkkodu** | **Karşı Sorumluluk Merkezi Kodu**. | Maliyet Takibi (Firma İst.) | |
