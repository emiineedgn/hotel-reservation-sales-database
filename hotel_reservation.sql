CREATE DATABASE OtelRezervasyonDB;
GO
USE OtelRezervasyonDB;
GO

 CREATE TABLE Kullanicilar (
    KullaniciID INT PRIMARY KEY IDENTITY(1,1),
    Ad NVARCHAR(50) NOT NULL,
    Soyad NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Sifre NVARCHAR(255) NOT NULL,
    Telefon NVARCHAR(15),
    Rol NVARCHAR(20) NOT NULL CHECK (Rol IN ('musteri', 'otel_yoneticisi', 'admin')),
    KayitTarihi DATETIME DEFAULT GETDATE()
);

CREATE TABLE Oteller (
    OtelID INT  PRIMARY KEY IDENTITY( 1,1 ),
    KullaniciID INT  NOT NULL,
    OtelAdi NVARCHAR(100) NOT NULL,
    TesisTipi NVARCHAR(50) NOT NULL, 
    Sehir NVARCHAR(50) NOT NULL,
    Adres NVARCHAR(MAX),
    YildizSayisi INT CHECK (YildizSayisi BETWEEN 0 AND 7),
    Aciklama NVARCHAR(MAX),
    FOREIGN KEY (KullaniciID) REFERENCES Kullanicilar(KullaniciID) ON DELETE CASCADE
);

CREATE TABLE Odalar (
    OdaID INT PRIMARY KEY IDENTITY( 1 ,1),
    OtelID INT NOT NULL,
    OdaAdi NVARCHAR(50) NOT NULL,
    YatakKapasitesi INT NOT NULL,
    BoyutM2 INT,
    Manzara NVARCHAR(50),
    FOREIGN KEY (OtelID) REFERENCES Oteller(OtelID) ON DELETE CASCADE
);

CREATE TABLE Oda_Fiyatlari (
    FiyatID INT PRIMARY KEY IDENTITY(1,1),
    OdaID INT NOT NULL,
    BaslangicTarihi DATE NOT NULL,
    BitisTarihi DATE NOT NULL,
    GecelikFiyat MONEY NOT NULL,
  CONSTRAINT CHK_FiyatTarih CHECK (BitisTarihi  >=  BaslangicTarihi) 
);

CREATE TABLE Rezervasyonlar (
    RezervasyonID INT PRIMARY KEY IDENTITY(1,1),
    KullaniciID INT NOT NULL,
    OdaID INT NOT NULL,
    GirisTarihi DATE NOT NULL,
    CikisTarihi DATE NOT NULL,
    ToplamTutar MONEY NOT NULL,
    Durum NVARCHAR(20) DEFAULT 'Onay Bekliyor' CHECK (Durum IN ('Onay Bekliyor', 'Onaylandi', 'Iptal Edildi')),
    IslemTarihi DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (KullaniciID) REFERENCES Kullanicilar(KullaniciID),
    FOREIGN KEY (OdaID) REFERENCES Odalar(OdaID),
    CONSTRAINT CHK_RezervasyonTarih CHECK (CikisTarihi > GirisTarihi)
);

--VERİ GİRİŞLERİ--

INSERT INTO Kullanicilar (Ad, Soyad, Email, Sifre, Telefon, Rol) VALUES
(N'Ahmet', N'Yılmaz', 'admin@sistem.com', '12345', '5551112233', 'admin'),
(N'Mehmet', N'Demir', 'mehmet@otelci.com', '12345', '5554445566', 'otel_yoneticisi'),
(N'Ayşe', N'Kara', 'ayse@musteri.com', '12345', '5557778899', 'musteri'),
(N'Fatma', N'Çelik', 'fatma@musteri.com', '12345', '5550001122', 'musteri');

INSERT INTO Oteller (KullaniciID, OtelAdi, TesisTipi, Sehir, Adres, YildizSayisi, Aciklama) VALUES
(2, N'Mavi Deniz Otel', N'Otel', N'Antalya', N'Kaş Merkez Mah. No: 5', 4, N'Denize sıfır, havuzlu lüks otel.'),
(2, N'Yeşil Doğa Pansiyon', N'Pansiyon', N'Rize', N'Çamlıhemşin Yolu üzeri', 0, N'Doğayla iç içe ahşap bungalovlar.'),
(2, N'Güneş Tatil Köyü', N'Tatil Köyü', N'Bodrum', N'Yalıkavak Mevkii', 5, N'Özel plajlı, her şey dahil tatil köyü.');
INSERT INTO Odalar (OtelID, OdaAdi, YatakKapasitesi, BoyutM2, Manzara) VALUES
(1, N'Standart Oda', 2, 25, N'Dağ Manzaralı'),       
(1, N'Suit Oda', 3, 45, N'Deniz Manzaralı'),          
(1, N'Kral Dairesi', 4, 80, N'Full Deniz Manzaralı'), 
(2, N'Bungalov Ev', 2, 30, N'Dere Manzaralı'),        
(3, N'Aile Villası', 5, 120, N'Bahçe ve Havuz Manzaralı'); 

INSERT INTO Oda_Fiyatlari (OdaID, BaslangicTarihi, BitisTarihi, GecelikFiyat) VALUES
(1, '2025-06-01', '2025-08-31', 2500.00),
(1, '2025-09-01', '2025-12-31', 1500.00),
(2, '2025-01-01', '2025-12-31', 5000.00),
(5, '2025-05-01', '2025-10-01', 8500.00); 

INSERT INTO Rezervasyonlar (KullaniciID, OdaID, GirisTarihi, CikisTarihi, ToplamTutar, Durum) VALUES
(3, 1, '2025-07-10', '2025-07-15', 12500.00, N'Onaylandi'),
(4, 4, '2025-08-01', '2025-08-03', 4000.00, N'Onay Bekliyor'),
(3, 5, '2025-09-10', '2025-09-15', 42500.00, N'Onaylandi'); 

--SORGULAR-- 

PRINT '--- 1. SORGU SONUCU: JOIN (Müşteri - Otel - Tarih Detayı) ---' ;
SELECT K.Ad + ' ' + K.Soyad AS Musteri, O.OtelAdi, O.TesisTipi, Od.OdaAdi, R.GirisTarihi, R.CikisTarihi
FROM Rezervasyonlar R
INNER JOIN Kullanicilar K ON R.KullaniciID = K.KullaniciID
INNER JOIN Odalar Od ON R.OdaID = Od.OdaID
INNER JOIN Oteller O ON Od.OtelID = O.OtelID; 



PRINT '--- 2. SORGU SONUCU: ---';
SELECT Sehir, COUNT(OtelID) AS OtelSayisi
FROM Oteller
GROUP BY Sehir;

PRINT '--- 3. SORGU SONUCU: ---';
SELECT * FROM Rezervasyonlar 
WHERE ToplamTutar > (SELECT AVG(ToplamTutar) FROM Rezervasyonlar);

PRINT '--- 4. SORGU SONUCU:  ---';
SELECT R.RezervasyonID, K.Ad, O.OtelAdi, R.GirisTarihi, R.Durum 
FROM Rezervasyonlar R
JOIN Kullanicilar K ON R.KullaniciID = K.KullaniciID
JOIN Odalar Od ON R.OdaID = Od.OdaID
JOIN Oteller O ON Od.OtelID = O.OtelID
WHERE R.GirisTarihi > GETDATE();

PRINT '--- 5. SORGU SONUCU:  ---';
SELECT O.OtelAdi, O.TesisTipi, SUM(R.ToplamTutar) AS ToplamKazanc
FROM Oteller O
JOIN Odalar Od ON O.OtelID = Od.OtelID
JOIN Rezervasyonlar R ON Od.OdaID = R.OdaID
GROUP BY O.OtelAdi, O.TesisTipi
ORDER BY ToplamKazanc DESC;
