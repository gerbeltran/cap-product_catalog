using {product_catalog} from '../db/schema';


service CatalogService {
    entity ProductsSrv       as projection on product_catalog.materials.Products;
    entity SuppliersSrv      as projection on product_catalog.sales.Suppliers;
    entity CurrencySrv       as projection on product_catalog.materials.Currencies;
    entity DimensionsUnitsrv as projection on product_catalog.materials.DimensionsUnits;
    entity CategoriesSrv     as projection on product_catalog.materials.Categories;
    entity SalesDataSrv      as projection on product_catalog.sales.SalesData;
    entity ReviewSrv         as projection on product_catalog.materials.ProductReview;
    entity UnitOfMeasuresSrv as projection on product_catalog.materials.UnitOfMeasures;
    entity MonthSrv          as projection on product_catalog.sales.Months;
    entity OrderSrv          as projection on product_catalog.sales.Orders;
    entity OrderItemSrv      as projection on product_catalog.sales.OrderItems;
}

