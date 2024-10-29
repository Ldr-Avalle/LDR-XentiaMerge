pageextension 50070 "Purchase Return Order" extends "Purchase Return Order"
{
    layout
    {
        addafter("Job Queue Status")
        {
            field("Return Shipment No."; Rec."Return Shipment No.")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
        }
        modify("Buy-from Contact No.")
        {
            Visible = BuyfromContactNoVisible;
            ApplicationArea = All;
        }
        modify("Buy-from Contact")
        {
            Visible = BuyfromContactVisible;
            ApplicationArea = All;
        }
        modify("No. of Archived Versions")
        {
            Visible = NoofArchivedVersionsVisible;
            ApplicationArea = All;
        }
        modify("Order Date")
        {
            Visible = OrderDateVisible;
        }
        modify("Vendor Cr. Memo No.")
        {
            Visible = VendorCrMemoNoVisible;
            ApplicationArea = All;
        }
        modify("Order Address Code")
        {
            Visible = OrderAddressCodeVisible;
            ApplicationArea = All;
        }
        modify("Purchaser Code")
        {
            Visible = PurchaserCodeVisible;
            ApplicationArea = All;
        }
        modify("Assigned User ID")
        {
            Editable = FALSE;
            ApplicationArea = All;
        }
        modify("Pay-to Contact No.")
        {
            ApplicationArea = All;
            Visible = PaytoContactnoVisible;
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
        modify("Pay-to Country/Region Code")
        {
            ApplicationArea = All;
            Visible = PaytoCountryVisible;
        }
        modify("Pay-to Contact")
        {
            ApplicationArea = All;
            Visible = PaytoContactVisible;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = ShortcutDimension1CodeVisible;
            ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = ShortcutDimension2CodeVisible;
            ApplicationArea = All;
        }
        modify("Payment Discount %")
        {
            Visible = PaymentDiscountVisible;
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
        modify("Prices Including VAT")
        {
            Visible = PricesIncludingVATVisible;
            ApplicationArea = All;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = VATBusPostingGroupVisible;
            ApplicationArea = All;
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
        modify("Expected Receipt Date")
        {
            ApplicationArea = All;
            Visible = ExpectedReceiptDateVisible;
        }
        modify("Currency Code")
        {
            ApplicationArea = All;
            Visible = CurrencyCodeVisible;
        }
        modify("Transaction Type")
        {
            ApplicationArea = All;
            Visible = TransactionTypeVisible;
        }
        modify("Transaction Specification")
        {
            ApplicationArea = All;
            Visible = TransactionSpecificationVisible;
        }
        modify("Transport Method")
        {
            ApplicationArea = All;
            Visible = TransportMethodVisible;
        }
        modify("Entry Point")
        {
            ApplicationArea = All;
            Visible = EntryPointVisible;
        }
        modify("Area")
        {
            ApplicationArea = All;
            Visible = AreaVisible;
        }
    }
    actions
    {
        modify("&Return Order")
        {
            Visible = DevolucionVisible;
        }
        modify("&Print")
        {
            Visible = ImprimirVisible;
            ApplicationArea = All;
        }
        modify("F&unctions")
        {
            Visible = AccionesVisible;
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        userDims: Record 50000;
        Show: Boolean;
    begin
        UpdateInfoPanel;
        Show := NOT userDims.existsUser(USERID);

        NoofArchivedVersionsVisible := Show;
        LocationCodeVisible := Show;
        BuyfromContactNoVisible := Show;
        BuyfromContactVisible := Show;
        ShiptoNameVisible := Show;
        ShiptoAddressVisible := Show;
        ShiptoAddress2Visible := Show;
        ExpectedReceiptDateVisible := Show;
        ShiptoCityVisible := Show;
        ShiptoCountyVisible := Show;
        ShiptoCountryRegionCodeVisible := Show;
        ShiptoContactVisible := Show;
        ShiptoPostCodeVisible := Show;
        CurrencyCodeVisible := Show;
        TransactionTypeVisible := Show;
        TransactionSpecificationVisible := Show;
        TransportMethodVisible := Show;
        AreaVisible := Show;
        PricesIncludingVATVisible := Show;
        PaymentDiscountVisible := Show;
        VATBusPostingGroupVisible := Show;
        ShortcutDimension1CodeVisible := Show;
        ShortcutDimension2CodeVisible := Show;
        OrderAddressCodeVisible := Show;
        PurchaserCodeVisible := Show;
        OrderDateVisible := Show;
        PaytoVendorNoVisible := Show;
        PaytoContactNoVisible := Show;
        PaytoNameVisible := Show;
        PaytoAddressVisible := Show;
        PaytoAddress2Visible := Show;
        PaytoPostCodeVisible := Show;
        PaytoCityVisible := Show;
        PaytoCountyVisible := Show;
        PaytoCountryVisible := Show;
        PaytoContactVisible := Show;
        AppliestoDocTypeVisible := Show;
        AppliestoDocNoVisible := Show;
        AppliestoIDVisible := Show;
        DocumentDateVisible := Show;
        EntryPointVisible := Show;
        VendorCrMemoNoVisible := Show;
    end;

    PROCEDURE UpdateInfoPanel();
    VAR
        UserDims: Record 50000;
        show: Boolean;
    BEGIN
        show := NOT UserDims.existsUser(USERID);

        DevolucionVisible := show;
        AccionesVisible := show;
        ImprimirVisible := show;
    END;

    var
        NoofArchivedVersionsVisible: Boolean;
        LocationCodeVisible: Boolean;
        BuyfromContactNoVisible: Boolean;
        BuyfromContactVisible: Boolean;
        ShiptoNameVisible: Boolean;
        ShiptoAddressVisible: Boolean;
        ShiptoAddress2Visible: Boolean;
        ExpectedReceiptDateVisible: Boolean;
        ShiptoCityVisible: Boolean;
        ShiptoContactVisible: Boolean;
        ShiptoPostCodeVisible: Boolean;
        ShiptoCountyVisible: Boolean;
        ShiptoCountryRegionCodeVisible: Boolean;
        CurrencyCodeVisible: Boolean;
        TransactionTypeVisible: Boolean;
        TransactionSpecificationVisible: Boolean;
        TransportMethodVisible: Boolean;
        AreaVisible: Boolean;
        PricesIncludingVATVisible: Boolean;
        PaymentDiscountVisible: Boolean;
        VATBusPostingGroupVisible: Boolean;
        ShortcutDimension1CodeVisible: Boolean;
        ShortcutDimension2CodeVisible: Boolean;
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
        PaytoCountryVisible: Boolean;
        PaytoContactVisible: Boolean;
        AppliestoDocTypeVisible: Boolean;
        AppliestoDocNoVisible: Boolean;
        AppliestoIDVisible: Boolean;
        DocumentDateVisible: Boolean;
        EntryPointVisible: Boolean;
        VendorCrMemoNoVisible: Boolean;
        DevolucionVisible: Boolean;
        AccionesVisible: Boolean;
        ImprimirVisible: Boolean;
        OperationDescription: Text[500];
}

