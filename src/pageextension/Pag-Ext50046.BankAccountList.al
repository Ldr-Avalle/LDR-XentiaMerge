pageextension 50046 "Bank Account List" extends "Bank Account List"
{
    layout
    {
        addafter("Search Name")
        {
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = All;
            }
        }
    }
}
