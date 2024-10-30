pageextension 50018 "Sales Credit Memo_LDR" extends "Sales Credit Memo"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("Amount Including VAT_LDR"; Rec."Amount Including VAT")
            {
                ApplicationArea = All;
            }
            field("Posting No._LDR"; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Corrected Invoice No.")
        {
            field("Shipping No._LDR"; Rec."Shipping No.")
            {
                ApplicationArea = All;
            }
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
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                            "Dimension Value Type" = const(Standard),
                                                            Blocked = const(false));
                Visible = ShowDim_3;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
            field(ShortcutDimCode4_LDR; ShortcutDimCode[4])
            {
                CaptionClass = '1,2,4';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                            "Dimension Value Type" = const(Standard),
                                                            Blocked = const(false));
                Visible = ShowDim_4;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                end;
            }
            field(ShortcutDimCode5_LDR; ShortcutDimCode[5])
            {
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                            "Dimension Value Type" = const(Standard),
                                                            Blocked = const(false));
                Visible = ShowDim_5;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                end;
            }
            field(ShortcutDimCode6_LDR; ShortcutDimCode[6])
            {
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                            "Dimension Value Type" = const(Standard),
                                                            Blocked = const(false));
                Visible = ShowDim_6;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                end;
            }
            field(ShortcutDimCode7_LDR; ShortcutDimCode[7])
            {
                CaptionClass = '1,2,7';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                            "Dimension Value Type" = const(Standard),
                                                            Blocked = const(false));
                Visible = ShowDim_7;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                end;
            }
            field(ShortcutDimCode8_LDR; ShortcutDimCode[8])
            {
                CaptionClass = '1,2,8';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                            "Dimension Value Type" = const(Standard),
                                                            Blocked = const(false));
                Visible = ShowDim_8;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                end;
            }
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                gbldimensiones.Reset;
                gbldimensiones.SetRange(gbldimensiones.Usuario, UserId);
                if gbldimensiones.FindFirst then begin
                    Rec."Location Code" := gbldimensiones."Location Code";
                    Rec."Shortcut Dimension 1 Code" := gbldimensiones."Segmento Dimension Value";
                    Rec."Shortcut Dimension 2 Code" := gbldimensiones."Unidades Prod  Dimension Value";
                    ShortcutDimCode[3] := gbldimensiones."Project Dimension Value";
                    Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    ShortcutDimCode[4] := gbldimensiones."Provincias Dimension Value";
                    Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    Rec.Modify;
                    CurrPage.Update;
                end;
            end;
        }
        modify("Sell-to Customer No.")
        {
            Caption = 'CIF';
        }
        modify("Sell-to Contact")
        {
            Visible = true;
            ApplicationArea = All;

        }
        modify("External Document No.")
        {
            Visible = ExternalDocumentNoVisible;
            ApplicationArea = All;

        }
        modify("Salesperson Code")
        {
            Visible = SalespersonCodeVisible;
            ApplicationArea = All;
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
            ApplicationArea = All;
        }
        modify("Bill-to Address")
        {
            Visible = BilltoAddressVisible;
            ApplicationArea = All;
        }
        modify("Bill-to Address 2")
        {
            Visible = BilltoAddress2Visible;
            ApplicationArea = All;
        }
        modify("Bill-to Post Code")
        {
            Visible = BilltoPostCodeVisible;
            ApplicationArea = All;
        }
        modify("Bill-to City")
        {
            Visible = BilltoCityVisible;
            ApplicationArea = All;
        }
        modify("Bill-to County")
        {
            Visible = BilltoCountyVisible;
            ApplicationArea = All;
        }
        modify("Bill-to Country/Region Code")
        {
            Visible = BilltoCountryVisible;
            ApplicationArea = All;
        }
        modify("Bill-to Contact No.")
        {
            Visible = BilltoContactVisible;
            ApplicationArea = All;
        }
        modify("Payment Terms Code")
        {
            Visible = PaymentTermsCodeVisible;
            ApplicationArea = All;
        }
        modify("Due Date")
        {
            Visible = DueDateVisible;
            ApplicationArea = All;
        }
        modify("Payment Discount %")
        {
            Visible = PaymentDiscountVisible;
            ApplicationArea = All;
        }
        modify("Pmt. Discount Date")
        {
            Visible = PmtDiscountDateVisible;
            ApplicationArea = All;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = VATBusPostingGroupVisible;
            ApplicationArea = All;
        }
        modify("Location Code")
        {
            Visible = LocationCodeVisible;
            ApplicationArea = All;
        }
        modify("Shipment Date")
        {
            Visible = ShipmentDateVisible;
            ApplicationArea = All;
        }
        modify("Cust. Bank Acc. Code")
        {
            Visible = CustBankAccCodeVisible;
            ApplicationArea = All;
        }
        modify("Currency Code")
        {
            Visible = CurrencyCodeVisible;
            ApplicationArea = All;
        }
        modify("EU 3-Party Trade")
        {
            Visible = EU3PartyTradeVisible;
            ApplicationArea = All;
        }
        modify("Transaction Type")
        {
            Visible = TransactionTypeVisible;
            ApplicationArea = All;
        }
        modify("Transaction Specification")
        {
            Visible = TransactionSpecificationVisible;
            ApplicationArea = All;
        }
        modify("Transport Method")
        {
            Visible = TransportMethodVisible;
            ApplicationArea = All;
        }
        modify("Exit Point")
        {
            Visible = ExitPointVisible;
            ApplicationArea = All;
        }
        modify("Area")
        {
            Visible = AreaVisible;
            ApplicationArea = All;
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
        modify("Applies-to ID")
        {
            Visible = AppliestoIDVisible;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = All;
            Visible = ShowDim_1;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = All;
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
            ApplicationArea = All;
        }
        modify(ApplyEntries)
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify(GetStdCustSalesCodes)
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Move Negative Lines")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify(SendApprovalRequest)
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify(SendApprovalRequest_Promoted)
        {
            Visible = false;
        }
        modify(CancelApprovalRequest)
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify(CancelApprovalRequest_Promoted)
        {
            Visible = false;
        }
        modify(Post)
        {
            Visible = false;
            ApplicationArea = All;
        }
        addafter(Post)
        {
            action(Post_LDR)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Image = PostOrder;
                ShortcutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                    proyecto: Code[10];
                    UserDim: Record "User Dimensions_LDR";
                    PaymentMethod: Record "Payment Method";
                    Text001: Label 'ESP="La forma de pago elegida no es la correcta"';
                begin

                    ValidateDim;

                    proyecto := UserDim.getProjectDim(UserId);
                    if proyecto <> '' then begin
                        PaymentMethod.Get(Rec."Payment Method Code");
                        if PaymentMethod.Project <> proyecto then
                            Message(Text001)

                        else if ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then Codeunit.Run(Codeunit::"Sales-Post (Yes/No)", Rec);
                    end;
                    if proyecto = '' then
                        if ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then Codeunit.Run(Codeunit::"Sales-Post (Yes/No)", Rec);
                end;
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

        GeneralLedgerSetup.Get;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 1 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_1 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 2 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_2 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 3 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_3 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 4 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_4 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 5 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_5 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 6 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_6 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 7 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_7 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 8 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_8 := true;
    end;


    procedure ValidateDim();
    begin
        if (ShowDim_1) and (Rec."Shortcut Dimension 1 Code" = '') then begin
            msg := StrSubstNo(Text50000, 1);
            Error(msg);
        end;

        if (ShowDim_2) and (Rec."Shortcut Dimension 2 Code" = '') then begin
            msg := StrSubstNo(Text50000, 2);
            Error(msg);
        end;

        if (ShowDim_3) and (ShortcutDimCode[3] = '') then begin
            msg := StrSubstNo(Text50000, 3);
            Error(msg);
        end;

        if (ShowDim_4) and (ShortcutDimCode[4] = '') then begin
            msg := StrSubstNo(Text50000, 4);
            Error(msg);
        end;

        if (ShowDim_5) and (ShortcutDimCode[5] = '') then begin
            msg := StrSubstNo(Text50000, 5);
            Error(msg);
        end;
        if (ShowDim_6) and (ShortcutDimCode[6] = '') then begin
            msg := StrSubstNo(Text50000, 6);
            Error(msg);
        end;
        if (ShowDim_7) and (ShortcutDimCode[7] = '') then begin
            msg := StrSubstNo(Text50000, 7);
            Error(msg);
        end;
        if (ShowDim_8) and (ShortcutDimCode[8] = '') then begin
            msg := StrSubstNo(Text50000, 8);
            Error(msg);
        end;
    end;

    local procedure SetVisibildad();
    var
        UserDims: Record "User Dimensions_LDR";
        show: Boolean;
    begin

        show := true;

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

        if UserDims.existsUser(UserId)
           then
            Rec.SetFilter("Assigned User ID", '%1', UserId);
    end;

    procedure PricesIncludingVATOnAfterValid();
    begin
        CurrPage.Update;
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);
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
        GeneralLedgerSetup: Record "General Ledger Setup";
        Dimension: Record Dimension;
        //codCli: Code[20];
        //show: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        //ShowDim: array[8] of Boolean;
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
        gbldimensiones: Record "User Dimensions_LDR";
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
    TBAIManagement: Codeunit "Due Date-Adjust";
    */
}
