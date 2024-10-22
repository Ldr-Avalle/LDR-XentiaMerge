pageextension 50002 "Chart of Accounts" extends "Chart of Accounts"
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
