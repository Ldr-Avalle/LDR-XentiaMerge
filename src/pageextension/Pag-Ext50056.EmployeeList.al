pageextension 50056 "Employee List" extends "Employee List"
{
    layout
    {
        addafter("First Family Name")
        {
            field("Work position"; Rec."Work position")
            {
                ApplicationArea = All;
            }
            field(PuestoTrabajo; Rec.PuestoTrabajo)
            {
                ApplicationArea = All;
            }
            field(ProyectoEmpleado; Rec.ProyectoEmpleado)
            {
                ApplicationArea = All;
            }
            field(NSS; Rec.NSS)
            {
                ApplicationArea = All;
            }
            field(FechaVencimientoContrato; Rec.FechaVencimientoContrato)
            {
                ApplicationArea = All;
            }
            field(FechaLastContrato; Rec.FechaLastContrato)
            {
                ApplicationArea = All;
            }
            field(DiasAlta; TraeDiasAlta())
            {
                Caption = 'Dias Alta';
                ApplicationArea = All;
            }
            field("Contract active"; Rec."Contract active")
            {
                ApplicationArea = All;
            }
        }
        addafter("Country/Region Code")
        {
            field(NombreProvinciaProyecto; Rec.NombreProvinciaProyecto)
            {
                ApplicationArea = All;
            }
        }
        addafter("Mobile Phone No.")
        {
            field("Company E-Mail"; Rec."Company E-Mail")
            {
                ApplicationArea = All;
            }
        }
        addafter("E-Mail")
        {
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
            field(County; Rec.County)
            {
                ApplicationArea = All;
            }
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Employment Date"; Rec."Employment Date")
            {
                ApplicationArea = All;
            }
            field(Proyecto; Rec.Proyecto)
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Comment)
        {
            field(Usuario; Rec.Usuario)
            {
                ApplicationArea = All;
            }
        }
        modify("Post Code")
        {
            ApplicationArea = All;
            Visible = true;
        }
    }
    actions
    {
        modify("Co&nfidential Information")
        {
            Visible = gblVisibleInfoConfidencial;
        }
        addafter("Co&nfidential Information")
        {
            action(HistoricoInterno)
            {
                Caption = 'Historico Interno';
                RunObject = Page 50009;
                RunPageLink = "Employee No." = FIELD("No.");
            }
        }
    }
    trigger OnOpenPage()
    begin
        gblVisibleInfoConfidencial := TRUE;
        IF ConfUsuario.GET(USERID) THEN BEGIN
            IF ConfUsuario.VerInfoConfidencial THEN
                gblVisibleInfoConfidencial := FALSE
            ELSE
                gblVisibleInfoConfidencial := TRUE;
        END;
    end;

    trigger OnAfterGetRecord()
    begin
        ContractEmployee.SETRANGE(Employee, rec."No.");
        IF ContractEmployee.FINDLAST THEN
            FechaBajaContrato := ContractEmployee."Expiration date";

    end;

    LOCAL PROCEDURE TraeDiasAlta(): Integer;
    VAR
        regContrato: Record 50004;
    BEGIN
        regContrato.RESET;
        regContrato.SETRANGE(Employee, rec."No.");
        IF regContrato.FINDLAST THEN BEGIN
            IF regContrato."Date of hire" = 0D THEN
                EXIT(0);

            IF regContrato."Expiration date" <> 0D THEN
                EXIT(regContrato."Expiration date" - regContrato."Date of hire" + 1)
            ELSE
                EXIT(TODAY - regContrato."Date of hire" + 1);
        END;
        EXIT(0);
    END;

    VAR
        Project: Code[20];
        FechaBajaContrato: Date;
        ContractEmployee: Record 50004;
        gblVisibleInfoConfidencial: Boolean;
        ConfUsuario: Record 91;

}
