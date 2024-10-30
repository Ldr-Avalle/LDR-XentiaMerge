pageextension 50005 "Customer Card_LDR" extends "Customer Card"
{
    //todo:todo lo relacionado con las visibilidades de los campos no lo he puesto porque en teoria no se necesita
    layout
    {

        addlast(General)
        {
            field("Excluir del 347_LDR"; Rec."Excluir del 347")
            {
                ApplicationArea = All;
            }
            group(facturae_LDR)
            {
                Caption = 'Facturae';
                field("Facturae allowed_LDR"; Rec."Facturae allowed")
                {
                    ApplicationArea = All;
                }
                field("Facturae Type_LDR"; Rec."Facturae Type")
                {
                    ApplicationArea = All;
                }
                field("Customer Type_LDR"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                }
                field("Accounting office_LDR"; Rec."Accounting office")
                {
                    ApplicationArea = All;
                }
                field("Management agency_LDR"; Rec."Management agency")
                {
                    ApplicationArea = All;
                }
                field("Transaction unit_LDR"; Rec."Transaction unit")
                {
                    ApplicationArea = All;
                }
            }

        }

    }
    trigger OnOpenPage()
    VAR
        MapMgt: Codeunit "Online Map Management";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    BEGIN
        ActivateFields();
        //todo: no se si se necesita algo de esto
        /*
                CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
                TBAIActivated := TBAIManagement.TBAIActivated;//TBAI_AL_01

                BlockedVisible := TRUE;
        */
    END;

    trigger OnAfterGetRecord()
    VAR
        UserDims: Record "User Dimensions_LDR";
        show: Boolean;
    BEGIN
        ActivateFields();
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
        UserDims: Record "User Dimensions_LDR";
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
        TBAIManagement: Codeunit "Due Date-Adjust";
}
