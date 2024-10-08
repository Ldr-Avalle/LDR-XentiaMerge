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
            SalesLine2.SETFILTER("Document Type", '%1', SalesHeader."Document Type"::Invoice);
            SalesLine2.SETFILTER("Document No.", '%1', SalesHeader."No.");
            SalesLine2.SETFILTER(Type, '%1', SalesLine2.Type::Item);
            IF SalesLine2.FINDFIRST THEN
                REPEAT
                    Item2.GET(SalesLine2."No.");
                    IF Item2."Item Tracking Code" <> '' THEN
                        ERROR(Text0001Lbl, SalesHeader."Sell-to Customer No.");
                UNTIL SalesLine2.NEXT = 0;
        end;
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo") THEN
            SalesHeader.TESTFIELD("Payment Method Code");

        SalesLine2.SETFILTER("Document Type", '%1', SalesHeader."Document Type");
        SalesLine2.SETFILTER("Document No.", '%1', SalesHeader."No.");
        SalesLine2.SETFILTER(Type, '%1', SalesLine2.Type::Item);
        IF SalesLine2.FINDFIRST THEN
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

    // [Obsolete('Moved to Sales Invoice Posting implementation.', '19.0')]
    //local procedure PostCustomerEntry(var SalesHeader: Record "Sales Header"; TotalSalesLine2: Record "Sales Line"; TotalSalesLineLCY2: Record "Sales Line"; DocType: Enum "Gen. Journal Document Type"; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10])
    #region Sales-Post
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostCustomerEntry, '', false, false)]
    local procedure OnBeforePostCustomerEntry(SalesHeader: Record "Sales Header"; var GenJnlLine: Record "Gen. Journal Line")
    begin
        GenJournalLine.FacturaFin := SalesHeader.FacturaFin;
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
