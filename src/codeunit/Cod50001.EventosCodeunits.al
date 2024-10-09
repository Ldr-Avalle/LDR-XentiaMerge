codeunit 50001 EventosCodeunits
{
    #region Sales-Post
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostSalesDoc, '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header")
    var
        SalesLine2: Record "Sales Line";
        Item2: Record Item;
        Text0001Lbl: Label 'No se pueden emitir facturas de productos con nº de serie al cliente %1';
        Text0003Lbl: Label 'Los códigos de producto deben ser de al menos 12 caracteres. Producto %1';
    begin

        IF ((SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) AND (SalesHeader."Sell-to Customer No." = '0')) THEN BEGIN
            //SalesLine2.SETFILTER("Document Type", '%1', SalesHeader."Document Type"::Invoice);
            //SalesLine2.SETFILTER("Document No.", '%1', SalesHeader."No.");
            //SalesLine2.SETFILTER(Type, '%1', SalesLine2.Type::Item);
            //IF SalesLine2.FINDFIRST THEN
            SalesLine2.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
            SalesLine2.SetRange("Document No.", SalesHeader."No.");
            SalesLine2.SetRange(Type, SalesLine2.Type::Item);
            IF SalesLine2.FindSet() THEN
                REPEAT
                    Item2.GET(SalesLine2."No.");
                    IF Item2."Item Tracking Code" <> '' THEN
                        ERROR(Text0001Lbl, SalesHeader."Sell-to Customer No.");
                UNTIL SalesLine2.NEXT = 0;
        end;
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo") THEN
            SalesHeader.TESTFIELD("Payment Method Code");

        //SalesLine2.SETFILTER("Document Type", '%1', SalesHeader."Document Type");
        //SalesLine2.SETFILTER("Document No.", '%1', SalesHeader."No.");
        //SalesLine2.SETFILTER(Type, '%1', SalesLine2.Type::Item);
        //IF SalesLine2.FINDFIRST THEN
        SalesLine2.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine2.SetRange("Document No.", SalesHeader."No.");
        SalesLine2.SetRange(Type, SalesLine2.Type::Item);
        IF SalesLine2.FindSet() THEN
            REPEAT
                IF STRLEN(SalesLine2."No.") < 12 THEN
                    ERROR(Text0003Lbl, SalesLine2."No.");
            UNTIL SalesLine2.NEXT = 0;
    END;
    #endregion

    #region Sales Post Invoice Events
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", OnAfterSetApplyToDocNo, '', false, false)]
    local procedure OnAfterSetApplyToDocNo(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine.FacturaFin := SalesHeader.FacturaFin;
    end;
    #endregion

    #region Sales-Post
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterPostSalesDoc, '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header")
    begin
        CRMIntegrationManagement.AddPostedSalesDocumentToCRMAccountWall(SalesHeader);
        CRMIntegrationManagement.SetCRMSalesOrderStatusToInvoiced(SalesHeader);

    end;
    #endregion

    #region Sales-Post
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnPostItemJnlLineOnAfterPrepareItemJnlLine, '', false, false)]
    local procedure OnPostItemJnlLineOnAfterPrepareItemJnlLine(SalesHeader: Record "Sales Header"; var ItemJournalLine: Record "Item Journal Line")
    begin
        ItemJournalLine."On Deposit" := SalesHeader."On Deposit";
    end;
    #endregion

    #region Sales Post Invoice Events
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Post Invoice Events", OnPostLedgerEntryOnBeforeGenJnlPostLine, '', false, false)]
    local procedure OnPostLedgerEntryOnBeforeGenJnlPostLine(SalesHeader: Record "Sales Header"; var GenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine.FacturaFin := SalesHeader.FacturaFin;
    end;
    #endregion

    #region Purch.-Post
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePostPurchaseDoc, '', false, false)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        PurchLine2: Record "Purchase Line";
        Text0003Lbl: Label 'Los códigos de producto deben ser de al menos 12 caracteres. Producto %1';
    begin
        PurchLine2.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchLine2.SetRange("Document No.", PurchaseHeader."No.");
        PurchLine2.SetRange(Type, PurchLine2.Type::Item);
        IF PurchLine2.FindSet() THEN
            REPEAT
                IF STRLEN(PurchLine2."No.") < 12 THEN
                    ERROR(Text0003Lbl, PurchaseHeader."No.");
            UNTIL PurchLine2.NEXT = 0;
    end;
    #endregion

    //OnConfirmPostPurchaseDocumentOnBeforePurchaseOrderGetPurchaseInvoicePostingPolicy
    #region Posting Selection Management
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Selection Management", OnConfirmPostPurchaseDocumentOnBeforePurchaseOrderGetPurchaseInvoicePostingPolicy, '', false, false)]
    local procedure OnConfirmPostPurchaseDocumentOnBeforePurchaseOrderGetPurchaseInvoicePostingPolicy(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        UserDims: Record "User Dimensions_LDR";
        Selection: Integer;
        Text000xLbl: Label 'Recibir';
    begin
        case true of
            not PurchaseHeader.Receive and not PurchaseHeader.Invoice:
                begin
                    IF UserDims.existsUser(USERID) THEN begin
                        Selection := STRMENU(Text000xLbl, 3);
                        IsHandled := TRUE;
                        if Selection <> 0 then begin
                            PurchaseHeader.Receive := Selection in [1, 3];
                            PurchaseHeader.Invoice := Selection in [2, 3];
                        end;
                    end;
                end;
        end;
    end;
    #endregion

    #region Posting Selection Management
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Posting Selection Management", OnConfirmPostPurchaseDocumentOnBeforePurchaseReturnOrderGetPurchaseInvoicePostingPolicy, '', false, false)]
    local procedure OnConfirmPostPurchaseDocumentOnBeforePurchaseReturnOrderGetPurchaseInvoicePostingPolicy(var IsHandled: Boolean; var PurchaseHeader: Record "Purchase Header")
    var
        UserDims: Record "User Dimensions_LDR";
        Selection: Integer;
        Text002xLbl: Label 'Enviar';
    begin
        case true of
            not PurchaseHeader.Ship and not PurchaseHeader.Invoice:
                begin
                    IF UserDims.existsUser(USERID) THEN begin
                        Selection := STRMENU(Text002xLbl, 3);
                        IsHandled := TRUE;
                        if Selection <> 0 then begin
                            PurchaseHeader.Ship := Selection in [1, 3];
                            PurchaseHeader.Invoice := Selection in [2, 3];
                        end;
                    end;
                end;
        end;
    end;
    #endregion

    #region Cust. Entry-Edit
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust. Entry-Edit", OnBeforeCustLedgEntryModify, '', false, false)]
    local procedure OnBeforeCustLedgEntryModify(FromCustLedgEntry: Record "Cust. Ledger Entry"; var CustLedgEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgEntry.FacturaFin := FromCustLedgEntry.FacturaFin;
    end;
    #endregion

    #region DimensionManagement
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"DimensionManagement", OnAfterDefaultDimObjectNoWithoutGlobalDimsList, '', false, false)]
    local procedure OnAfterDefaultDimObjectNoWithoutGlobalDimsList(var TempAllObjWithCaption: Record AllObjWithCaption temporary; sender: Codeunit DimensionManagement)
    begin
        sender.DefaultDimInsertTempObject(TempAllObjWithCaption, Database::User);
    end;
    #endregion
}


/*
#region aaa
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"aaa", OnAfterInsertLine, '', false, false)]
    local procedure OnAfterInsertLine()
    begin    
    end;
    #endregion
*/
