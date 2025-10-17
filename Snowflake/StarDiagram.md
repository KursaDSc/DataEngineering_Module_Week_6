erDiagram
    title: Sakila Ödeme Analizi Star Şeması

    %% Fact Table - Ölçülerin bulunduğu merkezi tablo
    FACT_PAYMENT {
        int PAYMENT_ID PK
        int CUSTOMER_ID FK "Müşteri Anahtarı"
        int RENTAL_ID FK "Kiralama Anahtarı"
        date PAYMENT_DATE FK "Tarih Anahtarı (DIM_DATE ile eşleşir)"
        int STAFF_ID "Personel Anahtarı (Bazı analizler için)"
        decimal AMOUNT "Ölçü: Ödeme Miktarı (Revenue)"
    }

    %% Dimension Tables - Boyutlar
    DIM_CUSTOMER {
        int CUSTOMER_ID PK
        int STORE_ID
        varchar FIRST_NAME
        varchar LAST_NAME
        varchar EMAIL
        boolean ACTIVE
    }

    DIM_RENTAL {
        int RENTAL_ID PK
        int INVENTORY_ID
        int CUSTOMER_ID "Tekrarlı Müşteri Anahtarı"
        date RENTAL_DATE
        date RETURN_DATE
        int STAFF_ID
    }

    DIM_DATE {
        date DATE PK "Anahtar Değer"
        int YEAR
        int MONTH
        int DAY
        varchar WEEKDAY
    }

    %% Relationships (İlişkiler)
    %% İlişki Tipi: Boyut (1) --< Fact (Çok)

    DIM_CUSTOMER ||--o{ FACT_PAYMENT : "1:Çok (customer_id)"
    DIM_RENTAL ||--o{ FACT_PAYMENT : "1:Çok (rental_id)"
    DIM_DATE ||--o{ FACT_PAYMENT : "1:Çok (payment_date)"