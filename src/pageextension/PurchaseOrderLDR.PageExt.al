pageextension 50023 "Purchase Order_LDR" extends "Purchase Order"
{
    layout
    {
        addafter("Buy-from Contact")
        {
            field("Posting No. Series_LDR"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {

            field(ShortcutDimCode3_LDR; ShortcutDimCode[3])
            {
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_3;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
            field(ShortcutDimCode4_LDR; ShortcutDimCode[4])
            {
                CaptionClass = '1,2,4';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_4;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                end;
            }
            field(ShortcutDimCode5_LDR; ShortcutDimCode[5])
            {
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_5;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                end;
            }
            field(ShortcutDimCode6_LDR; ShortcutDimCode[6])
            {
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_6;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                end;
            }
            field(ShortcutDimCode7_LDR; ShortcutDimCode[7])
            {
                CaptionClass = '1,2,7';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_7;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                end;
            }
            field(ShortcutDimCode8_LDR; ShortcutDimCode[8])
            {
                CaptionClass = '1,2,8';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_8;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                end;
            }
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
        modify("Order Date")
        {
            ApplicationArea = All;
            Visible = OrderDateVisible;
        }
        modify("Buy-from Contact No.")
        {
            ApplicationArea = All;
            Visible = BuyfromContactNoVisible;
        }
        modify("Quote No.")
        {
            ApplicationArea = All;
            Visible = QuoteNoVisible;
        }
        modify("Vendor Invoice No.")
        {
            ApplicationArea = All;
            Visible = VendorInvoiceNoVisible;
        }
        modify("Order Address Code")
        {
            ApplicationArea = All;
            Visible = OrderAddressCodeVisible;
        }
        modify("Purchaser Code")
        {
            ApplicationArea = All;
            Visible = PurchaserCodeVisible;
        }
        modify("Assigned User ID")
        {
            ApplicationArea = All;
            Editable = false;
        }
        modify("Pay-to Contact No.")
        {
            ApplicationArea = All;
            Visible = PaytoContactNoVisible;
        }
        modify("Pay-to Name")
        {
            ApplicationArea = All;
            Visible = PaytoNameVisible;
        }
        modify("Pay-to Address")
        {
            ApplicationArea = All;
            Visible = PaytoAddressVisible;
        }
        modify("Pay-to Address 2")
        {
            ApplicationArea = All;
            Visible = PaytoAddress2Visible;
        }
        modify("Pay-to Post Code")
        {
            ApplicationArea = All;
            Visible = PaytoPostCodeVisible;
        }
        modify("Pay-to City")
        {
            ApplicationArea = All;
            Visible = PaytoCityVisible;
        }
        modify("Pay-to County")
        {
            ApplicationArea = All;
            Visible = PaytoCountyVisible;
        }
        modify("Pay-to Contact")
        {
            ApplicationArea = All;
            Visible = PaytoContactVisible;
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
        modify("Payment Discount %")
        {
            ApplicationArea = All;
            Visible = PaymentDiscountVisible;
        }
        modify("Pmt. Discount Date")
        {
            ApplicationArea = All;
            Visible = PmtDiscountDateVisible;
        }
        modify("Payment Method Code")
        {
            ApplicationArea = All;
            Visible = PaymentMethodCodeVisible;
        }
        modify("On Hold")
        {
            ApplicationArea = All;
            Visible = OnHoldVisible;
        }
        modify("Prices Including VAT")
        {
            ApplicationArea = All;
            Visible = PricesIncludingVATVisible;
        }
        modify("Ship-to Name")
        {
            ApplicationArea = All;
            Visible = ShiptoNameVisible;
        }
        modify("Ship-to Address")
        {
            ApplicationArea = All;
            Visible = ShiptoAddressVisible;
        }
        modify("Ship-to Address 2")
        {
            ApplicationArea = All;
            Visible = ShiptoAddress2Visible;
        }
        modify("Ship-to Contact")
        {
            ApplicationArea = All;
            Visible = ShiptoContactVisible;
        }
        modify("Ship-to Post Code")
        {
            ApplicationArea = All;
            Visible = ShiptoPostCodeVisible;
        }
        modify("Ship-to City")
        {
            ApplicationArea = All;
            Visible = ShiptoCityVisible;
        }
        modify("Ship-to County")
        {
            ApplicationArea = All;
            Visible = ShiptoCountyVisible;
        }
        modify("Ship-to Country/Region Code")
        {
            ApplicationArea = All;
            Visible = ShiptoCountryRegionCodeVisible;
        }
        modify("Location Code")
        {
            ApplicationArea = All;
            Visible = LocationCodeVisible;
        }
        modify("Inbound Whse. Handling Time")
        {
            ApplicationArea = All;
            Visible = InboundWhseHandlingTimeVisible;
        }
        modify("Shipment Method Code")
        {
            ApplicationArea = All;
            Visible = ShipmentMethodCodeVisible;
        }
        modify("Lead Time Calculation")
        {
            ApplicationArea = All;
            Visible = LeadTimeCalculationVisible;
        }
        modify("Requested Receipt Date")
        {
            ApplicationArea = All;
            Visible = RequestedReceiptDateVisible;
        }
        modify("Promised Receipt Date")
        {
            ApplicationArea = All;
            Visible = PromisedReceiptDateVisible;
        }
        modify("Expected Receipt Date")
        {
            ApplicationArea = All;
            Visible = ExpectedReceiptDateVisible;
        }
        modify("Vendor Bank Acc. Code")
        {
            ApplicationArea = All;
            Visible = VendorBankAccCodeVisible;
        }
        modify("Currency Code")
        {
            ApplicationArea = All;
            Visible = CurrencyCodeVisible;
        }
        modify("Transaction Specification")
        {
            ApplicationArea = All;
            Visible = TransactionSpecificationVisible;
        }
        modify("Transaction Type")
        {
            ApplicationArea = All;
            Visible = TransactionTypeVisible;
        }
        modify("Transport Method")
        {
            ApplicationArea = All;
            Visible = TransportMethodVisible;
        }
        modify("Area")
        {
            ApplicationArea = All;
            Visible = AreaVisible;
        }
        modify("Entry Point")
        {
            ApplicationArea = All;
            Visible = EntryPointVisible;
        }
        modify("Prepayment %")
        {
            ApplicationArea = All;
            Visible = PrepaymentVisible;
        }
        modify("Compress Prepayment")
        {
            ApplicationArea = All;
            Visible = CompressPrepaymentVisible;
        }
        modify("Prepmt. Payment Terms Code")
        {
            ApplicationArea = All;
            Visible = PrepmtPaymentTermsCodeVisible;
        }
        modify("Prepmt. Payment Discount %")
        {
            ApplicationArea = All;
            Visible = PrepmtPaymentDiscountVisible;
        }
        modify("Prepmt. Pmt. Discount Date")
        {
            ApplicationArea = All;
            Visible = PrepmtPmtDiscountDateVisible;
        }
        modify("Vendor Cr. Memo No.")
        {
            ApplicationArea = All;
            Visible = VendorCrMemoNoVisible;
        }
    }

    actions
    {
        modify("In&vt. Put-away/Pick Lines")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify(Approval)
        {
            Visible = false;
        }
        modify(Reopen)
        {
            trigger OnBeforeAction()
            begin
                rec."Vendor Shipment No." := '';
            end;
        }
        modify(CalculateInvoiceDiscount)
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify(CalculateInvoiceDiscount_Promoted)
        {
            Visible = false;
        }
        modify(Post)
        {
            Caption = 'Albaranar';
            trigger OnBeforeAction()
            begin
                ValidateDim;
                rec.TestField("Vendor Shipment No.");
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
                //todo: esto tendría que estar en todos pero como solo lo tienen en post lo dejo así
                //rec.TestField("Vendor Shipment No.");
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
                //rec.TestField("Vendor Shipment No.");
            end;
        }
        modify("Test Report")
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
                //rec.TestField("Vendor Shipment No.");
            end;
        }
        modify("Post &Batch")
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
                //rec.TestField("Vendor Shipment No.");
            end;
        }
    }
    trigger OnAfterGetRecord()
    begin
        rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnAfterGetCurrRecord()
    var
        UserDims: Record 50000;
        show: Boolean;
    begin
        show := NOT UserDims.existsUser(USERID);

        LocationCodeVisible := show;
        BuyfromContactNoVisible := show;
        ShiptoNameVisible := show;
        ShiptoAddress2Visible := show;
        ShiptoAddressVisible := show;
        ShiptoCountyVisible := show;
        ShiptoContactVisible := show;
        ShiptoPostCodeVisible := show;
        ShiptoCityVisible := show;
        ShiptoCountryRegionCodeVisible := show;
        PayatCodeVisible := show;
        CurrencyCodeVisible := show;
        TransactionSpecificationVisible := show;
        TransactionTypeVisible := show;
        TransportMethodVisible := show;
        AreaVisible := show;
        PaymentTermsCodeVisible := show;
        PricesIncludingVATVisible := show;
        DueDateVisible := show;
        PaymentDiscountVisible := show;
        PmtDiscountDateVisible := show;
        VATBusPostingGroupVisible := show;
        ShortcutDimension1CodeVisible := show;
        ShortcutDimension2CodeVisible := show;
        QuoteNoVisible := show;
        OrderAddressCodeVisible := show;
        PurchaserCodeVisible := show;
        OrderDateVisible := show;
        PaytoVendorNoVisible := show;
        PaytoContactNoVisible := show;
        PaytoNameVisible := show;
        PaytoAddressVisible := show;
        PaytoAddress2Visible := show;
        PaytoPostCodeVisible := show;
        PaytoCityVisible := show;
        PaytoCountyVisible := show;
        PaytoContactVisible := show;
        OnHoldVisible := show;
        InboundWhseHandlingTimeVisible := show;
        ShipmentMethodCodeVisible := show;
        LeadTimeCalculationVisible := show;
        RequestedReceiptDateVisible := show;
        PromisedReceiptDateVisible := show;
        ExpectedReceiptDateVisible := show;
        ShiptoCodeVisible := show;
        EntryPointVisible := show;
        VendorBankAccCodeVisible := show;
        PrepaymentVisible := show;
        CompressPrepaymentVisible := show;
        PrepmtPaymentTermsCodeVisible := show;
        PrepaymentDueDateVisible := show;
        PrepmtPaymentDiscountVisible := show;
        PrepmtPmtDiscountDateVisible := show;
        VendorCrMemoNoVisible := show;
        VendorInvoiceNoVisible := show;
        PaymentMethodCodeVisible := show;
        IF UserDims.existsUser(USERID) THEN rec.SETFILTER("Assigned User ID", '%1', USERID);
    end;


    trigger OnOpenPage()
    begin
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

    var
        LocationCodeVisible: Boolean;
        BuyfromContactNoVisible: Boolean;
        ShiptoNameVisible: Boolean;
        ShiptoAddress2Visible: Boolean;
        ShiptoAddressVisible: Boolean;
        ShiptoCountyVisible: Boolean;
        ShiptoCountryRegionCodeVisible: Boolean;
        ShiptoContactVisible: Boolean;
        ShiptoPostCodeVisible: Boolean;
        ShiptoCityVisible: Boolean;
        PayatCodeVisible: Boolean;
        CurrencyCodeVisible: Boolean;
        TransactionSpecificationVisible: Boolean;
        TransactionTypeVisible: Boolean;
        TransportMethodVisible: Boolean;
        AreaVisible: Boolean;
        PricesIncludingVATVisible: Boolean;
        DueDateVisible: Boolean;
        PaymentDiscountVisible: Boolean;
        PmtDiscountDateVisible: Boolean;
        VATBusPostingGroupVisible: Boolean;
        PaymentTermsCodeVisible: Boolean;
        ShortcutDimension1CodeVisible: Boolean;
        ShortcutDimension2CodeVisible: Boolean;
        QuoteNoVisible: Boolean;
        OrderAddressCodeVisible: Boolean;
        PurchaserCodeVisible: Boolean;
        OrderDateVisible: Boolean;
        PaytoVendorNoVisible: Boolean;
        PaytoContactNoVisible: Boolean;
        PaytoNameVisible: Boolean;
        PaytoAddressVisible: Boolean;
        PaytoAddress2Visible: Boolean;
        PaytoPostCodeVisible: Boolean;
        PaytoCityVisible: Boolean;
        PaytoCountyVisible: Boolean;
        PaytoContactVisible: Boolean;
        OnHoldVisible: Boolean;
        InboundWhseHandlingTimeVisible: Boolean;
        ShipmentMethodCodeVisible: Boolean;
        LeadTimeCalculationVisible: Boolean;
        RequestedReceiptDateVisible: Boolean;
        PromisedReceiptDateVisible: Boolean;
        ExpectedReceiptDateVisible: Boolean;
        ShiptoCodeVisible: Boolean;
        EntryPointVisible: Boolean;
        VendorBankAccCodeVisible: Boolean;
        /*
        BizTalkPurchaseOrderVisible: Boolean;
        DateSentVisible: Boolean;
        TimeSentVisible: Boolean;
        VendorQuoteNoVisible: Boolean;
        BizTalkPurchOrderCnfmnVisible: Boolean;
        DateReceivedVisible: Boolean;
        TimeReceivedVisible: Boolean;
        BizTalkPurchaseReceiptVisible: Boolean;
        BizTalkPurchaseInvoiceVisible: Boolean;
        */
        PrepaymentVisible: Boolean;
        CompressPrepaymentVisible: Boolean;
        PrepmtPaymentTermsCodeVisible: Boolean;
        PrepaymentDueDateVisible: Boolean;
        PrepmtPaymentDiscountVisible: Boolean;
        PrepmtPmtDiscountDateVisible: Boolean;
        VendorCrMemoNoVisible: Boolean;
        VendorInvoiceNoVisible: Boolean;
        PaymentMethodCodeVisible: Boolean;
        GeneralLedgerSetup: Record 98;
        Dimension: Record 348;
        //codCli: Code[20];
        //show: Boolean;
        ShortcutDimCode: ARRAY[8] OF Code[20];
        //ShowDim: ARRAY[8] OF Boolean;
        //i: Integer;
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
    //OperationDescription: Text[500];
}
