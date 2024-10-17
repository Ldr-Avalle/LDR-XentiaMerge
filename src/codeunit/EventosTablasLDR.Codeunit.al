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
        IsHandled := true;

        PurchOrderLine.SetCurrentKey("Document Type", "Pay-to Vendor No.");
        PurchOrderLine.SetFilter("Document Type", '%1|%2', PurchOrderLine."Document Type"::Order, PurchOrderLine."Document Type"::"Return Order");
        PurchOrderLine.SetRange("Pay-to Vendor No.", Vendor."No.");
        if PurchOrderLine.FindFirst() then
            Error(Text000, Vendor.TableCaption, Vendor."No.", PurchOrderLine."Document Type");

        PurchOrderLine.SetRange("Pay-to Vendor No.");
        PurchOrderLine.SetRange("Buy-from Vendor No.", Vendor."No.");
        if not PurchOrderLine.IsEmpty() then
            Error(Text000, Vendor.TableCaption, Vendor."No.");
    end;
    #endregion

    #region table 38 "Purchase Header"
    //todo: revisar si se puede eliminar t38
    /*
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
    */


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterCheckBuyFromVendor, '', false, false)]
    local procedure OnAfterCheckBuyFromVendor(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor)
    begin
        Vendor.TestField("VAT Registration No.");
        Vendor.TestField("Country/Region Code");
    end;


    //todo: no se de donde ha salido esto, yo lo eliminaria
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeValidateEmptySellToCustomerAndLocation, '', false, false)]
    local procedure OnBeforeValidateEmptySellToCustomerAndLocation(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; var IsHandled: Boolean; var xPurchaseHeader: Record "Purchase Header")
    begin
        IsHandled := true;
        PurchaseHeader.Validate("Sell-to Customer No.", '');

        if PurchaseHeader."Buy-from Vendor No." <> '' then
            PurchaseHeader.GetVend(PurchaseHeader."Buy-from Vendor No.");
        PurchaseHeader.UpdateLocationCode(Vendor."Location Code");
        //todo: revisar si se puede eliminar t38
        //PurchaseHeader.InitSii;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont, '', false, false)]
    local procedure OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var SkipBuyFromContact: Boolean)
    var
        UserDims: Record "User Dimensions_LDR";
    //todo: no se usa para nada
    //CompanyInfo: Record "Company Information";
    begin
        //CompanyInfo.Get;
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

    //todo:esto posiblemente haya que eliminarlo OnBeforeCreateDimensionsFromValidateBillToCustomerNo
    #region table 36 "Sales Header"
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeCreateDimensionsFromValidateBillToCustomerNo', '', true, true)]
    local procedure OnBeforeCreateDimensionsFromValidateBillToCustomerNo(var IsHandled: Boolean; var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.CreateDimFromDefaultDim(SalesHeader.FieldNo("Assigned User ID"));
    end;
    #endregion


    #region table 37 "Sales Line"
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCopyFromItemOnAfterCheck', '', true, true)]
    local procedure OnCopyFromItemOnAfterCheck(Item: Record Item; var SalesLine: Record "Sales Line")
    begin
        SalesLine."On Deposit" := Item."On Deposit";
    end;
    #endregion

    #region table 37 "Sales Line"
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnValidateNoOnAfterUpdateUnitPrice', '', true, true)]
    local procedure OnValidateNoOnAfterUpdateUnitPrice(var SalesLine: Record "Sales Line"; xSalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary)
    var
        gbldimensiones: Record 50000;
        Item: Record 27;
        Proyecto: Code[10];
    begin
        Item.get(SalesLine."No.");
        gbldimensiones.RESET;
        gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
        IF gbldimensiones.FINDFIRST THEN
            Proyecto := gbldimensiones."Project Dimension Value";

        gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
        IF gbldimensiones.FINDFIRST THEN
            SalesLine."Location Code" := gbldimensiones."Location Code";

        IF (Proyecto = 'EUSKALTEL') AND NOT (Item."On Deposit") THEN BEGIN
            SalesLine."Unit Price" := SalesLine."Unit Cost (LCY)";
            SalesLine."Line Amount" := 0;
        END;
    end;
    #endregion

    #region table 37 "Sales Line"
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeUpdatePrePaymentAmounts', '', true, true)]
    local procedure OnBeforeUpdatePrePaymentAmounts(var IsHandled: Boolean; var SalesLine: Record "Sales Line")
    begin
        IF (SalesLine."Document Type" = SalesLine."Document Type"::Invoice) AND (SalesLine."Prepayment %" <> 0) THEN
            IsHandled := TRUE;
    end;
    #endregion


    #region table 37 "Sales Line"
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCalcPrepmtToDeduct', '', true, true)]
    local procedure OnBeforeCalcPrepmtToDeduct(var IsHandled: Boolean; var SalesLine: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
        Currency: Record "Currency";
    begin
        IsHandled := TRUE;

        IF (SalesLine.Quantity - SalesLine."Quantity Invoiced") <> 0 THEN BEGIN
            SalesHeader := SalesLine.GetSalesHeader;
            Currency.Get(SalesHeader."Currency Code");
            IF SalesHeader."Prices Including VAT" THEN
                SalesLine."Prepmt Amt to Deduct" :=
                  ROUND(
                    ROUND(((SalesLine."Prepmt. Amt. Inv." - SalesLine."Prepmt Amt Deducted") * SalesLine."Qty. to Invoice" / (SalesLine.Quantity - SalesLine."Quantity Invoiced")) /
                    (1 + (SalesLine."VAT %" / 100)), Currency."Amount Rounding Precision") * (1 + (SalesLine."VAT %" / 100)),
                    Currency."Amount Rounding Precision")
            ELSE
                SalesLine."Prepmt Amt to Deduct" :=
                  ROUND(
                    (SalesLine."Prepmt. Amt. Inv." - SalesLine."Prepmt Amt Deducted") *
                    SalesLine."Qty. to Invoice" / (SalesLine.Quantity - SalesLine."Quantity Invoiced"), Currency."Amount Rounding Precision")
        END ELSE
            SalesLine."Prepmt Amt to Deduct" := 0
    end;
    #endregion

    //todo:esto posiblemente haya que eliminarlo OnBeforeCreateDimensionsFromValidatePayToVendorNo
    #region table 38 "Purchase Header"
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeCreateDimensionsFromValidatePayToVendorNo, '', false, false)]
    local procedure OnBeforeCreateDimensionsFromValidatePayToVendorNo(var PurchaseHeader: Record "Purchase Header")
    begin
        PurchaseHeader.CreateDimFromDefaultDim(PurchaseHeader.FieldNo("Assigned User ID"));
    end;
    #endregion


    #region table 38 "Purchase Header"
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnValidatePaymentTermsCodeOnBeforeCalcDueDate, '', false, false)]
    local procedure OnValidatePaymentTermsCodeOnBeforeCalcDueDate(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PaymentTerms: Record "Payment Terms";
    begin
        PurchaseHeader."Prepayment Due Date" := CalcDate(PaymentTerms."Due Date Calculation", PurchaseHeader."Document Date");
        IF PurchaseHeader."Pay-to Vendor No." = '' Then
            IsHandled := TRUE;
    end;
    #endregion

    #region table 39 "Purchase Line"
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnBeforeUpdatePrepmtAmounts, '', false, false)]
    local procedure OnBeforeUpdatePrepmtAmounts(var IsHandled: Boolean; PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line")
    begin
        IF (PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice) AND (PurchaseLine."Prepayment %" <> 0) THEN
            IsHandled := TRUE;
    end;
    #endregion
























    //CODEUNITS
    //todo:pasar a la codeunit de eventos

    //todo: codeunit 363 "PostSales-Delete" para mi hay que eliminarlo y tirar por el estandar
    #region codeunit 363 "PostSales-Delete"
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PostSales-Delete", 'OnBeforeDeleteHeader', '', true, true)]
    local procedure OnBeforeDeleteHeaderSales(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var ReturnReceiptHeader: Record "Return Receipt Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SalesCrMemoHeaderPrepmt: Record "Sales Cr.Memo Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesInvoiceHeaderPrepmt: Record "Sales Invoice Header"; var SalesShipmentHeader: Record "Sales Shipment Header")
    var
        SourceCodeSetup: Record "Source Code Setup";
        SourceCode: Record "Source Code";
        codeunitPostSalesDelete: Codeunit "PostSales-Delete";
        Text000: Label '¿Confirma que desea imprimir el albarán %1?';
        Text001: Label '¿Confirma que desea imprimir la factura %1?';
        Text002: Label '¿Confirma que desea imprimir el abono %1?';
        Text023: Label '¿Confirma que desea imprimir la recep. devol. %1?';
        Text054: Label '¿Desea imprimir el abono prepago %1?';
        Text055: Label '¿Desea imprimir la factura prepago %1?';
    begin
        if (SalesHeader."Opportunity No." <> '') and (SalesHeader."Document Type" in [SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order]) then
            codeunitPostSalesDelete.InitDeleteHeader(
              SalesHeader, SalesShipmentHeader, SalesInvoiceHeader, SalesCrMemoHeader,
              ReturnReceiptHeader, SalesInvoiceHeaderPrePmt, SalesCrMemoHeaderPrePmt, SourceCode.Code);

        IF (SalesShipmentHeader."No." <> '') OR
                (SalesInvoiceHeader."No." <> '') OR
                (SalesCrMemoHeader."No." <> '') OR
                (ReturnReceiptHeader."No." <> '') OR
                (SalesInvoiceHeaderPrepmt."No." <> '') OR
                (SalesCrMemoHeaderPrepmt."No." <> '')
             THEN BEGIN
            IF SalesShipmentHeader."No." <> '' THEN
                IF CONFIRM(
                     Text000, TRUE,
                     SalesShipmentHeader."No.")
                THEN BEGIN
                    SalesShipmentHeader.SETRECFILTER;
                    SalesShipmentHeader.PrintRecords(TRUE);
                END;

            IF SalesInvoiceHeader."No." <> '' THEN
                IF CONFIRM(
                     Text001, TRUE,
                     SalesInvoiceHeader."No.")
                THEN BEGIN
                    SalesInvoiceHeader.SETRECFILTER;
                    SalesInvoiceHeader.PrintRecords(TRUE);
                END;

            IF SalesCrMemoHeader."No." <> '' THEN
                IF CONFIRM(
                     Text002, TRUE,
                     SalesCrMemoHeader."No.")
                THEN BEGIN
                    SalesCrMemoHeader.SETRECFILTER;
                    SalesCrMemoHeader.PrintRecords(TRUE);
                END;

            IF ReturnReceiptHeader."No." <> '' THEN
                IF CONFIRM(
                     Text023, TRUE,
                     ReturnReceiptHeader."No.")
                THEN BEGIN
                    ReturnReceiptHeader.SETRECFILTER;
                    ReturnReceiptHeader.PrintRecords(TRUE);
                END;

            IF SalesInvoiceHeaderPrepmt."No." <> '' THEN
                IF CONFIRM(
                     Text055, TRUE,
                     SalesInvoiceHeader."No.")
                THEN BEGIN
                    SalesInvoiceHeaderPrepmt.SETRECFILTER;
                    SalesInvoiceHeaderPrepmt.PrintRecords(TRUE);
                END;

            IF SalesCrMemoHeaderPrepmt."No." <> '' THEN
                IF CONFIRM(
                     Text054, TRUE,
                     SalesCrMemoHeaderPrepmt."No.")
                THEN BEGIN
                    SalesCrMemoHeaderPrepmt.SETRECFILTER;
                    SalesCrMemoHeaderPrepmt.PrintRecords(TRUE);
                END;
        END;
    end;
    #endregion

    #region codeunit 363 "PostSales-Delete"
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PostSales-Delete", 'OnAfterDeleteHeader', '', true, true)]
    local procedure OnAfterDeleteHeader(var SalesHeader: Record "Sales Header")
    var
        Opp: Record 5092;
        TempOpportunityEntry: Record 5093 temporary;
        Text040: Label 'Una oportunidad ganada está vinculada a este pedido.\Antes de poder eliminar el pedido, debe cambiar el estado a Perdida.\¿Desea cambiar el estado para esta oportunidad?';
        Text043: Label 'Wizard Abortado';
        Text044: Label 'No se ha cambiado el estado de la oportunidad. El programa ha anulado la eliminación del pedido.';
    begin
        IF (SalesHeader."Opportunity No." <> '') AND
                   (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Order])
                THEN
            IF Opp.GET(SalesHeader."Opportunity No.") THEN BEGIN
                IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN BEGIN
                    IF NOT CONFIRM(Text040, TRUE) THEN
                        ERROR(Text044);
                    TempOpportunityEntry.INIT;
                    TempOpportunityEntry.VALIDATE("Opportunity No.", Opp."No.");
                    TempOpportunityEntry."Sales Cycle Code" := Opp."Sales Cycle Code";
                    TempOpportunityEntry."Contact No." := Opp."Contact No.";
                    TempOpportunityEntry."Contact Company No." := Opp."Contact Company No.";
                    TempOpportunityEntry."Salesperson Code" := Opp."Salesperson Code";
                    TempOpportunityEntry."Campaign No." := Opp."Campaign No.";
                    TempOpportunityEntry."Action Taken" := TempOpportunityEntry."Action Taken"::Lost;
                    TempOpportunityEntry.INSERT;
                    TempOpportunityEntry.SETRANGE("Action Taken", TempOpportunityEntry."Action Taken"::Lost);
                    PAGE.RUNMODAL(PAGE::"Close Opportunity", TempOpportunityEntry);
                    IF Opp.GET(SalesHeader."Opportunity No.") THEN
                        IF Opp.Status <> Opp.Status::Lost THEN
                            ERROR(Text043);
                END;
                Opp."Sales Document Type" := Opp."Sales Document Type"::" ";
                Opp."Sales Document No." := '';
                Opp.MODIFY;
                SalesHeader."Opportunity No." := '';
            END;
    end;
    #endregion


    //todo: codeunit 364 "PostPurch-Delete" para mi hay que eliminarlo y tirar por el estandar
    #region codeunit 364 "PostPurch-Delete"
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"PostPurch-Delete", 'OnBeforeDeleteHeader', '', true, true)]
    local procedure OnBeforeDeleteHeaderPurchase(var IsHandled: Boolean; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchCrMemoHdrPrepmt: Record "Purch. Cr. Memo Hdr."; var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchInvHeaderPrepmt: Record "Purch. Inv. Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var ReturnShipmentHeader: Record "Return Shipment Header")
    var
        Text000: Label '¿Confirma que desea imprimir el albarán %1?';
        Text001: Label '¿Confirma que desea imprimir la factura %1?';
        Text002: Label '¿Confirma que desea imprimir el abono %1?';
        Text024: Label '¿Confirma que desea imprimir el env¡o devoluci¢n %1?';
        Text043: Label '¿Desea imprimir la factura prepago %1?';
        Text044: Label '¿Desea imprimir el abono prepago %1?';
    begin
        IF (PurchRcptHeader."No." <> '') OR
                  (PurchInvHeader."No." <> '') OR
                  (PurchCrMemoHdr."No." <> '') OR
                  (ReturnShipmentHeader."No." <> '') OR
                  (PurchInvHeaderPrepmt."No." <> '') OR
                  (PurchCrMemoHdrPrepmt."No." <> '')
               THEN BEGIN
            IF PurchRcptHeader."No." <> '' THEN
                IF CONFIRM(
                     Text000, TRUE,
                     PurchRcptHeader."No.")
                THEN BEGIN
                    PurchRcptHeader.SETRECFILTER;
                    PurchRcptHeader.PrintRecords(TRUE);
                END;

            IF PurchInvHeader."No." <> '' THEN
                IF CONFIRM(
                     Text001, TRUE,
                     PurchInvHeader."No.")
                THEN BEGIN
                    PurchInvHeader.SETRECFILTER;
                    PurchInvHeader.PrintRecords(TRUE);
                END;

            IF PurchCrMemoHdr."No." <> '' THEN
                IF CONFIRM(
                     Text002, TRUE,
                     PurchCrMemoHdr."No.")
                THEN BEGIN
                    PurchCrMemoHdr.SETRECFILTER;
                    PurchCrMemoHdr.PrintRecords(TRUE);
                END;

            IF ReturnShipmentHeader."No." <> '' THEN
                IF CONFIRM(
                     Text024, TRUE,
                     ReturnShipmentHeader."No.")
                THEN BEGIN
                    ReturnShipmentHeader.SETRECFILTER;
                    ReturnShipmentHeader.PrintRecords(TRUE);
                END;

            IF PurchInvHeaderPrepmt."No." <> '' THEN
                IF CONFIRM(
                     Text043, TRUE,
                     PurchInvHeader."No.")
                THEN BEGIN
                    PurchInvHeaderPrepmt.SETRECFILTER;
                    PurchInvHeaderPrepmt.PrintRecords(TRUE);
                END;

            IF PurchCrMemoHdrPrepmt."No." <> '' THEN
                IF CONFIRM(
                     Text044, TRUE,
                     PurchCrMemoHdrPrepmt."No.")
                THEN BEGIN
                    PurchCrMemoHdrPrepmt.SETRECFILTER;
                    PurchCrMemoHdrPrepmt.PrintRecords(TRUE);
                END;
        END;
    end;
    #endregion
}