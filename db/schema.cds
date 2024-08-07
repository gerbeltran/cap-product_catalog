namespace product_catalog;

using {
    cuid,
    managed,
} from '@sap/cds/common';

type address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
};

type Dec : Decimal(16, 2);

context materials {

    entity Products : cuid {
        //key ID               : UUID;
        Name             : localized String not null;
        Description      : localized String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime;
        Price            : Dec;
        Height           : type of Price;
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        Supplier         : Association to sales.Suppliers;
        UnitOfMeasures   : Association to UnitOfMeasures;
        Currency         : Association to Currencies;
        DimensionsUnit   : Association to DimensionsUnits;
        Category         : Association to Categories;
        SalesData        : Association to many sales.SalesData
                               on SalesData.Product = $self;
        Review           : Association to many ProductReview
                               on Review.Product = $self;

    };

    entity ProductReview : cuid, managed {
        //   key Id      : String(2);
        Name    : String;
        Rating  : Integer;
        Comment : String;
        Product : Association to Products;
    };

    entity Categories {
        key ID   : String(1);
            Name : localized String;
    };


    entity StockAvailability {
        key ID          : Integer;
            Description : localized String;
            Product     : Association to Products;
    };

    entity Currencies {
        key ID          : String(3);
            Description : localized String;
    };

    entity UnitOfMeasures {
        key ID          : String(2);
            Description : localized String;
    };

    entity DimensionsUnits {
        key ID          : String(2);
            Description : localized String;
    };

    entity SelProducts   as select from Products;

    entity SelProducts1  as
        select from Products {
            *
        };

    entity SelProducts2  as
        select from Products {
            Name,
            Price,
            Quantity,
        };

    entity SelProducts3  as
        select from Products
        left join ProductReview
            on Products.Name = ProductReview.Name
        {
            Rating,
            Products.Name,
            sum(Price) as TotalPrice,
        }
        group by
            Rating,
            Products.Name
        order by
            Rating;

    entity ProjProducts  as projection on Products;

    entity ProjProducts2 as
        projection on Products {
            *
        };

    entity ProjProducts3 as
        projection on Products {
            ReleaseDate,
            Name,
        };

    extend Products with {
        PriceCondition      : String(2);
        PriceDeterminaation : String(3);
    }

}

context sales {


    entity SalesData : cuid, managed {
        //    key ID            : UUID;
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to materials.Products;
        Currency      : Association to materials.Currencies;
        DeliveryMonth : Association to Months;
    };


    entity Orders : cuid {
        Date     : Date;
        Customer : String;
        Item     : Composition of many OrderItems
                       on Item.Order = $self;
    }

    entity OrderItems : cuid {

        Order    : Association to Orders;
        Product  : Association to materials.Products;
        Quantity : Integer;

    }

    entity Suppliers : cuid, managed {
        // key ID         : UUID;
        Name    : materials.Products:Name;
        // Street     : String;
        // City       : String;
        // State      : String(2);
        // PostalCode : String(5);
        // Country    : String(3);
        Address : address;
        Email   : String;
        Phone   : String;
        Fax     : String;
        Product : Association to many materials.Products
                      on Product.Supplier = $self;
    };

    entity Months {
        key ID               : String(2);
            Description      : localized String;
            ShortDescription : localized String(3);
    };

}

context reports {
    entity AverageRating as
        select from product_catalog.materials.ProductReview {
            Product.ID  as ProductId,
            avg(Rating) as AverageRating : Decimal(16, 2)
        }
        group by
            Product.ID;

    entity Products      as
        select from product_catalog.materials.Products
        mixin {
            ToStockAvailiability : Association to product_catalog.materials.StockAvailability
                                       on ToStockAvailiability.ID = $projection.StockAvailability;
            ToAverageRating      : Association to AverageRating
                                       on ToAverageRating.ProductId = ID;
        }

        into {

            *,
            ToAverageRating.AverageRating as Rating,
            case
                when
                    Quantity >= 8
                then
                    3
                when
                    Quantity < 8
                then
                    2
                else
                    1
            end                           as StockAvailability : Integer,

            ToStockAvailiability

        }
}
