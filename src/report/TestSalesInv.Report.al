report 50007 "Test Sales Inv"
{
    ApplicationArea = All;
    Caption = 'Test Sales Inv';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Test Sales Inv.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.") order(ascending);
            RequestFilterFields = "No.";
            column(SalesInvHeader_No; "No.")
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") order(ascending);
            }
        }
    }

    labels
    {
        InvoiceLbl = 'Invoice No.', Comment = 'ESP="Factura No."';
        NameLbl = 'Name', Comment = 'ESP="Nombre Cliente"';
        PhoneLbl = 'Phone', Comment = 'ESP="Telefono"';
        AddressLbl = 'Address', Comment = 'ESP="Dirección"';
        NITLbl = 'NIT', Comment = 'ESP="NIT"';
        TypeLbl = 'Type', Comment = 'ESP="Tipo"';
        DescriptionLbl = 'Description', Comment = 'ESP="Descripción"';
        QtyLbl = 'Quantity', Comment = 'ESP="Cantidad"';
        AmountLbl = 'Amount', Comment = 'ESP="Valor"';
        TotalLbl = 'TOTAL', Comment = 'ESP="TOTAL"';
    }
}