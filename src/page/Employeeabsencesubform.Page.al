page 50022 "Employee absence subform."
{
    ApplicationArea = All;
    Caption = 'Subform. Registro ausencias';
    PageType = CardPart;
    SourceTable = "Employee Absence";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Entry No.', Comment = 'ESP="Nº mov."';
                    ToolTip = 'Especifica el nº mov.';
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    Caption = 'From Date', Comment = 'ESP="Desde fecha"';
                    ToolTip = 'Especifica desde fecha';
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                    Caption = 'To Date', Comment = 'ESP="Hasta fecha"';
                    ToolTip = 'Especifica hasta fecha';
                }
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {
                    ApplicationArea = All;
                    Caption = 'Cause of Absence Code', Comment = 'ESP="Cód. causa ausencia"';
                    ToolTip = 'Especifica el cód. causa ausencia';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Comment = 'ESP="Descripción"';
                    ToolTip = 'Especifica la descripción';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity', Comment = 'ESP="Cantidad"';
                    ToolTip = 'Especifica la cantidad';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comment', Comment = 'ESP="Comentario"';
                    ToolTip = 'Especific el comentario';
                }
            }
        }
    }
}