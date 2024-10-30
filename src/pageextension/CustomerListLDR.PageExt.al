pageextension 50008 "Customer List_LDR" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field(City_LDR; Rec.City)
            {
                ApplicationArea = All;
            }
            field("Invoice Amounts_LDR"; Rec."Invoice Amounts")
            {
                ApplicationArea = All;
            }
            field("Cr. Memo Amounts_LDR"; Rec."Cr. Memo Amounts")
            {
                ApplicationArea = All;
            }
            field(Balance_LDR; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("Net Change_LDR"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
        }
    }
}
