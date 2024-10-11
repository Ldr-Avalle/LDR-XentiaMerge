report 50072 Pedidos
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Pedidos.rdl';

    dataset
    {
        dataitem("Purchase Line"; "Purchase Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
            RequestFilterFields = "Document Type", "Document No.", "Qty. Rcd. Not Invoiced", "Order Date", "Return Qty. Shipped Not Invd.";
            column(PurchaseLineDocumentType; "Purchase Line"."Document Type")
            {
            }
            column(PurchaseLineDocumentNo; "Purchase Line"."Document No.")
            {
            }
            column(PurchaseLineDocumentType2; "Purchase Line"."Document Type")
            {
            }
            column(PurchaseLineBuyfromVendorNo; "Purchase Line"."Buy-from Vendor No.")
            {
            }
            column(PurchaseLineDocumentNo2; "Purchase Line"."Document No.")
            {
            }
            column(PurchaseLineType; "Purchase Line".Type)
            {
            }
            column(PurchaseLineNo; "Purchase Line"."No.")
            {
            }
            column(PurchaseLineDescription; "Purchase Line".Description)
            {
            }
            column(PurchaseLineQtyRcdNotInvoiced; "Purchase Line"."Qty. Rcd. Not Invoiced")
            {
            }
            column(PurchaseLineAmtRcdNotInvoiced; "Purchase Line"."Amt. Rcd. Not Invoiced")
            {
            }
            column(PurchaseLineReturnQtyShippedNotInvd; "Purchase Line"."Return Qty. Shipped Not Invd.")
            {
            }
            column(PurchaseLineReturnShpdNotInvd; "Purchase Line"."Return Shpd. Not Invd.")
            {
            }
            column(TotalForDocumentNo; TotalFor + FIELDCAPTION("Purchase Line"."Document No."))
            {
            }
            column(PurchaseLineQtyRcdNotInvoiced2; "Purchase Line"."Qty. Rcd. Not Invoiced")
            {
            }
            column(PurchaseLineAmtRcdNotInvoiced2; "Purchase Line"."Amt. Rcd. Not Invoiced")
            {
            }
            column(PurchaseLineReturnQtyShippedNotInvd2; "Purchase Line"."Return Qty. Shipped Not Invd.")
            {
            }
            column(PurchaseLineReturnShpdNotInvd2; "Purchase Line"."Return Shpd. Not Invd.")
            {
            }
            column(TotalForDocumentType; TotalFor + FIELDCAPTION("Document Type"))
            {
            }
            column(PurchaseLineQtyRcdNotInvoiced3; "Purchase Line"."Qty. Rcd. Not Invoiced")
            {
            }
            column(PurchaseLineAmtRcdNotInvoiced3; "Purchase Line"."Amt. Rcd. Not Invoiced")
            {
            }
            column(PurchaseLineReturnQtyShippedNotInvd3; "Purchase Line"."Return Qty. Shipped Not Invd.")
            {
            }
            column(PurchaseLineReturnShpdNotInvd3; "Purchase Line"."Return Shpd. Not Invd.")
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Document No.");
            end;
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
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total para ';
}

