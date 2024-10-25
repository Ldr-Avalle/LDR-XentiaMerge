report 50000 Services
{
    ApplicationArea = All;
    Caption = 'Services';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Services.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Cash Notes_LDR"; "Cash Notes_LDR")
        {
            RequestFilterFields = "Code", Date, "User ID", Description;

            column(CompanyName; CompanyName)
            {
            }
        }
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
}