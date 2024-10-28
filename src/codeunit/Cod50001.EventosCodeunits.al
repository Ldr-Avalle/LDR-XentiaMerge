codeunit 50001 EventosCodeunits
{
    #region codeunit 80 Sales-Post
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostSalesDoc, '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header")
    var
        SalesLine2: Record "Sales Line";
        Item2: Record Item;
        Text0001Lbl: Label 'No se pueden emitir facturas de productos con nº de serie al cliente %1';
        Text0003Lbl: Label 'Los códigos de producto deben ser de al menos 12 caracteres. Producto %1';
    begin

        if ((SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) and (SalesHeader."Sell-to Customer No." = '0')) then begin
            //TODO: codigo original
            /*
                        SalesLine2.SETFILTER("Document Type", '%1', SalesHeader."Document Type"::Invoice);
                        SalesLine2.SETFILTER("Document No.", '%1', SalesHeader."No.");
                        SalesLine2.SETFILTER(Type, '%1', SalesLine2.Type::Item);
                        IF SalesLine2.FINDFIRST THEN
            */
            SalesLine2.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
            SalesLine2.SetRange("Document No.", SalesHeader."No.");
            SalesLine2.SetRange(Type, SalesLine2.Type::Item);
            if SalesLine2.FindSet() then
                repeat
                    Item2.Get(SalesLine2."No.");
                    if Item2."Item Tracking Code" <> '' then
                        Error(Text0001Lbl, SalesHeader."Sell-to Customer No.");
                until SalesLine2.Next() = 0;
        end;
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo") then
            SalesHeader.TestField("Payment Method Code");
        /*
                SalesLine2.SETFILTER("Document Type", '%1', SalesHeader."Document Type");
                SalesLine2.SETFILTER("Document No.", '%1', SalesHeader."No.");
                SalesLine2.SETFILTER(Type, '%1', SalesLine2.Type::Item);
                IF SalesLine2.FINDFIRST THEN
        */
        SalesLine2.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine2.SetRange("Document No.", SalesHeader."No.");
        SalesLine2.SetRange(Type, SalesLine2.Type::Item);
        if SalesLine2.FindSet() then
            repeat
                if StrLen(SalesLine2."No.") < 12 then
                    Error(Text0003Lbl, SalesLine2."No.");
            until SalesLine2.Next() = 0;
    end;
    #endregion

    #region codeunit 825 Sales Post Invoice Events
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", OnAfterSetApplyToDocNo, '', false, false)]
    local procedure OnAfterSetApplyToDocNo(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine.FacturaFin := SalesHeader.FacturaFin;
    end;
    #endregion

    #region codeunit 80 Sales-Post
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesDoc, '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header")
    var
        FuncionesGenericas: Codeunit FuncionesGenericas;
    begin
        FuncionesGenericas.AddPostedSalesDocumentToCRMAccountWall(SalesHeader);
        FuncionesGenericas.SetCRMSalesOrderStatusToInvoiced(SalesHeader);
    end;
    #endregion

    #region codeunit 80 Sales-Post
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnPostItemJnlLineOnAfterPrepareItemJnlLine, '', false, false)]
    local procedure OnPostItemJnlLineOnAfterPrepareItemJnlLine(SalesHeader: Record "Sales Header"; var ItemJournalLine: Record "Item Journal Line")
    begin
        //todo:he mirado el codigo 1000 veces y este campo en sales header no existe
        //ItemJournalLine."On Deposit" := SalesHeader."On Deposit";
    end;
    #endregion

    #region codeunit 825 Sales Post Invoice Events
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", OnPostLedgerEntryOnBeforeGenJnlPostLine, '', false, false)]
    local procedure OnPostLedgerEntryOnBeforeGenJnlPostLine(SalesHeader: Record "Sales Header"; var GenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine.FacturaFin := SalesHeader.FacturaFin;
    end;
    #endregion

    #region codeunit 90 Purch.-Post
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePostPurchaseDoc, '', false, false)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        PurchLine2: Record "Purchase Line";
        Text0003Lbl: Label 'Los códigos de producto deben ser de al menos 12 caracteres. Producto %1';
    begin
        PurchLine2.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchLine2.SetRange("Document No.", PurchaseHeader."No.");
        PurchLine2.SetRange(Type, PurchLine2.Type::Item);
        if PurchLine2.FindSet() then
            repeat
                if StrLen(PurchLine2."No.") < 12 then
                    Error(Text0003Lbl, PurchaseHeader."No.");
            until PurchLine2.Next() = 0;
    end;
    #endregion

    #region codeunit 99 Posting Selection Management
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Selection Management", OnConfirmPostPurchaseDocumentOnBeforePurchaseOrderGetPurchaseInvoicePostingPolicy, '', false, false)]
    local procedure OnConfirmPostPurchaseDocumentOnBeforePurchaseOrderGetPurchaseInvoicePostingPolicy(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        UserDims: Record "User Dimensions_LDR";
        Selection: Integer;
        Text000xLbl: Label 'Recibir';
    begin
        case true of
            not PurchaseHeader.Receive and not PurchaseHeader.Invoice:
                if UserDims.existsUser(UserId) then begin
                    Selection := StrMenu(Text000xLbl, 3);
                    IsHandled := true;
                    if Selection <> 0 then begin
                        PurchaseHeader.Receive := Selection in [1, 3];
                        PurchaseHeader.Invoice := Selection in [2, 3];
                    end;
                end;
        end;
    end;
    #endregion

    #region codeunit 99 Posting Selection Management
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Selection Management", OnConfirmPostPurchaseDocumentOnBeforePurchaseReturnOrderGetPurchaseInvoicePostingPolicy, '', false, false)]
    local procedure OnConfirmPostPurchaseDocumentOnBeforePurchaseReturnOrderGetPurchaseInvoicePostingPolicy(var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
    var
        UserDims: Record "User Dimensions_LDR";
        Selection: Integer;
        Text002xLbl: Label 'Enviar';
    begin
        case true of
            not PurchaseHeader.Ship and not PurchaseHeader.Invoice:
                if UserDims.existsUser(UserId) then begin
                    Selection := StrMenu(Text002xLbl, 3);
                    IsHandled := true;
                    if Selection <> 0 then begin
                        PurchaseHeader.Ship := Selection in [1, 3];
                        PurchaseHeader.Invoice := Selection in [2, 3];
                    end;
                end;
        end;
    end;
    #endregion

    #region codeunit 103 Cust. Entry-Edit
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust. Entry-Edit", OnBeforeCustLedgEntryModify, '', false, false)]
    local procedure OnBeforeCustLedgEntryModify(FromCustLedgEntry: Record "Cust. Ledger Entry"; var CustLedgEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgEntry.FacturaFin := FromCustLedgEntry.FacturaFin;
    end;
    #endregion

    #region codeunit 408 DimensionManagement
    [EventSubscriber(ObjectType::Codeunit, Codeunit::DimensionManagement, OnAfterDefaultDimObjectNoWithoutGlobalDimsList, '', false, false)]
    local procedure OnAfterDefaultDimObjectNoWithoutGlobalDimsList(var TempAllObjWithCaption: Record AllObjWithCaption temporary; sender: Codeunit DimensionManagement)
    begin
        sender.DefaultDimInsertTempObject(TempAllObjWithCaption, Database::User);
    end;
    #endregion

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


/*
#region codeunit a aaa
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"aaa", OnAfterInsertLine, '', false, false)]
    local procedure OnAfterInsertLine()
    begin    
    end;
    #endregion
*/
