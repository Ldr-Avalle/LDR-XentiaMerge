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
                    Caption = 'Component', Comment = 'ESP="Componente"';
                    ToolTip = 'Especifica el componente';
                }
                field("Component description"; Rec."Component description")
                {
                    ApplicationArea = All;
                    Caption = 'Component description', Comment = 'ESP="Descripción comp."';
                    ToolTip = 'Especifica la descripción comp.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity', Comment = 'ESP="Cantidad"';
                    ToolTip = 'Especifica la cantidad';
                }
            }
        }
    }
}