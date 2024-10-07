page 50080 IDi
{
    ApplicationArea = All;
    Caption = 'IDi', Comment = 'ESP=""';
    Editable = false;
    PageType = Card;
    SourceTable = IDI_LDR;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Grid)
            {
                field(Actividad; Rec.Actividad)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Hito; Rec.Hito)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Año; Rec.Año)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Mes; Rec.Mes)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Coste/Hora present."; Rec."Coste/Hora present.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("% Dedicación present."; Rec."% Dedicación present.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Horas present."; Rec."Horas present.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Coste horas present."; Rec."Coste horas present.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Coste/Hora just."; Rec."Coste/Hora just.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("% Dedicación just."; Rec."% Dedicación just.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Horas just."; Rec."Horas just.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Coste horas just."; Rec."Coste horas just.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Justification date"; Rec."Justification date")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("First Family Name"; Rec."First Family Name")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Proyecto; Rec.Proyecto)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(Acciones)
            {
                Caption = 'Acciones';
                action("Permitir modificar")
                {
                    Caption = 'Permitir modificar';

                    trigger OnAction()
                    var
                        Text0001: Label 'La acción le permitirá modificar líneas del formulario. ¿Continuar?';
                    begin
                        if Confirm(Text0001) then CurrPage.Editable := true;
                    end;
                }
            }
        }
        area(Processing)
        {
            action(Alternatives)
            {
                Caption = 'Alternatives';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction() //TODO:REVISAR PAGE
                begin
                    //PAGE.RUNMODAL(PAGE::"Employee alternatives IDi", Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        HoraspresentOnFormat();
        CosteHorajustOnFormat();
        HorasjustOnFormat();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Employee := Rec.GetFilter(Employee);
        Rec.Proyecto := Rec.GetFilter(Proyecto);
    end;

    procedure ActivateFields()
    begin
    end;

    local procedure HoraspresentOnFormat()
    var
        IDi: Record IDI_LDR;
        HoursAmount: Decimal;
    begin
        IDi.SetFilter(Año, '%1', Rec.Año);
        IDi.SetFilter(Mes, '%1', Rec.Mes);
        IDi.SetFilter(Employee, '%1', Rec.Employee);
        if IDi.FindFirst() then
            repeat
                HoursAmount += IDi."Horas present.";
            until IDi.Next() = 0;
        if HoursAmount > 150 then;
    end;

    local procedure CosteHorajustOnFormat()
    begin
        if Rec."Coste/Hora just." <> Rec."Coste/Hora present." then;
    end;

    local procedure HorasjustOnFormat()
    var
        IDi: Record IDI_LDR;
        HoursAmount: Decimal;
    begin
        IDi.SetFilter(Año, '%1', Rec.Año);
        IDi.SetFilter(Mes, '%1', Rec.Mes);
        IDi.SetFilter(Employee, '%1', Rec.Employee);
        if IDi.FindFirst() then
            repeat
                HoursAmount += IDi."Horas just.";
            until IDi.Next() = 0;
        if HoursAmount > 150 then;
    end;
}