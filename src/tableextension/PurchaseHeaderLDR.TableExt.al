tableextension 50237 PurchaseHeader_LDR extends "Purchase Header"
{
    DataCaptionFields = "Document Type";
    fields
    {
        modify("Shortcut Dimension 1 Code")
        {
            //todo: esto yo lo quitaria
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        modify("Shortcut Dimension 2 Code")
        {
            //todo: esto yo lo quitaria
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Grupo contable negocio';
        }
        modify("Buy-from Country/Region Code")
        {
            trigger OnAfterValidate()
            begin
                Rec."VAT Country/Region Code" := Rec."Buy-from Country/Region Code";
            end;
        }
        modify("Area")
        {
            Caption = 'Cód. provincia';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Grupo registro IVA neg.';
        }
        modify("Payment Reference")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Payment Reference" <> '' then
                    Rec.TestField("Creditor No.");
            end;
        }
        modify("Invoice Type")
        {
            //todo: esto yo lo quitaria
            OptionCaption = 'F1 Invoice,F2 Simplified Invoice,F3 Invoice issued to replace simplified invoices,F4 Invoice summary entry,F5 Imports (DUA),F6 Accounting support material,Customs - Complementary Liquidation';
        }
    }

    trigger OnAfterInsert()
    var
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get;
        Rec."Location Code" := UserDimensions.getLocationCode(UserId);
        Rec."Assigned User ID" := UserId;
    end;

    trigger OnModify()
    var
        UserDimensions: Record "User Dimensions_LDR";
    begin
        if UserDims.existsUser(UserId) then
            TestField("Assigned User ID", UserId);
    end;

    trigger OnBeforeDelete()
    begin
        if UserDims.existsUser(UserId) then
            TestField("Assigned User ID", UserId);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    //todo: revisar si se puede eliminar t38
    /*
        procedure InitSii()
        var
            GeneralLedgerSetup: Record "General Ledger Setup";
            SIIManagement: Codeunit "SII Management";
        begin
            GeneralLedgerSetup.Get();
            if GeneralLedgerSetup."VAT Cash Regime" then
                "Special Scheme Code" := "Special Scheme Code"::"07 Special Cash"
            else
                if "Buy-from Vendor No." <> '' then
                    if Vend.Get("Buy-from Vendor No.") then
                        if Vend."No." <> '' then
                            if SIIManagement.VendorIsIntraCommunity(Vend."No.") then
                                "Special Scheme Code" := "Special Scheme Code"::"09 Intra-Community Acquisition"
                            else
                                "Special Scheme Code" := "Special Scheme Code"::"01 General";
        end;
    */
    var
        Vend: Record Vendor;
        UserDimensions: Record "User Dimensions_LDR";
        UserDims: Record "User Dimensions_LDR";
        PostedPurchaseInvoices: Page "Posted Purchase Invoices";
        DimMgt: Codeunit DimensionManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        Text000: Label 'Do you want to print receipt %1?';
        Text001: Label 'Do you want to print invoice %1?';
        Text002: Label 'Do you want to print credit memo %1?';
        Text006: Label 'You cannot change %1 because the order is associated with one or more sales orders.';
        Text019: Label 'You have changed %1 on the purchase header, but it has not been changed on the existing purchase lines.\';
        Text021: Label 'The change may affect the exchange rate used on the price calculation of the purchase lines.';
        Text024: Label 'Do you want to print return shipment %1?';
        Text043: Label 'Do you want to print prepayment invoice %1?';
        Text044: Label 'Do you want to print prepayment credit memo %1?';
        Text053: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.';
        Text1100002: Label 'The %1 does not exist. \Identification fields and values:\%1 = %2';
}