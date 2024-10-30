pageextension 50002 "Chart of Accounts_LDR" extends "Chart of Accounts"
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
