namespace product_catalog;

entity Customer {
    key ID   : Integer;
        name : String;
}

entity Products {
    key ProductId : Integer;
        Name      : String;
        Category  : String;
}
