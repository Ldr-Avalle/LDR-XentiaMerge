page 50000 "User Dimensions"
{
    ApplicationArea = All;
    Caption = 'User Dimensions';
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
                field("Area Dimension Value"; Rec."Provincias Dimension Value")
                {
                    ApplicationArea = All;
                    Caption = 'Provincias Dimension Value', Comment = 'ESP="Valor Dimensión Provincias"';
                    ToolTip = 'Especifica el valor dimensión provincias';
                }
                field("Project Dimension Value"; Rec."Project Dimension Value")
                {
                    ApplicationArea = All;
                    Caption = 'Project Dimension Value', Comment = 'ESP="Valor Dimensión Proyecto"';
                    ToolTip = 'Especifica el valor dimensión proyecto';
                }
                field("Segmento Dimension Value"; Rec."Segmento Dimension Value")
                {
                    ApplicationArea = All;
                    Caption = 'Segmento Dimension Value', Comment = 'ESP="Valor Dimensión Segmento"';
                    ToolTip = 'Especifica el valor dimensión segmento';
                }
                field("Unidades Prod  Dimension Value"; Rec."Unidades Prod  Dimension Value")
                {
                    ApplicationArea = All;
                    Caption = 'Dept. Dimension Value', Comment = 'ESP="Valor Dimensión Unidades Prod"';
                    ToolTip = 'Especifica el valor dimensión unidades prod';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location Code';
                    ToolTip = 'Especifica el location code';
                }
                field("Shop Address"; Rec."Shop Address")
                {
                    ApplicationArea = All;
                    Caption = 'Shop Address';
                    ToolTip = 'Especifica el shop address';
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