report 50081 "compras sin facturar"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/compras sin facturar.rdl';

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.", "Line No.")
                                where("Document Type" = filter(Order | "Return Order"),
                                      Type = filter(Item),
                                      "Quantity Invoiced" = const(0),
                                      "Buy-from Vendor No." = filter(<> 'P00040'));
            RequestFilterFields = "Order Date", "Document Type";
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(PurchaseLineDocumentNo; "Purchase Line"."Document No.")
            {
            }
            column(PurchaseLineNo; "Purchase Line"."No.")
            {
            }
            column(PurchaseLineAmtRcdNotInvoiced; "Purchase Line"."Amt. Rcd. Not Invoiced")
            {
            }
            column(PurchaseLineReturnShpdNotInvd; "Purchase Line"."Return Shpd. Not Invd.")
            {
            }
            column(PurchaseLineOrderDate; "Purchase Line"."Order Date")
            {
            }
            column(PurchaseLineDocumentType; "Purchase Line"."Document Type")
            {
            }
            column(PurchaseLineLocationCode; "Purchase Line"."Location Code")
            {
            }
            column(PurchaseLineAmtRcdNotInvoicedMenosPurchaseLineReturnShpdNotInvd; "Purchase Line"."Amt. Rcd. Not Invoiced" - "Purchase Line"."Return Shpd. Not Invd.")
            {
            }
        }
    }

    var
        CompanyInfo: Record "Company Information";
}

