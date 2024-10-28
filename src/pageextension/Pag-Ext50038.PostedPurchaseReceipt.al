pageextension 50038 "Posted Purchase Receipt" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("No. Printed")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Responsibility Center")
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
        }
        modify("Buy-from Contact No.")
        {
            ApplicationArea = All;
            Visible = BuyfromContactNoVisible;
        }
        modify("Buy-from Contact")
        {
            ApplicationArea = All;
            Visible = BuyfromContactVisible;
            Caption = 'CIF CLiente Empresa';
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
        modify("Quote No.")
        {
            ApplicationArea = All;
            Visible = QuoteNoVisible;
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
        modify("Pay-to Vendor No.")
        {
            ApplicationArea = All;
            Visible = PaytoVendorNoVisible;
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
            ApplicationArea = All;
            Visible = ShortcutDimension1CodeVisible;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = All;
            Visible = ShortcutDimension2CodeVisible;
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
            Visible = ShiptoCountryVisible;
        }
        modify("Ship-to Contact")
        {
            ApplicationArea = All;
            Visible = ShiptoContactVisible;
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
    }
    trigger OnAfterGetCurrRecord()
    VAR
        show: Boolean;
        UserDims: Record 50000;
    BEGIN
        show := NOT UserDims.existsUser(USERID);

        LocationCodeVisible := show;
        BuyfromContactNoVisible := show;
        BuyfromContactVisible := show;
        ShiptoNameVisible := show;
        ShiptoAddressVisible := show;
        ShiptoAddress2Visible := show;
        ShiptoCountyVisible := show;
        ShiptoContactVisible := show;
        ShiptoPostCodeVisible := show;
        ShiptoCityVisible := show;
        ShiptoCountryVisible := show;
        PayatCodeVisible := show;
        ShortcutDimension1CodeVisible := show;
        ShortcutDimension2CodeVisible := show;
        QuoteNoVisible := show;
        OrderAddressCodeVisible := show;
        PurchaserCodeVisible := show;
        PaytoVendorNoVisible := show;
        PaytoContactnoVisible := show;
        PaytoNameVisible := show;
        PaytoAddressVisible := show;
        PaytoAddress2Visible := show;
        PaytoPostCodeVisible := show;
        PaytoCityVisible := show;
        PaytoCountyVisible := show;
        PaytoCountryVisible := show;
        PaytoContactVisible := show;
        InboundWhseHandlingTimeVisible := show;
        ShipmentMethodCodeVisible := show;
        LeadTimeCalculationVisible := show;
        RequestedReceiptDateVisible := show;
        PromisedReceiptDateVisible := show;
        ExpectedReceiptDateVisible := show;
        VendorBankAccCodeVisible := show;

        IF UserDims.existsUser(USERID) THEN rec.SETFILTER("User ID", '%1', USERID);
    END;

    var
        LocationCodeVisible: Boolean;
        BuyfromContactNoVisible: Boolean;
        BuyfromContactVisible: Boolean;
        ShiptoNameVisible: Boolean;
        ShiptoAddressVisible: Boolean;
        ShiptoAddress2Visible: Boolean;
        ShiptoCountyVisible: Boolean;
        ShiptoCountryVisible: Boolean;
        ShiptoContactVisible: Boolean;
        ShiptoPostCodeVisible: Boolean;
        ShiptoCityVisible: Boolean;
        PayatCodeVisible: Boolean;
        ShortcutDimension1CodeVisible: Boolean;
        ShortcutDimension2CodeVisible: Boolean;
        QuoteNoVisible: Boolean;
        OrderAddressCodeVisible: Boolean;
        PurchaserCodeVisible: Boolean;
        PaytoVendorNoVisible: Boolean;
        PaytoContactnoVisible: Boolean;
        PaytoNameVisible: Boolean;
        PaytoAddressVisible: Boolean;
        PaytoAddress2Visible: Boolean;
        PaytoPostCodeVisible: Boolean;
        PaytoCityVisible: Boolean;
        PaytoCountyVisible: Boolean;
        PaytoCountryVisible: Boolean;
        PaytoContactVisible: Boolean;
        InboundWhseHandlingTimeVisible: Boolean;
        ShipmentMethodCodeVisible: Boolean;
        LeadTimeCalculationVisible: Boolean;
        RequestedReceiptDateVisible: Boolean;
        PromisedReceiptDateVisible: Boolean;
        ExpectedReceiptDateVisible: Boolean;
        VendorBankAccCodeVisible: Boolean;
}
