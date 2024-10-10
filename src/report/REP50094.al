report 50094 "Lista empleados"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Lista empleados.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table5200)
        {
            DataItemTableView = SORTING(No.)
                                WHERE(Contract active=CONST(Yes));
            RequestFilterFields = "No.";
            column(CompanyInfoName;CompanyInfo.Name)
            {
            }
            dataitem(DataItem1000000001;Table50004)
            {
                DataItemLink = Employee=FIELD(No.);
                DataItemTableView = SORTING(Employee,No.)
                                    ORDER(Descending);
            }
            dataitem(DataItem1000000002;Table50009)
            {
                DataItemLink = Employee No.=FIELD(No.);
                column(EmployeeNo;Employee."No.")
                {
                }
                column(EmployeeName;Employee.Name)
                {
                }
                column(EmployeeFirstFamilyName;Employee."First Family Name")
                {
                }
                column(EmployeeSecondFamilyName;Employee."Second Family Name")
                {
                }
                column(EmployeeContractCategory;"Employee Contract".Category)
                {
                }
                column(EmployeeContractDateofhire;"Employee Contract"."Date of hire")
                {
                }
                column(EmployeeStatus;Employee.Status)
                {
                }
                column(EmployeeInactiveDate;Employee."Inactive Date")
                {
                }
                column(EmployeeCauseofInactivityCode;Employee."Cause of Inactivity Code")
                {
                }
                column(EmployeeGlobalDimension1Code;Employee."Global Dimension 1 Code")
                {
                }
                column(EmployeeContractWorkingcenter;"Employee Contract"."Working center")
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

