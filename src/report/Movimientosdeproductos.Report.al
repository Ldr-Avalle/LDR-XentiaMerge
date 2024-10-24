report 50061 "Movimientos de productos"
{
    ApplicationArea = All;
    Caption = 'Movimientos de productos';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Movimientos de productos.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Serial No.") where("On Deposit" = filter(false), "Document Type" = filter("Purchase Receipt" | "Purchase Return Shipment" | "Sales Invoice" | "Sales Credit Memo"), "Serial No." = filter(<> ''), Open = filter(false), "Entry Type" = filter(Sale));
            RequestFilterFields = "Posting Date";

            column(Pagina; PageConst + ' ' + Format(CurrReport.PageNo()))
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
                LastFieldNo := FieldNo("Entry No.");
            end;
        }
    }

    var
        CompanyInfo: Record "Company Information";
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PageConst: Label 'Página';
        TotalFor: Label 'Total para ';
}