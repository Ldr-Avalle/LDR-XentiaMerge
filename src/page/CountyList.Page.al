page 50015 "County List"
{
    ApplicationArea = All;
    Caption = 'Lista poblaciones';
    PageType = Card;
    SourceTable = "TBAI Alava2_LDR";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    Caption = 'ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Envios; Rec.Envios)
                {
                    ApplicationArea = All;
                    Caption = 'Envios', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Respuestas; Rec.Respuestas)
                {
                    ApplicationArea = All;
                    Caption = 'Respuestas', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                //TODO:PREGUNTAR A AITOR SI LOS AÑADO A LA TABLA DE LA QUE TIRA O LOS ELIMINO YA QUE NO LOS CONTIENE ACTUALMENTE ESTOS CAMPOS
                // field(Blocked; Rec.Blocked)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Blocked', Comment = 'ESP=""';
                //     ToolTip = 'Especifica';
                // }
            }
        }
    }
}