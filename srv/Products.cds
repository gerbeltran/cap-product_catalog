using {product_catalog} from '../db/schema';


service ProductsService {
    entity ProductsSrv as projection on product_catalog.Products;


}
