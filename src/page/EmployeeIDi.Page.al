page 50083 "Employee IDi"
{
    ApplicationArea = All;
    Caption = 'Employee IDi', Comment = 'ESP=""';
    PageType = Card;
    SourceTable = "IDI Employee_LDR";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = All;
                    Caption = 'Employee', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    Caption = 'Employment Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = All;
                    Caption = 'Termination Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name', Comment = 'ESP="Nombre"';
                    ToolTip = 'Especifica el nombre';
                }
                field("Second Family Name"; Rec."Second Family Name")
                {
                    ApplicationArea = All;
                    Caption = 'Second Family Name', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("First Family Name"; Rec."First Family Name")
                {
                    ApplicationArea = All;
                    Caption = 'First Family Name', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Horas/IDi present."; Rec."Horas/IDi present.")
                {
                    ApplicationArea = All;
                    Caption = 'Horas/IDi present.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Horas/IDi just."; Rec."Horas/IDi just.")
                {
                    ApplicationArea = All;
                    Caption = 'Horas/IDi just.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Cotization group"; Rec."Cotization group")
                {
                    ApplicationArea = All;
                    Caption = 'Cotization group', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Cost/Hour"; Rec."Cost/Hour")
                {
                    ApplicationArea = All;
                    Caption = 'Cost/Hour', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Visible = CostHourVisible;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if UserId in ['IZERTIS\PMARTIN', 'IZERTIS\CCOSME', 'IZERTIS\LARGUELLES', 'IZERTIS\EGONZALEZ'] then
            CostHourVisible := true
        else
            CostHourVisible := false;
    end;

    var
        CostHourVisible: Boolean;

    procedure Filters(YearF: Text[30]; MonthF: Text[30])
    begin
        Rec.SetFilter(Year, YearF);
        Rec.SetFilter(Month, MonthF);
    end;
}