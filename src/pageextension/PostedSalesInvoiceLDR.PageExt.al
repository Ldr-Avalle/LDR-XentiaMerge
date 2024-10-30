pageextension 50035 "Posted Sales Invoice_LDR" extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("User ID_LDR"; Rec."User ID")
            {
                ApplicationArea = All;
            }
            field("No. Series_LDR"; Rec."No. Series")
            {
                ApplicationArea = All;
            }
            field("Amount Including VAT_LDR"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
        }
        addafter("Succeeded VAT Registration No.")
        {
            field(FacturaFin_LDR; Rec.FacturaFin)
            {
                ApplicationArea = All;
            }
        }
        addafter("EU 3-Party Trade")
        {
            group(Facturae_LDR)
            {
                Caption = 'Facturae';
                field(InvoiceType_LDR; Rec.InvoiceType)
                {
                    ApplicationArea = All;
                }
                field("Start Date_LDR"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date_LDR"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        modify("Bill-to Contact No.")
        {
            ApplicationArea = All;
            Visible = BilltoContactNoVisible;
        }
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
        modify("Payment Terms Code")
        {
            ApplicationArea = All;
            Visible = PaymentTermsCodeVisible;
        }
        modify("Due Date")
        {
            ApplicationArea = All;
            Visible = DueDateVisible;
        }
        modify("Cust. Bank Acc. Code")
        {
            ApplicationArea = All;
            Visible = CustBankAccCodeVisible;
        }
    }
    //todo: todo lo de facturae y más
    /*
    actions
    {
        addafter(FindCorrectiveInvoices)
        {
            action(crearFacturae_LDR)
            {
                Caption = 'Crear Facturae';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    rec.CreateFacturae(FALSE, FALSE);
                end;
            }
            action(crearFacturaeFirmado_LDR)
            {
                Caption = 'Crear Facturae Firmado';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    rec.CreateFacturae(TRUE, FALSE);
                end;
            }
            action(crearFacturaeFirmadoEnviar_LDR)
            {
                Caption = 'Crear Facturae Firmado y Enviar';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    rec.CreateFacturae(TRUE, true);
                end;
            }
            action(crearFacturaeFirmadoEnviarPDF_LDR)
            {
                Caption = 'Crear Facturae Firmado y Enviar';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    rec.CreatePdf(TRUE);
                end;
            }
        }
    }
    */
    trigger OnAfterGetCurrRecord()
    var
        show: Boolean;
        UserDims: Record "User Dimensions_LDR";
    begin
        show := not UserDims.existsUser(UserId);

        BilltoCustomerNoVisible := show;
        BilltoNameVisible := show;
        BilltoAddressVisible := show;
        BilltoAddress2Visible := show;
        BilltoPostCodeVisible := show;
        BilltoCityVisible := show;
        BilltoContactNoVisible := show;
        BilltoContactVisible := show;
        PayatCodeVisible := show;
        CustBankAccCodeVisible := show;
        DueDateVisible := show;
        PaymentTermsCodeVisible := show;
        PricesIncludingVATVisible := show;

        if UserDims.existsUser(UserId) then Rec.SetFilter("User ID", '%1', UserId);
    end;

    var
        BilltoCustomerNoVisible: Boolean;
        BilltoNameVisible: Boolean;
        BilltoAddressVisible: Boolean;
        BilltoAddress2Visible: Boolean;
        BilltoPostCodeVisible: Boolean;
        BilltoCityVisible: Boolean;
        BilltoContactNoVisible: Boolean;
        BilltoContactVisible: Boolean;
        PayatCodeVisible: Boolean;
        CustBankAccCodeVisible: Boolean;
        DueDateVisible: Boolean;
        PaymentTermsCodeVisible: Boolean;
        PricesIncludingVATVisible: Boolean;
    /*
    OperationDescription: Text[500];
    TicketBAI: Codeunit "Due Date-Adjust";
    TBAIActivated: Boolean;
    facturarectificativa: Boolean;
    Factura3odest: Boolean;
    FacturaSimplificadaSustituci: Boolean;
    FacturaSimplificada: Boolean;
    SerieFacturaAnterior_: Text;
    NumFacturaAnterior_: Code[20];
    FechaExpedicionFacturaAnterior_: Text;
    SignatureValueFirmaFacturaAnterior_: Text;
    */
}
