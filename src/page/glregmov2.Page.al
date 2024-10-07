page 50026 "gl reg mov2"
{
    ApplicationArea = All;
    Caption = '', Comment = 'ESP=""';
    PageType = List;
    SourceTable = "G/L Register";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.', Comment = 'ESP="Nº"';
                    ToolTip = 'Especifica el nº';
                }
                // field("Num Asiento en Mov cont"; Rec."Num Asiento en Mov cont") //TODO:Pendiente de añadir la tabla extension G/L Register
                // {
                //     ApplicationArea = All;
                //     Caption = '', Comment = 'ESP=""';
                //     ToolTip = 'Especifica';
                // }
            }
        }
    }
}