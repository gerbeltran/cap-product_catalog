using {product_catalog} from '../db/schema';


// service CatalogService {
//     entity ProductsSrv       as projection on product_catalog.materials.Products;
//     entity SuppliersSrv      as projection on product_catalog.sales.Suppliers;
//     entity CurrencySrv       as projection on product_catalog.materials.Currencies;
//     entity DimensionsUnitsrv as projection on product_catalog.materials.DimensionsUnits;
//     entity CategoriesSrv     as projection on product_catalog.materials.Categories;
//     entity SalesDataSrv      as projection on product_catalog.sales.SalesData;
//     entity ReviewSrv         as projection on product_catalog.materials.ProductReview;
//     entity UnitOfMeasuresSrv as projection on product_catalog.materials.UnitOfMeasures;
//     entity MonthSrv          as projection on product_catalog.sales.Months;
//     entity OrderSrv          as projection on product_catalog.sales.Orders;
//     entity OrderItemSrv      as projection on product_catalog.sales.OrderItems;
// }

service CatalogService {

    entity ProductsSrv          as
        select from product_catalog.reports.Products {
            ID,
            Name           as ProductName     @mandatory,
            Description                       @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price                             @mandatory,
            Height,
            Width,
            Depth,
            Quantity                          @(
                mandatory,
                assert.range: [
                    0.00,
                    20
                ]
            ),
            UnitOfMeasures as ToUnitOfMeasure @mandatory,
            Currency       as ToCurrency      @mandatory,
            Category       as ToCategory      @mandatory,
            Category.Name  as Category        @readonly,
            DimensionsUnit as ToDimensionsUnit,
            SalesData,
            Supplier,
            Review,
            Rating,
            StockAvailability,
            ToStockAvailiability,
        };

    @readonly
    entity SupplierSrv          as

        select from product_catalog.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };


    entity ReviewSrv            as
        select from product_catalog.materials.ProductReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            Product as ToProduct,
        };


    @readonly
    entity SalesDataSrv         as
        select from product_catalog.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency.ID               as CurrencyKey,
            DeliveryMonth.ID          as DeliveryMonthId,
            DeliveryMonth.Description as DeliveryMonth,
            Product                   as ToProduct,

        };

    @readonly
    entity StockAvailabilitySrv as
        select from product_catalog.materials.StockAvailability {
            ID,
            Description,
            Product as ToProduct,

        };

    @readonly
    entity VH_Categories        as
        select from product_catalog.materials.Categories {
            ID   as code,
            Name as Text,
        }

    @readonly
    entity VH_Currencies        as
        select from product_catalog.materials.Currencies {
            ID          as code,
            Description as Text,
        }

    @readonly
    entity VH_UnitOfMeasures    as
        select from product_catalog.materials.UnitOfMeasures {
            ID          as code,
            Description as Text,
        }

    @readonly
    entity VH_DimensionUnits    as
        select
            ID          as code,
            Description as Text
        from product_catalog.materials.DimensionsUnits;
}


define service MyService {

    entity SupplierProductSrv  as
        select from product_catalog.materials.Products[Name = 'Bread']{
            *,
            Name,
            Description,
            Supplier.Address
        }
        where
            Supplier.Address.PostalCode = 98074;


    entity SupplierstoSalesSrv as

        select
            Supplier.Email,
            Category.Name,
            SalesData.Currency.ID,
            SalesData.Currency.Description
        from product_catalog.materials.Products;


    entity EntidadInfix        as
        select Supplier[Name = 'Exotic Liquids'].Phone from product_catalog.materials.Products
        where
            Products.Name = 'Bread';


    entity EntidadJoin         as
        select Phone from product_catalog.materials.Products as produ
        left join product_catalog.sales.Suppliers as sup
            on(
                produ.Supplier.ID = sup.ID
            )
            and sup.Name = 'Exotic Liquids'
        where
            produ.Name = 'Bread';


}


define service ReportsSrv {

    entity AverageRatingSrv as projection on product_catalog.reports.AverageRating;

    entity EntidadCasting   as
        select
            cast(
                Price as      Integer
            )     as Price,
            Price as Price2 : Integer
        from product_catalog.materials.Products;

    entity EntidadExists    as
        select from product_catalog.materials.Products {
            Name
        }
        where
            exists Supplier[Name = 'Exotic Liquids'];
}
