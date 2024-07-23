using {product_catalog} from '../db/schema';


service CatalogService {
    entity ProductsSrv       as projection on product_catalog.Products;
    entity SuppliersSrv      as projection on product_catalog.Suppliers;
    entity CurrencySrv       as projection on product_catalog.Currencies;
    entity DimensionsUnitsrv as projection on product_catalog.DimensionsUnits;
    entity CategoriesSrv     as projection on product_catalog.Categories;
    entity SalesDataSrv      as projection on product_catalog.SalesData;
    entity ReviewSrv         as projection on product_catalog.ProductReview;
    entity UnitOfMeasuresSrv as projection on product_catalog.UnitOfMeasures;
    entity MonthSrv          as projection on product_catalog.Months;
    entity OrderSrv          as projection on product_catalog.Orders;
    entity OrderItemSrv      as projection on product_catalog.OrderItems;
}

