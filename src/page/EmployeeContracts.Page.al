page 50001 "Employee Contracts"
{
    ApplicationArea = All;
    Caption = 'Employee Contracts', Comment = 'ESP=""';
    PageType = CardPart;
    SourceTable = "Employee Contract";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.', Comment = 'ESP="Nº"';
                    ToolTip = 'Especifica el nº';
                    Editable = false;
                }
                field("Date of hire"; Rec."Date of hire")
                {
                    ApplicationArea = All;
                    Caption = 'Date of hire', Comment = 'ESP="Fecha alta"';
                    ToolTip = 'Especifica la fecha alta';
                }
                field("Contract type"; Rec."Contract type")
                {
                    ApplicationArea = All;
                    Caption = 'Contract type', Comment = 'ESP="Tipo contrato"';
                    ToolTip = 'Especifica el tipo contrato';
                }
                field(Work; Rec.Work)
                {
                    ApplicationArea = All;
                    Caption = 'Work', Comment = 'ESP="Obra"';
                    ToolTip = 'Especifica la obra';
                }
                field(Agreement; Rec.Agreement)
                {
                    ApplicationArea = All;
                    Caption = 'Agreement', Comment = 'ESP="Convenio"';
                    ToolTip = 'Especifica el convenio';
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    Caption = 'Category', Comment = 'ESP="Categoría"';
                    ToolTip = 'Especifica la categoría';
                }
                field("Working %"; Rec."Working %")
                {
                    ApplicationArea = All;
                    Caption = 'Working %', Comment = 'ESP="% Jornada"';
                    ToolTip = 'Especifica el % jornada';
                    BlankZero = true;
                }
                field("Working Time"; Rec."Working Time")
                {
                    ApplicationArea = All;
                    Caption = 'Working Time', Comment = 'ESP="Horario laboral"';
                    ToolTip = 'Especifica el horario laboral';
                }
                field("Working center"; Rec."Working center")
                {
                    ApplicationArea = All;
                    Caption = 'Working center', Comment = 'ESP="Centro trabajo"';
                    ToolTip = 'Especifica el centro trabajo';
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                    Caption = 'Duration', Comment = 'ESP="Duración"';
                    ToolTip = 'Especifica la duración';
                }
                field("Trial period formula"; Rec."Trial period formula")
                {
                    ApplicationArea = All;
                    Caption = 'Trial period formula', Comment = 'ESP="Vencimiento periodo prueba"';
                    ToolTip = 'Especifica el vencimiento periodo prueba';
                }
                field("Trial period due date"; Rec."Trial period due date")
                {
                    ApplicationArea = All;
                    Caption = 'Trial period due date', Comment = 'ESP="Fecha venc. per. prueba"';
                    ToolTip = 'Especifica la fecha venc. per. prueba';
                }
                field("Due date"; Rec."Due date")
                {
                    ApplicationArea = All;
                    Caption = 'Due date', Comment = 'ESP="Fecha vencimiento"';
                    ToolTip = 'Especifica la fecha vencimiento';
                }
                field("Expiration date"; Rec."Expiration date")
                {
                    ApplicationArea = All;
                    Caption = 'Expiration date', Comment = 'ESP="Fecha baja"';
                    ToolTip = 'Especifica la fecha baja';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = All;
                    Caption = 'Grounds for Term. Code', Comment = 'ESP="Cód. motivo terminación"';
                    ToolTip = 'Especifica el cód. motivo terminación';
                }
            }
        }
    }
}