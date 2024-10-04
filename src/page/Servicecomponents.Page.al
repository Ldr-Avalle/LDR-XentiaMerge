page 50011 "Service components"
{
    ApplicationArea = All;
    Caption = 'Componentes servicio';
    PageType = Card;
    SourceTable = "Service Components_LDR";

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field(Component; Rec.Component)
                {
                    ApplicationArea = All;
                    Caption = 'Component', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Component description"; Rec."Component description")
                {
                    ApplicationArea = All;
                    Caption = 'Component description', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }
}