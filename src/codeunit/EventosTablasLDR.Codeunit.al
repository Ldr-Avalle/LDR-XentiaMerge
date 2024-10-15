codeunit 50000 "EventosTablas_LDR"
{
    #region table 13 "Salesperson/Purchaser"
    [EventSubscriber(ObjectType::Table, Database::"Salesperson/Purchaser", 'OnAfterValidateEvent', 'E-Mail', true, true)]
    local procedure OnAfterValidateAddress2(var Rec: Record "Salesperson/Purchaser"; var xRec: Record "Salesperson/Purchaser"; CurrFieldNo: Integer)
    begin
        if (Rec."Search E-Mail" = UpperCase(xRec."E-Mail")) or (Rec."Search E-Mail" = '') then
            Rec."Search E-Mail" := Rec."E-Mail";

        if Rec."E-Mail" <> xRec."E-Mail" then
            Rec."E-Mail 2" := Rec."E-Mail";
    end;
    #endregion

    #region table 14 Location
    [EventSubscriber(ObjectType::Table, Database::Location, 'OnBeforeValidateEvent', 'Require Put-away', true, true)]
    local procedure OnBeforeValidateRequirePutAway(var Rec: Record Location; var xRec: Record Location; CurrFieldNo: Integer)
    var
        WhseActivHeader: Record "Warehouse Activity Header";
        WhseRcptHeader: Record "Warehouse Receipt Header";
        Text008: Label '%1 tiene que ser %2, porque uno o más %3 existen.';
        ErrorRequirePutAway: Label 'No se permite activar [Requiere Almacenamiento] en la validación del campo.';
    begin
        if not Rec."Require Put-away" then begin
            WhseRcptHeader.SetRange("Location Code", Rec.Code);
            if not WhseRcptHeader.IsEmpty() then
                Error(Text008, Rec.FieldCaption("Require Put-away"), xRec."Require Put-away", WhseRcptHeader.TableCaption());

            Rec.TestField("Directed Put-away and Pick", false);
            WhseActivHeader.SetRange(Type, WhseActivHeader.Type::"Put-away");
            WhseActivHeader.SetRange("Location Code", Rec.Code);
            if not WhseActivHeader.IsEmpty() then
                Error(Text008, Rec.FieldCaption("Require Put-away"), true, WhseActivHeader.TableCaption());
            Rec."Use Cross-Docking" := false;
            Rec."Cross-Dock Bin Code" := '';
        end else
            Error(ErrorRequirePutAway);
    end;

    [EventSubscriber(ObjectType::Table, Database::Location, 'OnBeforeValidateEvent', 'Require Receive', true, true)]
    local procedure OnBeforeValidateRequireReceive(var Rec: Record Location; var xRec: Record Location; CurrFieldNo: Integer)
    var
        WhseActivHeader: Record "Warehouse Activity Header";
        WhseRcptHeader: Record "Warehouse Receipt Header";
        Text008: Label '%1 tiene que ser %2, porque uno o más %3 existen.';
        ErrorRequireReceive: Label 'No se permite activar [Requiere Recepción] en la validación del campo.';
    begin
        if not Rec."Require Receive" then begin
            Rec.TestField("Directed Put-away and Pick", false);
            WhseRcptHeader.SetRange("Location Code", Rec.Code);
            if not WhseRcptHeader.IsEmpty() then
                Error(Text008, Rec.FieldCaption("Require Receive"), true, WhseRcptHeader.TableCaption());
            Rec."Receipt Bin Code" := '';
            Rec."Use Cross-Docking" := false;
            Rec."Cross-Dock Bin Code" := '';
        end else
            Error(ErrorRequireReceive);
    end;
    #endregion

    #region table 15 "Sales Line"
    [EventSubscriber(ObjectType::Table, Database::"G/L Account", 'OnAfterValidateEvent', 'Income/Balance', true, true)]
    local procedure OnBeforeValidateIncomeBalance(var Rec: Record "G/L Account"; var xRec: Record "G/L Account"; CurrFieldNo: Integer)
    var
        DefDim: Record "Default Dimension";
        TestNo: Integer;
        Text1100001: Label 'La longitud del nuevo valor no es aceptable, ya que implica un cambio en %1.';
    begin
        if (xRec."No." <> '') then
            if (StrLen(Rec."No.") > 5) <> (StrLen(xRec."No.") > 5) then
                Error(Text1100001, Rec.FieldName("Account Type"));

        Evaluate(TestNo, CopyStr(Rec."No.", 1, 1));

        if TestNo in [6 .. 7] then begin
            DefDim.Init();
            DefDim."Table ID" := 15;
            DefDim."No." := Rec."No.";
            DefDim."Dimension Code" := 'Proyecto';
            DefDim."Value Posting" := DefDim."Value Posting"::"Code Mandatory";
            DefDim.Insert();
        end;
    end;
    #endregion

    #region table 17 "G/L Entry"
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure "G/L Entry_OnAfterCopyGLEntryFromGenJnlLine"(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry.FacturaFin := GenJournalLine.FacturaFin;
    end;
    #endregion

    #region table 18 Customer"
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterInsertCustomer(var Rec: Record Customer; RunTrigger: Boolean)
    begin
        Rec.Validate("VAT Registration No.", Rec."No.");
        Rec."Gen. Bus. Posting Group" := 'NACIONAL';
        Rec."VAT Bus. Posting Group" := 'NACIONAL';
        Rec."Customer Posting Group" := 'NAC';
        Rec."Country/Region Code" := 'ES';
        Rec."Payment Terms Code" := 'CON';
        Rec.Validate("Prices Including VAT", true);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeCheckIfOrderSalesLinesExist', '', true, true)]
    local procedure OnBeforeCheckIfOrderSalesLinesExist(var Customer: Record Customer; var IsHandled: Boolean)
    var
        SalesOrderLine: Record "Sales Line";
        Text000: Label 'You cannot delete %1 %2 because there is at least one outstanding Sales %3 for this customer.';
    begin
        IsHandled := true;

        SalesOrderLine.SetCurrentKey("Document Type", "Bill-to Customer No.");
        SalesOrderLine.SetFilter("Document Type", '%1|%2', SalesOrderLine."Document Type"::Order, SalesOrderLine."Document Type"::"Return Order");
        SalesOrderLine.SetRange("Bill-to Customer No.", Customer."No.");
        if SalesOrderLine.FindFirst() then
            Error(Text000, Customer.TableCaption, Customer."No.", SalesOrderLine."Document Type");

        SalesOrderLine.SetRange("Bill-to Customer No.");
        SalesOrderLine.SetRange("Sell-to Customer No.", Customer."No.");
        if SalesOrderLine.FindFirst() then
            Error(Text000, Customer.TableCaption, Customer."No.", SalesOrderLine."Document Type");
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeValidateEvent', 'No.', true, true)]
    local procedure OnBeforeValidateNo(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    begin
        if xRec."No." = '0' then
            Rec.FieldError("No.");
        Rec.Validate("VAT Registration No.", Rec."No.");
    end;
    #endregion

    #region table 21 "Cust. Ledger Entry"	
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterModifyEvent', '', true, true)]
    local procedure OnAfterModifyCustomer(var Rec: Record "Cust. Ledger Entry"; RunTrigger: Boolean)
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
    begin
        //GenJnlPostPreview.ModifyCustLedgEntry(Rec); //TODO: Revisar como va hecha la función de la llamada
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterCopyCustLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure "Cust. Ledger Entry_OnAfterCopyCustLedgerEntryFromGenJnlLine"(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry.FacturaFin := GenJournalLine.FacturaFin;
    end;
    #endregion

    #region table 23 "Vendor"
    [EventSubscriber(ObjectType::Table, Database::Vendor, OnBeforeCheckOutstandingPurchaseDocuments, '', false, false)]
    local procedure Vendor_OnBeforeCheckOutstandingPurchaseDocuments(Vendor: Record Vendor; var IsHandled: Boolean)
    var
        PurchOrderLine: Record "Purchase Line";
        Text000: Label 'No puedes eliminar %1 %2 porque hay al menos una Compra %3 pendiente para este proveedor.';
    begin
        PurchOrderLine.SetCurrentKey("Document Type", "Pay-to Vendor No.");
        PurchOrderLine.SetFilter("Document Type", '%1|%2', PurchOrderLine."Document Type"::Order, PurchOrderLine."Document Type"::"Return Order");
        PurchOrderLine.SetRange("Pay-to Vendor No.", Vendor."No.");
        if PurchOrderLine.FindFirst() then
            Error(Text000, Vendor.TableCaption, Vendor."No.", PurchOrderLine."Document Type");
    end;
    #endregion

    #region table 38 "Purchase Header"
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeOnInsert, '', false, false)]
    local procedure OnBeforeOnInsert(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        CompanyInfo: Record "Company Information";
        UserDimensions: Record "User Dimensions_LDR";
        StandardCodesMgtGlobal: Codeunit "Standard Codes Mgt.";
    begin
        IsHandled := true;
        PurchaseHeader.InitInsert();

        if PurchaseHeader.GetFilter("Buy-from Vendor No.") <> '' then
            if PurchaseHeader.GetRangeMin("Buy-from Vendor No.") = PurchaseHeader.GetRangeMax("Buy-from Vendor No.") then
                PurchaseHeader.Validate("Buy-from Vendor No.", PurchaseHeader.GetRangeMin("Buy-from Vendor No."));

        if PurchaseHeader."Buy-from Vendor No." <> '' then
            StandardCodesMgtGlobal.CheckCreatePurchRecurringLines(PurchaseHeader);

        CompanyInfo.Get;
        PurchaseHeader."Location Code" := UserDimensions.getLocationCode(UserId);
        PurchaseHeader."Assigned User ID" := UserId;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterCheckBuyFromVendor, '', false, false)]
    local procedure OnAfterCheckBuyFromVendor(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor)
    begin
        Vendor.TestField("VAT Registration No.");
        Vendor.TestField("Country/Region Code");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeValidateEmptySellToCustomerAndLocation, '', false, false)]
    local procedure OnBeforeValidateEmptySellToCustomerAndLocation(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; var IsHandled: Boolean; var xPurchaseHeader: Record "Purchase Header")
    begin
        IsHandled := true;
        PurchaseHeader.Validate("Sell-to Customer No.", '');

        if PurchaseHeader."Buy-from Vendor No." <> '' then
            PurchaseHeader.GetVend(PurchaseHeader."Buy-from Vendor No.");
        PurchaseHeader.UpdateLocationCode(Vendor."Location Code");
        PurchaseHeader.InitSii;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont, '', false, false)]
    local procedure OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var SkipBuyFromContact: Boolean)
    var
        UserDims: Record "User Dimensions_LDR";
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get;
        UserDims.SetRange(UserDims.Usuario, UserId);
        if UserDims.FindFirst then
            PurchaseHeader."Location Code" := UserDims."Location Code";
    end;
    #endregion

    #region table 5207 "Employee Absence"
    [EventSubscriber(ObjectType::Table, Database::"Employee Absence", 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterInsertEmployeeAbsence(var Rec: Record "Employee Absence"; RunTrigger: Boolean)
    var
        EmployeeAbsence: Record "Employee Absence";
    begin
        EmployeeAbsence.SetFilter("Employee No.", '%1', Rec."Employee No.");
        if EmployeeAbsence.FindLast() then
            Rec."Entry No." := EmployeeAbsence."Entry No." + 1
        else
            Rec."Entry No." := 1;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Employee Absence", 'OnBeforeValidateEvent', 'Employee No.', true, true)]
    local procedure OnBeforeValidatePrivacyBlocked(var Rec: Record "Employee Absence"; var xRec: Record "Employee Absence"; CurrFieldNo: Integer)
    var
        Employee: Record Employee;
    begin
        Employee.Get(Rec."Employee No.");
        if Employee."Privacy Blocked" then begin
            Employee."Privacy Blocked" := false;
            Employee.Modify(false);

            Rec."Privacy Blocked_LDR" := true;
            Rec.Modify(false);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Employee Absence", 'OnAfterValidateEvent', 'Employee No.', true, true)]
    local procedure OnAfterValidatePrivacyBlocked(var Rec: Record "Employee Absence"; var xRec: Record "Employee Absence"; CurrFieldNo: Integer)
    var
        Employee: Record Employee;
    begin
        if Rec."Privacy Blocked_LDR" then begin
            Employee.Get(Rec."Employee No.");
            Employee."Privacy Blocked" := true;
            Employee.Modify(false);

            Rec."Privacy Blocked_LDR" := false;
            Rec.Modify(false);
        end;
    end;
    #endregion

    #region table 5940 "Service Item"
    [EventSubscriber(ObjectType::Table, Database::"Service Item", 'OnAfterValidateEvent', 'Description', true, true)]
    local procedure OnAfterValidateDescription(var Rec: Record "Service Item"; var xRec: Record "Service Item"; CurrFieldNo: Integer)
    begin
        Rec.CheckUniqueNameConditions();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Item", OnBeforeServItemLinesExistErr, '', false, false)]
    local procedure "Service Item_OnBeforeServItemLinesExistErr"(var ServiceItem: Record "Service Item"; ChangedFieldName: Text[100]; var IsHandled: Boolean)
    var
        ServiceItemLine: Record "Service Item Line";
        Text016: Label 'No puede modificar el %1 porque existen ofertas/pedidos servicio pendientes relacionados con él.';
    begin
        ServiceItemLine.Reset();
        ServiceItemLine.SetCurrentKey("Service Item No.");
        ServiceItemLine.SetRange("Service Item No.", ServiceItem."No.");
        if ServiceItemLine.FindFirst() then
            Error(Text016, ChangedFieldName);
        IsHandled := true;
    end;

    #endregion

    #region table 7000002 "Cartera Doc."
    [EventSubscriber(ObjectType::Table, Database::"Cartera Doc.", 'OnBeforeInsertEvent', '', true, true)]
    local procedure OnBeforeInsertCarteraDoc(var Rec: Record "Cartera Doc."; RunTrigger: Boolean)
    begin
        if Rec.Type = Rec.Type::Payable then
            Rec.Type_LDR := Rec.Type_LDR::Empty;
        //Rec.Modify(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Cartera Doc.", 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterInsertCarteraDoc(var Rec: Record "Cartera Doc."; RunTrigger: Boolean)
    begin
        if Rec.Type = Rec.Type::Empty then
            Rec.Type_LDR := Rec.Type_LDR::Payable;
        //Rec.Modify(false);
    end;
    #endregion
}