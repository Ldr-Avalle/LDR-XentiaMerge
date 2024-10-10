report 50085 "Control albaranes"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Control albaranes.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table32)
        {
            DataItemTableView = WHERE(Invoiced Quantity=FILTER(0));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Posting Date";
            dataitem(DataItem1000000001;Table5802)
            {
                DataItemLink = Item Ledger Entry No.=FIELD(Entry No.);
                DataItemTableView = SORTING(Document No.);
                column(ValueEntryItemNo;"Value Entry"."Item No.")
                {
                }
                column(ItemLedgerEntryPostingDate;"Item Ledger Entry"."Posting Date")
                {
                }
                column(ValueEntryDocumentNo;"Value Entry"."Document No.")
                {
                }
                column(ValueEntryDescription;"Value Entry".Description)
                {
                }
                column(ValueEntryCostAmountExpected;"Value Entry"."Cost Amount (Expected)")
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
                TotalCost:=TotalCost+"Value Entry"."Cost Amount (Expected)";
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

