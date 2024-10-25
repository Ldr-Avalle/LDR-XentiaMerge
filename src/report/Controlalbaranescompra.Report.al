report 50090 "Control albaranes compra"
{
    ApplicationArea = All;
    Caption = 'Control albaranes compra';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Control albaranes compra.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Albaran; "Item Ledger Entry")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Posting Date", "Location Code";
            dataitem(Factura; "Value Entry")
            {
                DataItemLink = "Item Ledger Entry No." = field("Entry No.");
                DataItemTableView = sorting("Document No.");
                RequestFilterFields = "Document No.", "Posting Date";

                column(FacturaItemNo; Factura."Item No.")
                {
                }
                column(FacturaPostingDate; Factura."Posting Date")
                {
                }
                column(AlbaranPostingDate; Albaran."Posting Date")
                {
                }
                column(FacturaDocumentNo; Factura."Document No.")
                {
                }
                column(FacturaDescription; Factura.Description)
                {
                }
                column(FacturaCostAmountActual; Factura."Cost Amount (Actual)")
                {
                }
                column(FacturaLocationCode; Factura."Location Code")
                {
                }
                column(TotalCost; TotalCost)
                {
                }

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("Document No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalCost := TotalCost + Factura."Cost Amount (Actual)";
            end;
        }
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalCost: Decimal;
        TotalFor: Label 'Total para ';
}