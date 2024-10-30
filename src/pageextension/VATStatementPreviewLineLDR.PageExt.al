pageextension 50051 "VAT Statement Preview Line_LDR" extends "VAT Statement Preview Line"
{
    layout
    {
        addafter(Description)
        {
            field("Gen. Posting Type_LDR"; Rec."Gen. Posting Type")
            {
                ApplicationArea = All;
            }
        }
    }
}
