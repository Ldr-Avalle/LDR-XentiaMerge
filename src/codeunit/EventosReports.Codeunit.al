codeunit 50005 EventosReports
{
    #region "Standard Sales - Quote"
    [EventSubscriber(ObjectType::Report, Report::"Standard Sales - Quote", OnAfterSetLanguage, '', false, false)]
    local procedure OnAfterSetLanguage()
    var
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.CalcFields(Picture);
    end;
    #endregion
}