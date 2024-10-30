pageextension 50008 "Customer List" extends "Customer List"
{
    layout
    {
        addafter(Name)
        {
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
            field("Invoice Amounts"; Rec."Invoice Amounts")
            {
                ApplicationArea = All;
            }
            field("Cr. Memo Amounts"; Rec."Cr. Memo Amounts")
            {
                ApplicationArea = All;
            }
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
        }
    }
}
