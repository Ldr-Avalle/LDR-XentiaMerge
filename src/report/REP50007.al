report 50007 "Test Sales Inv"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Test Sales Inv.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(SalesInvHeader_No; "No.")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
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

