report 50094 "Lista empleados"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Lista empleados.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.")
                                WHERE("Contract active" = CONST(true));
            RequestFilterFields = "No.";
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            dataitem("Employee Contract"; "Employee Contract")
            {
                DataItemLink = Employee = FIELD("No.");
                DataItemTableView = SORTING(Employee, "No.")
                                    ORDER(Descending);
            }
            dataitem("Employee internal historic"; "Employee internal historic")
            {
                DataItemLink = "Employee No." = FIELD("No.");
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
                LastFieldNo := FIELDNO("No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        CompanyInfo: Record "79";
}

