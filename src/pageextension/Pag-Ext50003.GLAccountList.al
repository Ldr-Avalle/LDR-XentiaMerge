pageextension 50003 "G/L Account List" extends "G/L Account List"
{
    layout
    {
        addlast(Control1)
        {
            field("Ignore in 347 Report"; Rec."Ignore in 347 Report")
            {
                ApplicationArea = All;
            }
        }
    }
}
