page 50082 "Job IDi"
{
    ApplicationArea = All;
    Caption = 'Job Card';
    PageType = Card;
    SourceTable = Job;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; Rec."No.")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        Page.RunModal(Page::"Job Card", Rec);
                    end;
                }
                field(Description; Rec.Description)
                {
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat();
                    end;
                }
                field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                {
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                }
                // field("Horas/IDi present."; Rec."Horas/IDi present.") //TODO: FALTA AÑADIR CAMPOS
                // {
                // }
                // field("Coste/IDi present."; Rec."Coste/IDi present.")
                // {
                // }
                field("Person Responsible"; Rec."Person Responsible")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
                // field("Horas/IDi just."; Rec."Horas/IDi just.")//TODO: FALTA AÑADIR CAMPOS
                // {
                // }
                // field("Coste/IDi just."; Rec."Coste/IDi just.")
                // {
                // }
                field("Creation Date"; Rec."Creation Date")
                {
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Ending Date"; Rec."Ending Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                // field("% Completed"; Rec."% Completed")//TODO: FALTA AÑADIR CAMPOS
                // {
                // }
                // field(ExcluyeWIP; Rec.ExcluyeWIP)
                // {
                // }
                // field(Maintenance; Rec.Maintenance)
                // {
                // }
            }
            part(Subform; "Employee IDi")
            {
                //SubPageLink = "Job No." = FIELD("No."), Year = FIELD(Año), Month = FIELD(Mes); //TODO: FALTA AÑADIR CAMPOS
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
                action("Justificar periodo")
                {
                    Caption = 'Justificar periodo';

                    trigger OnAction()
                    var
                        Text0001: Label 'Va a comenzar el proceso de justificaci´Š¢n para el siguiente periodo\  - A´Š¢o %1\  - Mes %2\\´Š¢Desea continuar?';
                        IDi: Record IDI_LDR;
                        Text0002: Label 'Debe seleccionar el periodo a justificar a trav´Š¢s de los FlowFilters.';
                    begin
                        // IF (Rec.GETFILTER(Año) = '') OR (Rec.GETFILTER(Mes) = '') THEN ERROR(Text0002); //TODO: FALTA AÑADIR CAMPOS

                        // IF CONFIRM(Text0001, FALSE, GETFILTER(A´Š¢o), GETFILTER(Mes)) THEN BEGIN
                        //     IDi.SETCURRENTKEY(Proyecto, A´Š¢o, Mes, Employee);
                        //     IDi.SETFILTER(Proyecto, "No.");
                        //     IDi.SETFILTER(A´Š¢o, GETFILTER(A´Š¢o));
                        //     IDi.SETFILTER(Mes, GETFILTER(Mes));
                        //     //FORM.RUN(50080, IDi);
                        //     PAGE.RUN(50080, IDi);
                        // END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //CurrPage.Subform.PAGE.Filters(Rec.GETFILTER(Año), Rec.GETFILTER(Mes));
    end;

    procedure CurrencyCheck()
    begin
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.Update();
    end;
}