pageextension 50003 "G/L Account List_LDR" extends "G/L Account List"
{
    layout
    {
        addlast(Control1)
        {
            field("Ignore in 347 Report_LDR"; Rec."Ignore in 347 Report")
            {
                ApplicationArea = All;
            }
        }
    }
}
