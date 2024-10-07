page 50048 "Cash Arch List2"
{
    ApplicationArea = All;
    Caption = 'Lista Arqueo de caja';
    PageType = Card;
    SourceTable = "Cash Arch_LDR";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Caption = 'Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Start cash"; Rec."Start cash")
                {
                    ApplicationArea = All;
                    Caption = 'Start cash', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("End cash"; Rec."end cash")
                {
                    ApplicationArea = All;
                    Caption = 'End cash', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Cash Notes"; Rec."Cash Notes")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Notes', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;
                    Caption = 'Registered', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                // field("Arch-Start cash"; Rec."Arch-Start cash") TODO:REVISAR CAMPO
                // {
                //     ApplicationArea = All;
                //     Caption = '', Comment = 'ESP=""';
                //     ToolTip = 'Especifica';
                // }
                field("Card Sales"; Rec."Card Sales")
                {
                    ApplicationArea = All;
                    Caption = 'Card Sales', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("POS Amount"; Rec."POS Amount")
                {
                    ApplicationArea = All;
                    Caption = 'POS Amount', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Arch; Rec.Arch)
                {
                    ApplicationArea = All;
                    Caption = 'Arch', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Discrepancy; Rec.Discrepancy)
                {
                    ApplicationArea = All;
                    Caption = 'Discrepancy', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Pay-to Bank"; Rec."Pay-to Bank")
                {
                    ApplicationArea = All;
                    Caption = 'Pay-to Bank', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("1 cent."; Rec."1 cent.")
                {
                    ApplicationArea = All;
                    Caption = '1 cent.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("2 cent."; Rec."2 cent.")
                {
                    ApplicationArea = All;
                    Caption = '2 cent.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("5 cent."; Rec."5 cent.")
                {
                    ApplicationArea = All;
                    Caption = '5 cent.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("10 cent."; Rec."10 cent.")
                {
                    ApplicationArea = All;
                    Caption = '10 cent.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("20 cent."; Rec."20 cent.")
                {
                    ApplicationArea = All;
                    Caption = '20 cent.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("50 cent."; Rec."50 cent.")
                {
                    ApplicationArea = All;
                    Caption = '50 cent.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("1 euro"; Rec."1 euro")
                {
                    ApplicationArea = All;
                    Caption = '1 euro', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("2 euros"; Rec."2 euros")
                {
                    ApplicationArea = All;
                    Caption = '2 euros', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("5 euros"; Rec."5 euros")
                {
                    ApplicationArea = All;
                    Caption = '5 euros', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("10 euros"; Rec."10 euros")
                {
                    ApplicationArea = All;
                    Caption = '10 euros', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("20 euros"; Rec."20 euros")
                {
                    ApplicationArea = All;
                    Caption = '20 euros', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("50 euros"; Rec."50 euros")
                {
                    ApplicationArea = All;
                    Caption = '50 euros', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("100 euros"; Rec."100 euros")
                {
                    ApplicationArea = All;
                    Caption = '100 euros', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("200 euros"; Rec."200 euros")
                {
                    ApplicationArea = All;
                    Caption = '200 euros', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("500 euros"; Rec."500 euros")
                {
                    ApplicationArea = All;
                    Caption = '500 euros', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    var
        UserDims: Record "User Dimensions_LDR";

#pragma warning disable AL0299
    local procedure OnAfterGetCurrRecord()
#pragma warning restore AL0299
    begin
        xRec := Rec;
        if UserDims.existsUser(UserId) then Rec.SetFilter("User ID", '%1', UserId);
    end;
}