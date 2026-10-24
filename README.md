# hotel-reservation-sales-database
1. SİSTEM VE İHTİYAÇ ANALİZİ
 Projenin Tanımı ve Amacı : Bu projede amacım, konaklama hizmeti veren işletmeler (otel, pansiyon, tatil köyü vb.) ile bu hizmetlerden faydalanmak isteyen müşterileri ortak bir platformda buluşturan bir Veri Tabanı Yönetim Sistemi tasarlamaktır. Sistem, işletmelerin tesis ve oda bilgilerini yönetmesine olanak tanırken, müşterilerin kriterlerine uygun konaklama seçeneklerini bulup rezervasyon yapmalarını sağlamaktadır.
  
Sistemde Kimler Ne Yapacak? Sistemi tasarlarken üç temel kullanıcı tipi belirledim:
•	Müşteri: Sisteme üye olup otel arayan, beğendiği odayı belirli tarihler için rezerve eden kişi.
•	Otel Yöneticisi: Kendi otelini sisteme kaydeden, oda tiplerini (standart, süit vb.) belirleyen ve bu odaların fiyatlarını yöneten işletme sahibi.
•	Sistem Yöneticisi(Admin): Sistemi genel olarak kontrol eden, yeni otel kategorileri ekleyen yetkili.
Sistemin İşleyişi ve Fonksiyonel Gereksinimler Sistemin düzgün çalışabilmesi için belirlediğim temel gereklilikler şunlardır:
•	Üyelik İşlemleri: Hem işletme sahipleri hem de müşteriler sisteme üye olabilmeli.
•	Tesis Yönetimi: Otel yöneticisi; otel adı, adres, yıldız sayısı, tesis türü  ve genel tesis özellikleri  bilgilerini sisteme girebilmeli.
•	Oda ve Özellik Yönetimi: Her otelin farklı tipte odaları tanımlanabilmeli. Odaların manzarası, yatak kapasitesi ve metrekaresi gibi nitelikler tutulmalı.
•	Tarih Bazlı Fiyatlandırma ve Müsaitlik: Ödev tanımında belirtildiği üzere; odaların fiyatları sabit olmayıp tarih bazında değişebilmeli. Ayrıca odaların hangi tarihlerde dolu olduğu takip edilmeli.
•	Arama ve Listeleme: Müşteriler; şehir, giriş-çıkış tarihi ve kişi sayısına göre arama yapabilmeli ve listeleyebilmelidir.
•	Rezervasyon İşlemi: Müşteri seçtiği tarih aralığı için, eğer oda müsaitse rezervasyon veya satın alma işlemi gerçekleştirebilmelidir. Yapılan rezervasyon sonucunda ilgili odanın o tarihlerdeki durumu "dolu" olarak güncellenmelidir.
Varsayımlar ve Kısıtlar
•	Bir oda aynı tarih aralığında birden fazla müşteriye kiralanamaz.
• Geçmiş tarihli rezervasyon yapılamaz. 
