pageextension 50036 "Posted Sales Invoice Subform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        addbefore("VAT %")
        {
            field("VAT Calculation Type"; Rec."VAT Calculation Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Unit Price")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Serial No."; Rec."Serial No.")
            {
                ApplicationArea = All;
            }
        }
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = All;
            Visible = true;
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = All;
            Visible = true;
        }
        modify("VAT %")
        {
            ApplicationArea = All;
            Visible = true;
        }
    }
}
