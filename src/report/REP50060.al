report 50060 "Listado Productos"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Listado Productos.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table27)
        {
            DataItemTableView = SORTING(No.)
                                WHERE(On Deposit=FILTER(No));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Item_No;Item."No.")
            {
            }
            column(Item_Description;Item.Description)
            {
            }
            column(CompanyInfo_Name;CompanyInfo.Name)
            {
            }
            dataitem(DataItem1000000001;Table5802)
            {
                DataItemLink = Item No.=FIELD(No.);
                column(ValueEntry_ItemNo;"Value Entry"."Item No.")
                {
                }
                column(ValueEntry_PostingDate;"Value Entry"."Posting Date")
                {
                }
                column(ValueEntry_ItemLedgerEntryType;"Value Entry"."Item Ledger Entry Type")
                {
                }
                column(ValueEntry_SourceNo;"Value Entry"."Source No.")
                {
                }
                column(ValueEntry_Description;"Value Entry".Description)
                {
                }
                column(ValueEntry_SalesAmountActual;"Value Entry"."Sales Amount (Actual)")
                {
                }
                column(ValueEntry_CostAmountActual;"Value Entry"."Cost Amount (Actual)")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.SHOWOUTPUT :=
                 CurrReport.TOTALSCAUSEDBY = Item.FIELDNO("No.");
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("No.");
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
        CompanyInfo: Record "79";
}

