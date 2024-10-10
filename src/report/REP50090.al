report 50090 "Control albaranes compra"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Control albaranes compra.rdlc';

    dataset
    {
        dataitem("Albar´Š¢n";Table32)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Posting Date","Location Code";
            dataitem(Factura;Table5802)
            {
                DataItemLink = Item Ledger Entry No.=FIELD(Entry No.);
                DataItemTableView = SORTING(Document No.);
                RequestFilterFields = "Document No.","Posting Date";
                column(FacturaItemNo;Factura."Item No.")
                {
                }
                column(FacturaPostingDate;Factura."Posting Date")
                {
                }
                column(AlbaranPostingDate;Albar´Š¢n."Posting Date")
                {
                }
                column(FacturaDocumentNo;Factura."Document No.")
                {
                }
                column(FacturaDescription;Factura.Description)
                {
                }
                column(FacturaCostAmountActual;Factura."Cost Amount (Actual)")
                {
                }
                column(FacturaLocationCode;Factura."Location Code")
                {
                }
                column(TotalCost;TotalCost)
                {
                }

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO("Document No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalCost:=TotalCost + Factura."Cost Amount (Actual)";
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

