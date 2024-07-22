using {product_catalog} from '../db/schema';


service CatalogService {
    entity ProductsSrv as projection on product_catalog.Products;

    entity SuppliersSrv as projection on product_catalog.Suppliers;
//    entity Suppliers01Srv as projection on product_catalog.Suppliers_01;
    entity CarSrv as projection on product_catalog.car;
}
