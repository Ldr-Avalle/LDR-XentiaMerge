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
                    Caption = 'Employee No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Project; Rec.Project)
                {
                    ApplicationArea = All;
                    Caption = 'Project', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Production Ud."; Rec."Production Ud.")
                {
                    ApplicationArea = All;
                    Caption = 'Production Ud.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Segmento; Rec.Segmento)
                {
                    ApplicationArea = All;
                    Caption = 'Segmento', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    Caption = 'County', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'End Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }
}