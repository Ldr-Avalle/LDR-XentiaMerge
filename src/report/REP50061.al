report 50061 "Movimientos de productos"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Movimientos de productos.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table32)
        {
            DataItemTableView = SORTING(Serial No.)
                                WHERE(On Deposit=FILTER(No),
                                      Document Type=FILTER(Purchase Receipt|Purchase Return Shipment|Sales Invoice|Sales Credit Memo),
                                      Serial No.=FILTER(<>''),
                                      Open=FILTER(No),
                                      Entry Type=FILTER(Sale));
            RequestFilterFields = "Posting Date";
            column(Pagina;PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(CompanyInfo_Name;CompanyInfo.Name)
            {
            }
            column(ItemLedgerEntry_EntryNo;"Item Ledger Entry"."Entry No.")
            {
            }
            column(ItemLedgerEntry_PostingDate;"Item Ledger Entry"."Posting Date")
            {
            }
            column(ItemLedgerEntry_EntryType;"Item Ledger Entry"."Entry Type")
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
            column(ItemLedgerEntry_SerialNo;"Item Ledger Entry"."Serial No.")
            {
            }
            column(ItemLedgerEntry_CostAmountActual;"Item Ledger Entry"."Cost Amount (Actual)")
            {
            }
            column(ItemLedgerEntry_SalesAmountActual;"Item Ledger Entry"."Sales Amount (Actual)")
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Entry No.");
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
        PageConst: Label 'P´Š¢gina';
        TotalFor: Label 'Total para ';
        CompanyInfo: Record "79";
}

