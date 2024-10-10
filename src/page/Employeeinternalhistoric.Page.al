page 50009 "Employee internal historic"
{
    ApplicationArea = All;
    Caption = 'Históico interno empleado';
    PageType = Card;
    SourceTable = "Employee internal historic_LDR";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Caption = 'Employee No.', Comment = 'ESP="Empleado"';
                    ToolTip = 'Especifica el empleado';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date', Comment = 'ESP="Fecha inicio"';
                    ToolTip = 'Especifica la fecha de inicio';
                }
                field(Project; Rec.Project)
                {
                    ApplicationArea = All;
                    Caption = 'Project', Comment = 'ESP="Proyecto"';
                    ToolTip = 'Especifica el proyecto';
                }
                field("Production Ud."; Rec."Production Ud.")
                {
                    ApplicationArea = All;
                    Caption = 'Production Ud.', Comment = 'ESP="Ud. Producción"';
                    ToolTip = 'Especifica la ud. producción';
                }
                field(Segmento; Rec.Segmento)
                {
                    ApplicationArea = All;
                    Caption = 'Segmento', Comment = 'ESP="Segmento"';
                    ToolTip = 'Especifica el segmento';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    Caption = 'County', Comment = 'ESP="Provincia"';
                    ToolTip = 'Especifica la provincia';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date', Comment = 'ESP="Fecha fin"';
                    ToolTip = 'Especifica la fecha fin';
                }
            }
        }
    }
}