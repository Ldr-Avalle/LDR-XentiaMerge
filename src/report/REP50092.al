report 50092 "Employees ONO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Employees ONO.rdl';

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
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Employee No.", "Start Date")
                                    ORDER(Descending);
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
                    LastFieldNo := FIELDNO("Employee No.");
                end;
            }
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
}

