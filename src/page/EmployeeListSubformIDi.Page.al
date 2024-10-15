page 50081 "Employee List Subform IDi"
{
    ApplicationArea = All;
    Caption = 'Employee List', Comment = 'ESP=""';
    Editable = false;
    PageType = Card;
    SourceTable = Employee;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.', Comment = 'ESP="Nº"';
                    ToolTip = 'Especifica el nº';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Employee: Record Employee;
                    begin
                        Employee.Get(Rec."No.");
                        Page.RunModal(Page::"Employee Card", Employee);
                    end;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    Caption = 'Employment Date', Comment = 'ESP="Fecha contratación"';
                    ToolTip = 'Especifica la fecha contratación';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = All;
                    Caption = 'Termination Date', Comment = 'ESP="Fecha terminación"';
                    ToolTip = 'Especifica la fecha terminación';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        JobF: Record Job;
                    begin
                        JobF.Get(Rec.GetFilter(Job));
                        if (Rec."Termination Date" > JobF."Starting Date") and (Rec."Termination Date" < JobF."Ending Date") then;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name', Comment = 'ESP="Nombre"';
                    ToolTip = 'Especifica el nombre';
                }
                field("First Family Name"; Rec."First Family Name")
                {
                    ApplicationArea = All;
                    Caption = 'First Family Name', Comment = 'ESP="Primer apellido"';
                    ToolTip = 'Especifica el primer apellido';
                }
                field("Second Family Name"; Rec."Second Family Name")
                {
                    ApplicationArea = All;
                    Caption = 'Second Family Name', Comment = 'ESP="Segundo Apellido"';
                    ToolTip = 'Especifica el segundo apellido';
                }
                field("Horas/IDi present."; Rec."Horas/IDi present.")
                {
                    ApplicationArea = All;
                    Caption = 'Horas/IDi present.';
                    ToolTip = 'Especifica las Horas/IDi present.';
                }
                field("Horas/IDi just."; Rec."Horas/IDi just.")
                {
                    ApplicationArea = All;
                    Caption = 'Horas/IDi just.';
                    ToolTip = 'Especifica Horas/IDi just.';
                }
                field("Cotization group"; Rec."Cotization group")
                {
                    ApplicationArea = All;
                    Caption = 'Cotization group', Comment = 'ESP="Grupo Cotización"';
                    ToolTip = 'Especifica el grupo cotización';
                }
                field("Cost/Hour"; Rec."Cost/Hour")
                {
                    ApplicationArea = All;
                    Caption = 'Cost/Hour', Comment = 'ESP="Coste/Horas"';
                    ToolTip = 'Especifica el Coste/Horas';
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

    procedure SetRecord(Employee: Code[20]; YearF: Text[30]; MonthF: Text[30]; Depart: Code[20]; RefCost: Decimal; CostDesv: Decimal; SearchQualif: Boolean)
    var
        Employee2: Record Employee;
        IDi: Record IDI_LDR;
        MiscArtInfo: Record "Misc. Article Information";
        JobSetup: Record "Jobs Setup";
        Hours: Decimal;
        i: Integer;
        MiscArtCodes: array[3] of Code[20];
        MiscArtMatch: Boolean;
    begin
        JobSetup.Get();
        JobSetup.TestField("Max. IDI hours per month");

        if SearchQualif then begin
            i := 1;
            MiscArtInfo.SetFilter("Employee No.", '%1', Employee);
            if MiscArtInfo.FindFirst() then
                repeat
                    MiscArtCodes[i] := MiscArtInfo."Misc. Article Code";
                    i += 1;
                until (MiscArtInfo.Next() = 0) or (i = 3)
            else
                MiscArtInfo.FieldError("Misc. Article Code");
        end;

        Rec.Reset();
        Rec.SetFilter("No.", '<>%1', Employee);
        Rec.SetFilter("Termination Date", '%1', 0D);
        Rec.SetFilter(Year, YearF);
        Rec.SetFilter(Month, MonthF);
        if Depart <> '' then Rec.SetFilter("Bank Acc. No.", '%1', Depart);
        if CostDesv <> 0 then Rec.SetFilter("Cost/Hour", '%1..%2', RefCost * (1 - (CostDesv / 100)), RefCost * (1 + (CostDesv / 100)));

        if Rec.FindFirst() then
            repeat
                Hours := 0;

                IDi.SetFilter(Employee, '%1', Rec."No.");
                IDi.SetFilter(Año, YearF);
                IDi.SetFilter(Mes, MonthF);
                if IDi.FindFirst() then
                    repeat
                        Hours += IDi."Horas present.";
                    until IDi.Next() = 0;

                if SearchQualif then begin
                    i := 1;
                    MiscArtMatch := false;
                    repeat
                        MiscArtInfo.SetFilter("Employee No.", '%1', Rec."No.");
                        MiscArtInfo.SetFilter("Misc. Article Code", '%1', MiscArtCodes[i]);
                        if MiscArtInfo.FindFirst() then MiscArtMatch := true;
                        i += 1;
                    until (MiscArtMatch) or (i = 3) or (MiscArtCodes[i] = '');
                end;

                if (Hours >= JobSetup."Max. IDI hours per month") then
                    Rec.Mark(false)
                else if not ((SearchQualif) and (MiscArtMatch = false)) then
                    Rec.Mark(true)
                else
                    Rec.Mark(false);
            until Rec.Next() = 0;

        Rec.MarkedOnly(true);
    end;

    procedure GetSelectedEmployee() Emp: Code[20]
    begin
        exit(Rec."No.");
    end;
}