page 50000 "User Dimensions"
{
    ApplicationArea = All;
    Caption = 'User Dimensions', Comment = 'ESP=""';
    PageType = Card;
    SourceTable = "User Dimensions_LDR";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    Caption = 'User', Comment = 'ESP="Usuario"';
                    ToolTip = 'Especifica el usuario';
                }
                field("Provincias Dimension Value"; Rec."Provincias Dimension Value")
                {
                    ApplicationArea = All;
                    Caption = 'Provincias Dimension Value', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Project Dimension Value"; Rec."Project Dimension Value")
                {
                    ApplicationArea = All;
                    Caption = 'Project Dimension Value', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Segmento Dimension Value"; Rec."Segmento Dimension Value")
                {
                    ApplicationArea = All;
                    Caption = 'Segmento Dimension Value', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Unidades Prod  Dimension Value"; Rec."Unidades Prod  Dimension Value")
                {
                    ApplicationArea = All;
                    Caption = 'Unidades Prod  Dimension Value', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Shop Address"; Rec."Shop Address")
                {
                    ApplicationArea = All;
                    Caption = 'Shop Address', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }

    procedure getUserName() name: Text[50]
    var
        WindowsLogin: Record "Access Control";
    begin
        WindowsLogin.SetFilter(WindowsLogin."User Security ID", '%1', Rec.User);
        if Rec.FindFirst() then
            exit(WindowsLogin."User Name")
        else
            exit('');
    end;
}