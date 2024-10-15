page 50020 "Works List"
{
    ApplicationArea = All;
    Caption = 'Lista de obras';
    PageType = Card;
    SourceTable = Work_LDR;
    UsageCategory = Lists;

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Comment = 'ESP="Descripción"';
                    ToolTip = 'Especifica la descripción';
                }
                field("No. of Contracts"; Rec."No. of Contracts")
                {
                    ApplicationArea = All;
                    Caption = 'No. of Contracts', Comment = 'ESP="Nº contratos"';
                    ToolTip = 'Especifica el nº contratos';
                }
            }
        }
    }
}