pageextension 50047 "Payment Methods" extends "Payment Methods"
{
    layout
    {
        addafter("Bal. Account No.")
        {
            field(Project; Rec.Project)
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill Type")
        {
            field("Área PM"; Rec."Área PM")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    VAR
        UserDimensions: Record 50000;
    BEGIN
        proyecto := UserDim.getProjectDim(USERID);
        IF proyecto <> '' THEN
            rec.SETFILTER(Project, '%1', proyecto);
    END;

    VAR
        proyecto: Text[30];
        UserDim: Record 50000;
}
