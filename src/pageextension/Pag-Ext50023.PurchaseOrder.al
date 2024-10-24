/*
pageextension 50023 "Purchase Order" extends "Purchase Order"
{
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

}
*/