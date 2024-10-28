pageextension 50034 "User Setup" extends "User Setup"
{
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
            field("Approver ID"; Rec."Approver ID")
            {
                ApplicationArea = All;
            }
            field(VerInfoConfidencial; Rec.VerInfoConfidencial)
            {
                ApplicationArea = All;
            }
        }
    }
}
