using {product_catalog} from '../db/schema';

service CustomerService {

    entity CustomerSrv as projection on product_catalog.Customer;

}
