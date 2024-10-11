report 50085 "Control albaranes"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Control albaranes.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = WHERE("Invoiced Quantity" = FILTER(0));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Posting Date";
            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Item Ledger Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Document No.");
                column(ValueEntryItemNo; "Value Entry"."Item No.")
                {
                }
                column(ItemLedgerEntryPostingDate; "Item Ledger Entry"."Posting Date")
                {
                }
                column(ValueEntryDocumentNo; "Value Entry"."Document No.")
                {
                }
                column(ValueEntryDescription; "Value Entry".Description)
                {
                }
                column(ValueEntryCostAmountExpected; "Value Entry"."Cost Amount (Expected)")
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
                TotalCost := TotalCost + "Value Entry"."Cost Amount (Expected)";
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

