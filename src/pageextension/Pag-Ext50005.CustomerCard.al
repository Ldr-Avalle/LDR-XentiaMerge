pageextension 50005 "Customer Card" extends "Customer Card"
{
    layout
    {

        addlast(General)
        {
            field("Excluir del 347"; Rec."Excluir del 347")
            {
                ApplicationArea = All;
            }
            group(facturae)
            {
                Caption = 'Facturae';
                field("Facturae allowed"; Rec."Facturae allowed")
                {
                    ApplicationArea = All;
                }
                field("Facturae Type"; Rec."Facturae Type")
                {
                    ApplicationArea = All;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                }
                field("Accounting office"; Rec."Accounting office")
                {
                    ApplicationArea = All;
                }
                field("Management agency"; Rec."Management agency")
                {
                    ApplicationArea = All;
                }
                field("Transaction unit"; Rec."Transaction unit")
                {
                    ApplicationArea = All;
                }
            }

        }

    }
    trigger OnOpenPage()
    VAR
        MapMgt: Codeunit 802;
        CRMIntegrationManagement: Codeunit 5330;
    BEGIN
        ActivateFields;
        //todo: no se si se necesita algo de esto
        /*
                CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
                TBAIActivated := TBAIManagement.TBAIActivated;//TBAI_AL_01

                BlockedVisible := TRUE;
        */
    END;

    trigger OnAfterGetRecord()
    VAR
        UserDims: Record 50000;
        show: Boolean;
    BEGIN
        ActivateFields;
        //todo: no se si se necesita algo de esto
        /*
        gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
        IF NOT gbldimensiones.FINDFIRST THEN
            show := TRUE;
        PaymentMethodCodeVisible := show;
        */
    END;

    trigger OnAfterGetCurrRecord()
    var
        UserDims: Record 50000;
        show: Boolean;
    begin
        //todo: no se si se necesita algo de esto
        /*
        gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
        IF NOT gbldimensiones.FINDFIRST THEN BEGIN
            show := TRUE;
            PaymentMethodCodeVisible := show;
        END;
        */
    end;


    var
        TBAIActivated: Boolean;
        TBAIManagement: Codeunit 10700;
}
