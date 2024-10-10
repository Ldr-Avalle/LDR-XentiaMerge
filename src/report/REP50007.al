report 50007 "Test Sales Inv"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Test Sales Inv.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table112)
        {
            DataItemTableView = SORTING(No.)
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(SalesInvHeader_No;"No.")
            {
            }
            dataitem(DataItem1000000001;Table113)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(Document No.,Line No.)
                                    ORDER(Ascending);
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        InvoiceLbl = 'Invoice No.';
        NameLbl = 'Name';
        PhoneLbl = 'Phone';
        AddressLbl = 'Address';
        NITLbl = 'NIT';
        TypeLbl = 'Type';
        DescriptionLbl = 'Description';
        QtyLbl = 'Quantity';
        AmountLbl = 'Amount';
        TotalLbl = 'TOTAL';
    }
}

