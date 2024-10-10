report 50062 "listado productos series"
{
    DefaultLayout = RDLC;
    RDLCLayout = './listado productos series.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table32)
        {
            DataItemTableView = SORTING(Serial No.)
                                WHERE(Global Dimension 1 Code=FILTER(TELECABLE),
                                      Document Type=FILTER(Purchase Receipt|Purchase Return Shipment|Sales Invoice|Sales Credit Memo));
            RequestFilterFields = "Item No.";
            column(CompanyInfo_Name;CompanyInfo.Name)
            {
            }
            column(ItemLedgerEntry_ItemNo;"Item Ledger Entry"."Item No.")
            {
            }
            column(ItemLedgerEntry_PostingDate;"Item Ledger Entry"."Posting Date")
            {
            }
            column(ItemLedgerEntry_DocumentNo;"Item Ledger Entry"."Document No.")
            {
            }
            column(ItemLedgerEntry_LocationCode;"Item Ledger Entry"."Location Code")
            {
            }
            column(ItemLedgerEntry_InvoicedQuantity;"Item Ledger Entry"."Invoiced Quantity")
            {
            }
            column(ItemLedgerEntry_DocumentType;"Item Ledger Entry"."Document Type")
            {
            }
            column(ItemLedgerEntry_SerialNo;"Item Ledger Entry"."Serial No.")
            {
            }
            column(ItemLedgerEntry_SalesAmountActual;"Item Ledger Entry"."Sales Amount (Actual)")
            {
            }
            column(ItemLedgerEntry_PurchaseAmountActual;"Item Ledger Entry"."Purchase Amount (Actual)")
            {
            }
            column(ItemLedgerEntry_EntryType;"Item Ledger Entry"."Entry Type")
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Item No.");
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
        CompanyInfo: Record "79";
}

