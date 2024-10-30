pageextension 50055 "Employee Card_LDR" extends "Employee Card"
{
    layout
    {
        addafter("Second Family Name")
        {
            field("Work position_LDR"; Rec."Work position")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(PuestoTrabajo_LDR; Rec.PuestoTrabajo)
            {
                ApplicationArea = All;
            }
        }
        addafter(County)
        {
            field(ProvinciaProyecto_LDR; Rec.ProvinciaProyecto)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }
            field(NombreProvinciaProyecto_LDR; Rec.NombreProvinciaProyecto)
            {
                ApplicationArea = All;
            }
        }
        addafter(Gender)
        {
            field("Contract active_LDR"; Rec."Contract active")
            {
                ApplicationArea = All;
            }
            field("Absence active_LDR"; Rec."Absence active")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code_LDR"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field(Usuario_LDR; Rec.Usuario)
            {
                ApplicationArea = All;
            }
            //todo:se ha sustituido por image y tiene funcionalidad estandar
            /*
            field(Picture_LDR; Rec.Picture)
            {
                ApplicationArea = All;
                trigger OnValidate()
                VAR
                    PictureExists: Boolean;
                    Text001: Label '¿Confirma que desea reemplazar la imagen anterior del %1 %2?';
                BEGIN
                    //nuevo
                    PictureExists := Picture.HASVALUE;
                    IF Picture.IMPORT('*.BMP', TRUE) = '' THEN
                        EXIT;
                    IF PictureExists THEN
                        IF NOT CONFIRM(Text001, FALSE, TABLECAPTION, "No.") THEN
                            EXIT;
                    CurrPage.SAVERECORD;
                END;
            }
            */
        }

        addafter("Union Membership No.")
        {
            field("VAT Registration No._LDR"; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
            }
            group(Contratos_LDR)
            {
                Caption = 'Contratos';
                part(Contract; 50001)
                {
                    ApplicationArea = All;
                    SubPageLink = "No." = field("No.");
                    UpdatePropagation = Both;
                }
            }
            group(Formacion_LDR)
            {
                Caption = 'Formacion';
                part(Formation; 50008)
                {
                    ApplicationArea = All;
                    SubPageLink = "Employee No." = field("No.");
                    UpdatePropagation = Both;
                }
            }
            group(Ausencias_LDR)
            {
                Caption = 'Ausencias';
                part(Absences; 50022)
                {
                    ApplicationArea = All;
                    SubPageLink = "Employee No." = field("No.");
                    UpdatePropagation = Both;
                }
            }
        }
    }
    actions
    {
        modify("&Confidential Information")
        {
            Visible = gblVisibleInfoConfidencial;
        }
        addafter("Co&nfidential Info. Overview")
        {
            action(HistoricoInterno_LDR)
            {
                ApplicationArea = All;
                Caption = 'Histórico Interno';
                RunObject = page 50009;
                RunPageLink = "Employee No." = field("No.");
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
        Rec.SetRange("No.");
    end;

    var
        gblVisibleInfoConfidencial: Boolean;
        ConfUsuario: Record "User Setup";
}
