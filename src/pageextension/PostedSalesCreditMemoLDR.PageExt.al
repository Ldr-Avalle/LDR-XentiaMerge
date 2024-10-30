pageextension 50037 "Posted Sales Credit Memo_LDR" extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("Corrected Invoice No.")
        {
            field("User ID_LDR"; Rec."User ID")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Contact")
        {
            field("Prices Including VAT_LDR"; Rec."Prices Including VAT")
            {
                ApplicationArea = All;
            }
        }
        /*        
        modify("Bill-to Contact No.")
        {
            ApplicationArea = All;
            Visible = BilltoContactNoVisible;
        }
        */
        modify("Bill-to Contact")
        {
            ApplicationArea = All;
            Visible = BilltoContactVisible;
        }
        modify("Bill-to Name")
        {
            ApplicationArea = All;
            Visible = BilltoNameVisible;
        }
        modify("Bill-to Address")
        {
            ApplicationArea = All;
            Visible = BilltoAddressVisible;
        }
        modify("Bill-to Address 2")
        {
            ApplicationArea = All;
            Visible = BilltoAddress2Visible;
        }
        modify("Bill-to Post Code")
        {
            ApplicationArea = All;
            Visible = BilltoPostCodeVisible;
        }
        modify("Bill-to City")
        {
            ApplicationArea = All;
            Visible = BilltoCityVisible;
        }
        modify("Bill-to County")
        {
            ApplicationArea = All;
            Visible = BilltoContactNoVisible;
        }
        modify("Bill-to Country/Region Code")
        {
            ApplicationArea = All;
            Visible = BilltoContactVisible;
        }
        modify("Applies-to Doc. Type")
        {
            Visible = AppliestoDocTypeVisible;
            ApplicationArea = All;
        }
        modify("Applies-to Doc. No.")
        {
            Visible = AppliestoDocNoVisible;
            ApplicationArea = All;
        }
        modify("Cust. Bank Acc. Code")
        {
            ApplicationArea = All;
            Visible = CustBankAccCodeVisible;
        }

    }
    //todo: en teoria no se usa
    /*
    actions{
        addafter(ActivityLog){
            action(CrearFacturaeFirmado_LDR)
            {
                ApplicationArea = All;
                Caption = 'Crear Facturae Firmado';
                trigger OnAction()
                begin
                    rec.CreateFacturae(TRUE,FALSE);
                end;
              
              
            }
        }
    }
    */
    trigger OnAfterGetCurrRecord()
    var
        UserDims: Record "User Dimensions_LDR";
        show: Boolean;
    begin
        show := not UserDims.existsUser(UserId);
        BilltoCustomerNoVisible := show;
        BilltoNameVisible := show;
        BilltoPostCodeVisible := show;
        BilltoAddressVisible := show;
        BilltoAddress2Visible := show;
        BilltoCityVisible := show;
        BilltoContactVisible := show;
        BilltoCountyVisible := show;
        BilltoContactNoVisible := show;
        PayatCodeVisible := show;
        CustBankAccCodeVisible := show;
        AppliestoDocTypeVisible := show;
        AppliestoDocNoVisible := show;
        if UserDims.existsUser(UserId) then
            Rec.SetFilter("User ID", '%1', UserId);
    end;

    var
        BilltoCustomerNoVisible: Boolean;
        BilltoNameVisible: Boolean;
        BilltoPostCodeVisible: Boolean;
        BilltoAddressVisible: Boolean;
        BilltoAddress2Visible: Boolean;
        BilltoCityVisible: Boolean;
        BilltoContactVisible: Boolean;
        BilltoCountyVisible: Boolean;
        BilltoContactNoVisible: Boolean;
        PayatCodeVisible: Boolean;
        CustBankAccCodeVisible: Boolean;
        AppliestoDocTypeVisible: Boolean;
        AppliestoDocNoVisible: Boolean;
    //OperationDescription: Text[500];
}
