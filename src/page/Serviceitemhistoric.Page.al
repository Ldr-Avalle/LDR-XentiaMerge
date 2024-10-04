page 50010 "Service item historic"
{
    ApplicationArea = All;
    Caption = 'Histórico servicio';
    PageType = Card;
    SourceTable = "Service Prices_LDR";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date', Comment = 'ESP="Fecha Inicio"';
                    ToolTip = 'Especifica la fecha de inicio';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date', Comment = 'ESP="Fecha Fin"';
                    ToolTip = 'Especifica la fecha fin';
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    Caption = 'Price', Comment = 'ESP="Precio"';
                    ToolTip = 'Especifica el precio';
                }
            }
        }
    }
}