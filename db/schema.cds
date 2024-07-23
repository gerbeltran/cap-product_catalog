namespace product_catalog;

type address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
};

type Dec    : Decimal(16, 2);
// type EmailsAddresses_01 : many {
//     kind  : String;
//     email : String;
// }

// type EmailsAddresses_02 : array of {
//     kind  : String;
//     email : String;
// }

// entity Emails {
//     email_01 : EmailsAddresses_01;
//     email_02 : many EmailsAddresses_02;
//     email_03 : many {
//          kind  : String;
//          email : String;
//      };
// }

entity Products {
    key ID               : UUID;
        Name             : String not null;
        Description      : String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        DiscontinuedDate : DateTime;
        Price            : Dec;
        Height           : type of Price;
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        Supplier         : Association to Suppliers;
        UnitOfMeasures   : Association to UnitOfMeasures;
        Currency         : Association to Currencies;
        DimensionsUnit   : Association to DimensionsUnits;
        Category         : Association to Categories;
        SalesData        : Association to many SalesData
                               on SalesData.Product = $self;
        Review : Association to many ProductReview 
                                on Review.Product = $self;
                                                       
};

entity Suppliers {
    key ID         : UUID;
        Name       : Products:Name;
        Street     : String;
        City       : String;
        State      : String(2);
        PostalCode : String(5);
        Country    : String(3);
        Email      : String;
        Phone      : String;
        Fax        : String;
        Product : Association to many Products
                        on Product.Supplier = $self;
};

entity Suppliers_01 {
    key ID      : UUID;
        Name    : String;
        address : address;
        Email   : String;
        Phone   : String;
        Fax     : String;
};

entity Suppliers_02 {
    key ID    : UUID;
        Name  : String;
        Address {
            Street     : String;
            City       : String;
            State      : String(2);
            PostalCode : String(5);
            Country    : String(3);
        };
        Email : String;
        Phone : String;
        Fax   : String;

};

entity Categories {
    key ID   : String(1);
        Name : String;
};


entity StockAvailability {
    key ID          : Integer;
        Description : String;
};

entity Currencies {
    key ID          : String(3);
        Description : String;
};

entity UnitOfMeasures {
    key ID          : String(2);
        Description : String;
};

entity DimensionsUnits {
    key ID          : String(2);
        Description : String;
};

entity Months {
    key ID               : String(2);
        Description      : String;
        ShortDescription : String(3);
};


entity ProductReview {
    key Id      : String(2);
        Name    : String;
        Rating  : Integer;
        Comment : String;
        Product : Association to Products;
};

entity SalesData {
    key ID            : UUID;
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to Products;
        Currency      : Association to Currencies;
        DeliveryMonth : Association to Months;
};


type Gender : String enum {
    male;
    female;
};

/*
entity Order {
    clientGender : Gender;
    status       : Integer enum {
        submitted = 1;
        fulfiller = 2;
        shipped   = 3;
        cancel    = -1;
    };
    priority     : String @assert.range enum {
        high;
        medium;
        low;
    };
}
*/

entity Orders {
    key ID: UUID;
    Date: Date;
    Customer: String;
    Item : Composition of  many OrderItems 
                        on Item.Order = $self;
}

entity OrderItems {
    Key ID: UUID;
    Order : Association to Orders;
    Product: Association to Products;
    Quantity: Integer;

}

entity car {
    key ID                 : UUID;
        Name               : String;
        virtual discount_1 : Decimal;

        @Core.Computed: false
        virtual discount_2 : Decimal;

}

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

/*entity ParamProducts(pName : String) as
    select from Products {
        Name,
        Price,
        Quantity,
    }
    where
        Name = :pName;
*/
//entity ProjParamProducts(pName: String) as projection on Products where Name = :pName;

extend Products with {
    PriceCondition      : String(2);
    PriceDeterminaation : String(3);
}

entity Course {
    key ID: UUID;
    Student: Association to many StudentCourse
                                on Student.Course = $self;
}
entity Student {
    key ID: UUID;
    Course : Association to many StudentCourse 
                        on Course.Student = $self;
}

entity StudentCourse {
    key ID: UUID;
    Student : Association to Student;
    Course : Association to Course;
}