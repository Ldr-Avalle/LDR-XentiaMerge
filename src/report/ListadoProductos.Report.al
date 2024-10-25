report 50060 "Listado Productos"
{
    ApplicationArea = All;
    Caption = 'Listado Productos';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Listado Productos.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.") where("On Deposit" = filter(false));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";

            column(Item_No; Item."No.")
            {
            }
            column(Item_Description; Item.Description)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }

            dataitem("Value Entry"; "Value Entry")
            {
                DataItemLink = "Item No." = field("No.");

                column(ValueEntry_ItemNo; "Value Entry"."Item No.")
                {
                }
                column(ValueEntry_PostingDate; "Value Entry"."Posting Date")
                {
                }
                column(ValueEntry_ItemLedgerEntryType; "Value Entry"."Item Ledger Entry Type")
                {
                }
                column(ValueEntry_SourceNo; "Value Entry"."Source No.")
                {
                }
                column(ValueEntry_Description; "Value Entry".Description)
                {
                }
                column(ValueEntry_SalesAmountActual; "Value Entry"."Sales Amount (Actual)")
                {
                }
                column(ValueEntry_CostAmountActual; "Value Entry"."Cost Amount (Actual)")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                //CurrReport.ShowOutput := CurrReport.TotalsCausedBy() = Item.FieldNo("No."); //TODO:REVISAR
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");
            end;
        }
    }

    var
        CompanyInfo: Record "Company Information";
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
}