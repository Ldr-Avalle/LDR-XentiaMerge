report 50085 "Control albaranes"
{
    ApplicationArea = All;
    Caption = 'Control albaranes';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Control albaranes.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Invoiced Quantity" = filter(0));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Posting Date";

            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Item Ledger Entry No." = field("Entry No.");
                DataItemTableView = sorting("Document No.");
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
                    LastFieldNo := FieldNo("Document No.");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalCost := TotalCost + "Value Entry"."Cost Amount (Expected)";
            end;
        }
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalCost: Decimal;
        TotalFor: Label 'Total para ';
}