report 50061 "Movimientos de productos"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Movimientos de productos.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Serial No.")
                                WHERE("On Deposit" = FILTER(false),
                                      "Document Type" = FILTER("Purchase Receipt" | "Purchase Return Shipment" | "Sales Invoice" | "Sales Credit Memo"),
                                      "Serial No." = FILTER(<> ''),
                                      Open = FILTER(false),
                                      "Entry Type" = FILTER(Sale));
            RequestFilterFields = "Posting Date";
            //todo: pasar a variables
            column(Pagina; PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(ItemLedgerEntry_EntryNo; "Item Ledger Entry"."Entry No.")
            {
            }
            column(ItemLedgerEntry_PostingDate; "Item Ledger Entry"."Posting Date")
            {
            }
            column(ItemLedgerEntry_EntryType; "Item Ledger Entry"."Entry Type")
            {
            }
            column(ItemLedgerEntry_DocumentNo; "Item Ledger Entry"."Document No.")
            {
            }
            column(ItemLedgerEntry_LocationCode; "Item Ledger Entry"."Location Code")
            {
            }
            column(ItemLedgerEntry_InvoicedQuantity; "Item Ledger Entry"."Invoiced Quantity")
            {
            }
            column(ItemLedgerEntry_SerialNo; "Item Ledger Entry"."Serial No.")
            {
            }
            column(ItemLedgerEntry_CostAmountActual; "Item Ledger Entry"."Cost Amount (Actual)")
            {
            }
            column(ItemLedgerEntry_SalesAmountActual; "Item Ledger Entry"."Sales Amount (Actual)")
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
        PageConst: Label 'Página';
        TotalFor: Label 'Total para ';
        CompanyInfo: Record "79";
}

