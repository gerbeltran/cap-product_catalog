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
        select from product_catalog.materials.Products {
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
            Quantity,
            UnitOfMeasures as ToUnitOfMeasure @mandatory,
            Currency       as ToCurrency      @mandatory,
            Category       as ToCategory      @mandatory,
            Category.Name  as Category        @readonly,
            DimensionsUnit as ToDimensionsUnit,
            SalesData,
            Supplier,
            Review,

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
        select from product_catalog.materials.DimensionsUnits {
            ID          as code,
            Description as Text,
        }

}
