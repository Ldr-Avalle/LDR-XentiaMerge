page 50021 "Agreement List"
{
    ApplicationArea = All;
    Caption = 'Lista de convenios';
    PageType = Card;
    SourceTable = Agreement_LDR;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code', Comment = 'ESP="Código"';
                    ToolTip = 'Especifica el código';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name', Comment = 'ESP="Nombre"';
                    ToolTip = 'Especifica el nombre';
                }
            }
        }
    }
}