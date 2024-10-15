report 50082 "Control albaranes compras"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Control albaranes compras.rdl';

    dataset
    {
        dataitem(Albaran; "Item Ledger Entry")
        {
            DataItemTableView = where("Source Type" = const(Vendor));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Posting Date";
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

