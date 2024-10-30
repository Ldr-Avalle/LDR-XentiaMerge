pageextension 50055 "Employee Card" extends "Employee Card"
{
    layout
    {
        addafter("Second Family Name")
        {
            field("Work position"; Rec."Work position")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(PuestoTrabajo; Rec.PuestoTrabajo)
            {
                ApplicationArea = All;
            }
        }
        addafter(County)
        {
            field(ProvinciaProyecto; Rec.ProvinciaProyecto)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    CurrPage.Update();
                end;
            }
            field(NombreProvinciaProyecto; Rec.NombreProvinciaProyecto)
            {
                ApplicationArea = All;
            }
        }
        addafter(Gender)
        {
            field("Contract active"; Rec."Contract active")
            {
                ApplicationArea = All;
            }
            field("Absence active"; Rec."Absence active")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field(Usuario; Rec.Usuario)
            {
                ApplicationArea = All;
            }
            //todo:se ha sustituido por image y tiene funcionalidad estandar
            /*
            field(Picture; Rec.Picture)
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
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
            }
            group(Contratos)
            {
                Caption = 'Contratos';
                part(Contract; 50001)
                {
                    ApplicationArea = All;
                    SubPageLink = "No." = field("No.");
                    UpdatePropagation = Both;
                }
            }
            group(Formacion)
            {
                Caption = 'Formacion';
                part(Formation; 50008)
                {
                    ApplicationArea = All;
                    SubPageLink = "Employee No." = field("No.");
                    UpdatePropagation = Both;
                }
            }
            group(Ausencias)
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
            action(HistoricoInterno)
            {
                ApplicationArea = All;
                Caption = 'Histórico Interno';
                RunObject = Page 50009;
                RunPageLink = "Employee No." = field("No.");
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
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        rec.SetRange("No.");
    end;

    var
        gblVisibleInfoConfidencial: Boolean;
        ConfUsuario: Record 91;
}
