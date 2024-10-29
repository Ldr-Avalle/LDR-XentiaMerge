codeunit 50006 EventosPaginas
{
    //todo:lo hace el estandar
    /*
    #region page 42 "Sales Order"
    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnPostDocumentBeforeNavigateAfterPosting', '', false, false)]
    local procedure OnPostDocumentBeforeNavigateAfterPosting(var SalesHeader: Record "Sales Header")
    VAR
        OrderSalesHeader: Record 36;
        SalesInvoiceHeader: Record 112;
    begin
        IF NOT OrderSalesHeader.GET(SalesHeader."Document Type", SalesHeader."No.") THEN BEGIN
            SalesInvoiceHeader.SETRANGE("No.", SalesHeader."Last Posting No.");
            IF SalesInvoiceHeader.FINDFIRST THEN
                IF CONFIRM(OpenPostedSalesOrderQst) THEN
                    PAGE.RUN(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        end;
    #endregion
    */


    #region page 5703 "Location Card"
    [EventSubscriber(ObjectType::Page, Page::"Location Card", 'OnAfterUpdateEnabled', '', false, false)]
    local procedure OnAfterUpdateEnabled(Location: Record Location; sender: Page "Location Card")
    begin
        Location."Use Put-away Worksheet" := Location."Directed Put-away and Pick" OR (Location."Require Put-away" AND NOT Location."Use As In-Transit" AND NOT Location."Bin Mandatory");
    end;
    #endregion
}
