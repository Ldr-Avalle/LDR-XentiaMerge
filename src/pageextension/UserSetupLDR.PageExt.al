pageextension 50034 "User Setup_LDR" extends "User Setup"
{
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("E-Mail_LDR"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
            field("Approver ID_LDR"; Rec."Approver ID")
            {
                ApplicationArea = All;
            }
            field(VerInfoConfidencial_LDR; Rec.VerInfoConfidencial)
            {
                ApplicationArea = All;
            }
        }
    }
}
