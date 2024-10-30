pageextension 50056 "Employee List_LDR" extends "Employee List"
{
    layout
    {
        addafter("First Family Name")
        {
            field("Work position_LDR"; Rec."Work position")
            {
                ApplicationArea = All;
            }
            field(PuestoTrabajo_LDR; Rec.PuestoTrabajo)
            {
                ApplicationArea = All;
            }
            field(ProyectoEmpleado_LDR; Rec.ProyectoEmpleado)
            {
                ApplicationArea = All;
            }
            field(NSS_LDR; Rec.NSS)
            {
                ApplicationArea = All;
            }
            field(FechaVencimientoContrato_LDR; Rec.FechaVencimientoContrato)
            {
                ApplicationArea = All;
            }
            field(FechaLastContrato_LDR; Rec.FechaLastContrato)
            {
                ApplicationArea = All;
            }
            field(DiasAlta_LDR; TraeDiasAlta())
            {
                Caption = 'Dias Alta';
                ApplicationArea = All;
            }
            field("Contract active_LDR"; Rec."Contract active")
            {
                ApplicationArea = All;
            }
        }
        addafter("Country/Region Code")
        {
            field(NombreProvinciaProyecto_LDR; Rec.NombreProvinciaProyecto)
            {
                ApplicationArea = All;
            }
        }
        addafter("Mobile Phone No.")
        {
            field("Company E-Mail_LDR"; Rec."Company E-Mail")
            {
                ApplicationArea = All;
            }
        }
        addafter("E-Mail")
        {
            field(City_LDR; Rec.City)
            {
                ApplicationArea = All;
            }
            field(County_LDR; Rec.County)
            {
                ApplicationArea = All;
            }
            field(Address_LDR; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Employment Date_LDR"; Rec."Employment Date")
            {
                ApplicationArea = All;
            }
            field(Proyecto_LDR; Rec.Proyecto)
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code_LDR"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code_LDR"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Comment)
        {
            field(Usuario_LDR; Rec.Usuario)
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
            action(HistoricoInterno_LDR)
            {
                Caption = 'Historico Interno';
                RunObject = page "Employee internal historic";
                RunPageLink = "Employee No." = field("No.");
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    begin
        gblVisibleInfoConfidencial := true;
        if ConfUsuario.Get(UserId) then
            if ConfUsuario.VerInfoConfidencial then
                gblVisibleInfoConfidencial := false
            else
                gblVisibleInfoConfidencial := true;
    end;

    trigger OnAfterGetRecord()
    begin
        ContractEmployee.SetRange(Employee, Rec."No.");
        if ContractEmployee.FindLast() then
            FechaBajaContrato := ContractEmployee."Expiration date";

    end;

    local procedure TraeDiasAlta(): Integer;
    var
        regContrato: Record "Employee Contract";
    begin
        regContrato.Reset();
        regContrato.SetRange(Employee, Rec."No.");
        if regContrato.FindLast() then begin
            if regContrato."Date of hire" = 0D then
                exit(0);

            if regContrato."Expiration date" <> 0D then
                exit(regContrato."Expiration date" - regContrato."Date of hire" + 1)
            else
                exit(Today - regContrato."Date of hire" + 1);
        end;
        exit(0);
    end;

    var
        //Project: Code[20];
        FechaBajaContrato: Date;
        ContractEmployee: Record "Employee Contract";
        gblVisibleInfoConfidencial: Boolean;
        ConfUsuario: Record "User Setup";

}
