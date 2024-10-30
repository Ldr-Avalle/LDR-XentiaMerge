pageextension 50046 "Bank Account List_LDR" extends "Bank Account List"
{
    layout
    {
        addafter("Search Name")
        {
            field("Net Change_LDR"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("Net Change (LCY)_LDR"; Rec."Net Change (LCY)")
            {
                ApplicationArea = All;
            }
        }
    }
}
