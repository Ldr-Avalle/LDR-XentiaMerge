pageextension 50047 "Payment Methods_LDR" extends "Payment Methods"
{
    layout
    {
        addafter("Bal. Account No.")
        {
            field(Project_LDR; Rec.Project)
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
    var
    //UserDimensions: Record "User Dimensions_LDR";
    begin
        proyecto := UserDim.getProjectDim(UserId);
        if proyecto <> '' then
            Rec.SetFilter(Project, '%1', proyecto);
    end;

    var
        proyecto: Text[30];
        UserDim: Record "User Dimensions_LDR";
}
