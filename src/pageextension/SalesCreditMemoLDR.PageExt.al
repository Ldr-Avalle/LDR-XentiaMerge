pageextension 50018 "Sales Credit Memo" extends "Sales Credit Memo"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = all;
            }
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = all;
            }
        }
        addafter("Corrected Invoice No.")
        {
            field("Shipping No."; Rec."Shipping No.")
            {
                ApplicationArea = all;
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = all;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {

            field(ShortcutDimCode3; ShortcutDimCode[3])
            {
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_3;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
            field(ShortcutDimCode4; ShortcutDimCode[4])
            {
                CaptionClass = '1,2,4';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_4;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                end;
            }
            field(ShortcutDimCode5; ShortcutDimCode[5])
            {
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_5;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                end;
            }
            field(ShortcutDimCode6; ShortcutDimCode[6])
            {
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_6;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                end;
            }
            field(ShortcutDimCode7; ShortcutDimCode[7])
            {
                CaptionClass = '1,2,7';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_7;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                end;
            }
            field(ShortcutDimCode8; ShortcutDimCode[8])
            {
                CaptionClass = '1,2,8';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_8;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                end;
            }
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                gbldimensiones.RESET;
                gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
                IF gbldimensiones.FINDFIRST THEN BEGIN
                    Rec."Location Code" := gbldimensiones."Location Code";
                    Rec."Shortcut Dimension 1 Code" := gbldimensiones."Segmento Dimension Value";
                    Rec."Shortcut Dimension 2 Code" := gbldimensiones."Unidades Prod  Dimension Value";
                    ShortcutDimCode[3] := gbldimensiones."Project Dimension Value";
                    rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    ShortcutDimCode[4] := gbldimensiones."Provincias Dimension Value";
                    rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    rec.MODIFY;
                    CurrPage.UPDATE;
                END;
            end;
        }
        modify("Sell-to Customer No.")
        {
            Caption = 'CIF';
        }
        modify("Sell-to Contact")
        {
            Visible = true;
            ApplicationArea = all;

        }
        modify("External Document No.")
        {
            Visible = ExternalDocumentNoVisible;
            ApplicationArea = all;

        }
        modify("Salesperson Code")
        {
            Visible = SalespersonCodeVisible;
            ApplicationArea = all;
        }
        modify("Prices Including VAT")
        {
            trigger OnAfterValidate()
            begin
                PricesIncludingVATOnAfterValid;
            end;
        }


        modify("Bill-to Name")
        {
            Visible = BilltoNameVisible;
            ApplicationArea = all;
        }
        modify("Bill-to Address")
        {
            Visible = BilltoAddressVisible;
            ApplicationArea = all;
        }
        modify("Bill-to Address 2")
        {
            Visible = BilltoAddress2Visible;
            ApplicationArea = all;
        }
        modify("Bill-to Post Code")
        {
            Visible = BilltoPostCodeVisible;
            ApplicationArea = all;
        }
        modify("Bill-to City")
        {
            Visible = BilltoCityVisible;
            ApplicationArea = all;
        }
        modify("Bill-to County")
        {
            Visible = BilltoCountyVisible;
            ApplicationArea = all;
        }
        modify("Bill-to Country/Region Code")
        {
            Visible = BilltoCountryVisible;
            ApplicationArea = all;
        }
        modify("Bill-to Contact No.")
        {
            Visible = BilltoContactVisible;
            ApplicationArea = all;
        }
        modify("Payment Terms Code")
        {
            Visible = PaymentTermsCodeVisible;
            ApplicationArea = all;
        }
        modify("Due Date")
        {
            Visible = DueDateVisible;
            ApplicationArea = all;
        }
        modify("Payment Discount %")
        {
            Visible = PaymentDiscountVisible;
            ApplicationArea = all;
        }
        modify("Pmt. Discount Date")
        {
            Visible = PmtDiscountDateVisible;
            ApplicationArea = all;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = VATBusPostingGroupVisible;
            ApplicationArea = all;
        }
        modify("Location Code")
        {
            Visible = LocationCodeVisible;
            ApplicationArea = all;
        }
        modify("Shipment Date")
        {
            Visible = ShipmentDateVisible;
            ApplicationArea = all;
        }
        modify("Cust. Bank Acc. Code")
        {
            Visible = CustBankAccCodeVisible;
            ApplicationArea = all;
        }
        modify("Currency Code")
        {
            Visible = CurrencyCodeVisible;
            ApplicationArea = all;
        }
        modify("EU 3-Party Trade")
        {
            Visible = EU3PartyTradeVisible;
            ApplicationArea = all;
        }
        modify("Transaction Type")
        {
            Visible = TransactionTypeVisible;
            ApplicationArea = all;
        }
        modify("Transaction Specification")
        {
            Visible = TransactionSpecificationVisible;
            ApplicationArea = all;
        }
        modify("Transport Method")
        {
            Visible = TransportMethodVisible;
            ApplicationArea = all;
        }
        modify("Exit Point")
        {
            Visible = ExitPointVisible;
            ApplicationArea = all;
        }
        modify("Area")
        {
            Visible = AreaVisible;
            ApplicationArea = all;
        }
        modify("Applies-to Doc. Type")
        {
            Visible = AppliesToDocTypeVisible;
            ApplicationArea = all;
        }
        modify("Applies-to Doc. No.")
        {
            Visible = AppliesToDocNoVisible;
            ApplicationArea = all;
        }
        modify("Applies-to ID")
        {
            Visible = AppliesToIDVisible;
            ApplicationArea = all;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = all;
            Visible = ShowDim_1;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = all;
            Visible = ShowDim_2;

        }
    }
    actions
    {
        modify("Credit Memo")
        {
            Visible = AbonoVisible;

        }
        modify("F&unctions")
        {
            Visible = AccionesVisible;

        }
        modify(CalculateInvoiceDiscount)
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify(ApplyEntries)
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify(GetStdCustSalesCodes)
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify("Move Negative Lines")
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify(SendApprovalRequest)
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify(SendApprovalRequest_Promoted)
        {
            Visible = false;
        }
        modify(CancelApprovalRequest)
        {
            Visible = false;
            ApplicationArea = all;
        }
        modify(CancelApprovalRequest_Promoted)
        {
            Visible = false;
        }
        modify(Post)
        {
            Visible = false;
            ApplicationArea = all;
        }
        addafter(Post)
        {
            action(Post_LDR)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Image = PostOrder;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                VAR
                    PurchaseHeader: Record 38;
                    ApprovalMgt: Codeunit 1535;
                    proyecto: Code[10];
                    UserDim: Record 50000;
                    PaymentMethod: Record 289;
                    Text001: Label 'ESP="La forma de pago elegida no es la correcta"';
                BEGIN

                    ValidateDim;

                    proyecto := UserDim.getProjectDim(USERID);
                    IF proyecto <> '' THEN BEGIN
                        PaymentMethod.GET(rec."Payment Method Code");
                        IF PaymentMethod.Project <> proyecto THEN
                            MESSAGE(Text001)

                        ELSE IF ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) THEN CODEUNIT.RUN(CODEUNIT::"Sales-Post (Yes/No)", Rec);
                    END;
                    IF proyecto = '' THEN
                        IF ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) THEN CODEUNIT.RUN(CODEUNIT::"Sales-Post (Yes/No)", Rec);
                END;
            }
        }
        modify(TestReport)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
            end;
        }
    }

    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    begin
        SetVisibildad();

        GeneralLedgerSetup.GET;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 1 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_1 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 2 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_2 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 3 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_3 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 4 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_4 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 5 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_5 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 6 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_6 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 7 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_7 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 8 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_8 := TRUE;
    end;


    PROCEDURE ValidateDim();
    BEGIN
        IF (ShowDim_1) AND (rec."Shortcut Dimension 1 Code" = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 1);
            ERROR(msg);
        END;

        IF (ShowDim_2) AND (rec."Shortcut Dimension 2 Code" = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 2);
            ERROR(msg);
        END;

        IF (ShowDim_3) AND (ShortcutDimCode[3] = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 3);
            ERROR(msg);
        END;

        IF (ShowDim_4) AND (ShortcutDimCode[4] = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 4);
            ERROR(msg);
        END;

        IF (ShowDim_5) AND (ShortcutDimCode[5] = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 5);
            ERROR(msg);
        END;
        IF (ShowDim_6) AND (ShortcutDimCode[6] = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 6);
            ERROR(msg);
        END;
        IF (ShowDim_7) AND (ShortcutDimCode[7] = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 7);
            ERROR(msg);
        END;
        IF (ShowDim_8) AND (ShortcutDimCode[8] = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 8);
            ERROR(msg);
        END;
    END;

    LOCAL PROCEDURE SetVisibildad();
    VAR
        UserDims: Record 50000;
        show: Boolean;
    BEGIN

        show := TRUE;

        ExternalDocumentNoVisible := show;
        SalespersonCodeVisible := show;
        LocationCodeVisible := show;
        AppliestoIDVisible := show;
        BilltoCustomerNoVisible := show;
        BilltoContactVisible := show;
        ShiptoNameVisible := show;
        BilltoNameVisible := show;
        BilltoCountryVisible := show;
        ShiptoAddress2Visible := show;
        BilltoAddress2Visible := show;
        ShiptoAddressVisible := show;
        BilltoAddressVisible := show;
        ShiptoCountyVisible := show;
        BilltoCountyVisible := show;
        ShiptoContactVisible := show;
        ShipmentDateVisible := show;
        AppliestoDocTypeVisible := show;
        AppliestoDocNoVisible := show;
        ShiptoPostCodeVisible := show;
        BilltoPostCodeVisible := show;
        ShiptoCityVisible := show;
        BilltoCityVisible := show;
        PayatCodeVisible := show;
        CustBankAccCodeVisible := show;
        CurrencyCodeVisible := show;
        EU3PartyTradeVisible := show;
        TransactionSpecificationVisible := show;
        TransactionTypeVisible := show;
        TransportMethodVisible := show;
        ExitPointVisible := show;
        AreaVisible := show;
        PaymentTermsCodeVisible := show;
        DueDateVisible := show;
        PaymentDiscountVisible := show;
        PmtDiscountDateVisible := show;
        VATBusPostingGroupVisible := show;
        ShortcutDimension1CodeVisible := show;
        ShortcutDimension2CodeVisible := show;
        AbonoVisible := show;
        AccionesVisible := show;

        IF UserDims.existsUser(USERID)
           THEN
            rec.SETFILTER("Assigned User ID", '%1', USERID);
    END;

    PROCEDURE PricesIncludingVATOnAfterValid();
    BEGIN
        CurrPage.UPDATE;
    END;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions(rec."Dimension Set ID", ShortcutDimCode);
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        ExternalDocumentNoVisible: Boolean;
        SalespersonCodeVisible: Boolean;
        LocationCodeVisible: Boolean;
        AppliestoIDVisible: Boolean;
        BilltoCustomerNoVisible: Boolean;
        BilltoContactVisible: Boolean;
        ShiptoNameVisible: Boolean;
        BilltoNameVisible: Boolean;
        ShiptoAddress2Visible: Boolean;
        BilltoAddress2Visible: Boolean;
        ShiptoAddressVisible: Boolean;
        BilltoAddressVisible: Boolean;
        ShiptoCountyVisible: Boolean;
        BilltoCountyVisible: Boolean;
        BilltoCountryVisible: Boolean;
        ShiptoContactVisible: Boolean;
        ShipmentDateVisible: Boolean;
        AppliestoDocTypeVisible: Boolean;
        AppliestoDocNoVisible: Boolean;
        ShiptoPostCodeVisible: Boolean;
        BilltoPostCodeVisible: Boolean;
        ShiptoCityVisible: Boolean;
        BilltoCityVisible: Boolean;
        PayatCodeVisible: Boolean;
        CustBankAccCodeVisible: Boolean;
        CurrencyCodeVisible: Boolean;
        EU3PartyTradeVisible: Boolean;
        TransactionSpecificationVisible: Boolean;
        TransactionTypeVisible: Boolean;
        TransportMethodVisible: Boolean;
        ExitPointVisible: Boolean;
        AreaVisible: Boolean;
        PaymentTermsCodeVisible: Boolean;
        DueDateVisible: Boolean;
        PaymentDiscountVisible: Boolean;
        PmtDiscountDateVisible: Boolean;
        VATBusPostingGroupVisible: Boolean;
        ShortcutDimension1CodeVisible: Boolean;
        ShortcutDimension2CodeVisible: Boolean;
        AbonoVisible: Boolean;
        AccionesVisible: Boolean;
        GeneralLedgerSetup: Record 98;
        Dimension: Record 348;
        codCli: Code[20];
        show: Boolean;
        ShortcutDimCode: ARRAY[8] OF Code[20];
        ShowDim: ARRAY[8] OF Boolean;
        i: Integer;
        ShowDim_1: Boolean;
        ShowDim_2: Boolean;
        ShowDim_3: Boolean;
        ShowDim_4: Boolean;
        ShowDim_5: Boolean;
        ShowDim_6: Boolean;
        ShowDim_7: Boolean;
        ShowDim_8: Boolean;
        msg: Text;
        Text50000: Label 'El valor de la dimension %1 no puede estar vacio';
        gbldimensiones: Record 50000;
        OperationDescription: Text[500];
        TicketBAI: Codeunit 10700;
        TBAIActivated: Boolean;
        facturarectificativa: Boolean;
        Factura3odest: Boolean;
        FacturaSimplificadaSustituci: Boolean;
        FacturaSimplificada: Boolean;
        SerieFacturaAnterior_: Text;
        NumFacturaAnterior_: Code[20];
        FechaExpedicionFacturaAnterior_: Text;
        SignatureValueFirmaFacturaAnterior_: Text;
        TBAIManagement: Codeunit 10700;
}
