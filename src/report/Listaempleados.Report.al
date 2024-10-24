report 50094 "Lista empleados"
{
    ApplicationArea = All;
    Caption = 'Lista empleados';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Lista empleados.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.") where("Contract active" = const(true));
            RequestFilterFields = "No.";
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            dataitem("Employee Contract"; "Employee Contract")
            {
                DataItemLink = Employee = field("No.");
                DataItemTableView = sorting(Employee, "No.") order(descending);
            }
            dataitem("Employee internal historic"; "Employee internal historic_LDR")
            {
                DataItemLink = "Employee No." = field("No.");
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
                column(EmployeeContractCategory; "Employee Contract".Category)
                {
                }
                column(EmployeeContractDateofhire; "Employee Contract"."Date of hire")
                {
                }
                column(EmployeeStatus; Employee.Status)
                {
                }
                column(EmployeeInactiveDate; Employee."Inactive Date")
                {
                }
                column(EmployeeCauseofInactivityCode; Employee."Cause of Inactivity Code")
                {
                }
                column(EmployeeGlobalDimension1Code; Employee."Global Dimension 1 Code")
                {
                }
                column(EmployeeContractWorkingcenter; "Employee Contract"."Working center")
                {
                }
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");
            end;
        }
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        CompanyInfo: Record "Company Information";
}