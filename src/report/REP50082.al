report 50082 "Control albaranes compras"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Control albaranes compras.rdl';

    dataset
    {
        dataitem("Albaran"; "Item Ledger Entry")
        {
            DataItemTableView = WHERE("Source Type" = CONST(Vendor));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Posting Date";
            dataitem(Factura; "Value Entry")
            {
                DataItemLink = "Item Ledger Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Document No.");
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
                    LastFieldNo := FIELDNO("Document No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalCost := TotalCost + Factura."Cost Amount (Actual)";
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
        TotalCost: Decimal;
        TotalFor: Label 'Total para ';
}

