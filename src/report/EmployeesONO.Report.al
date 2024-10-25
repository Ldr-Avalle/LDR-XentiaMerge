report 50092 "Employees ONO"
{
    ApplicationArea = All;
    Caption = 'Employees ONO';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Employees ONO.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; Employee)
        {
            PrintOnlyIfDetail = true;
            column(EmployeeNo; Employee."No.")
            {
            }
            column(EmployeeName; Employee.Name)
            {
            }
            column(EmployeeFirstFamilyName; Employee."First Family Name")
            {
            }
            column(EmployeeSecondFamilyName; Employee."Second Family Name")
            {
            }
            dataitem("Employee internal historic"; "Employee internal historic_LDR")
            {
                DataItemLink = "Employee No." = field("No.");
                DataItemTableView = sorting("Employee No.", "Start Date") order(descending);
                RequestFilterFields = "Employee No.";
                column(EmployeeinternalhistoricProject; "Employee internal historic".Project)
                {
                }
                column(EmployeeinternalhistoricCounty; "Employee internal historic".County)
                {
                }
                column(EmployeeinternalhistoricSegmento; "Employee internal historic".Segmento)
                {
                }

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("Employee No.");
                end;
            }
        }
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
}