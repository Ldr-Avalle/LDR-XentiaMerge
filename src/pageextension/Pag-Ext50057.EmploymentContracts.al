pageextension 50057 "Employment Contracts" extends "Employment Contracts"
{
    layout
    {
        addafter(Description)
        {
            field("Working %"; Rec."Working %")
            {
                ApplicationArea = All;
            }
        }
    }
}
