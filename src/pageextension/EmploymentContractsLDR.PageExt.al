pageextension 50057 "Employment Contracts_LDR" extends "Employment Contracts"
{
    layout
    {
        addafter(Description)
        {
            field("Working %_LDR"; Rec."Working %")
            {
                ApplicationArea = All;
            }
        }
    }
}
