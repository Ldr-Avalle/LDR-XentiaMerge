page 50008 "Employee training subform"
{
    ApplicationArea = All;
    Caption = 'Subform formación empleado', Comment = 'ESP=""';
    PageType = CardPart;
    SourceTable = "Employee Training_LDR";
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
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Caption = 'Date', Comment = 'ESP="Fecha"';
                    ToolTip = 'Especifica la fecha';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type', Comment = 'ESP="Tipo"';
                    ToolTip = 'Especifica el tipo';
                }
                field(Hours; Rec.Hours)
                {
                    ApplicationArea = All;
                    Caption = 'Hours', Comment = 'ESP="Horas"';
                    ToolTip = 'Especifica las horas';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Comment = 'ESP="Descripción"';
                    ToolTip = 'Especifica la descripción';
                }
            }
        }
    }
}