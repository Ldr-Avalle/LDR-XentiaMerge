report 50092 "Employees ONO"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Employees ONO.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table5200)
        {
            PrintOnlyIfDetail = true;
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
            dataitem(DataItem1000000001;Table50009)
            {
                DataItemLink = Employee No.=FIELD(No.);
                DataItemTableView = SORTING(Employee No.,Start Date)
                                    ORDER(Descending);
                RequestFilterFields = "Employee No.";
                column(EmployeeinternalhistoricProject;"Employee internal historic".Project)
                {
                }
                column(EmployeeinternalhistoricCounty;"Employee internal historic".County)
                {
                }
                column(EmployeeinternalhistoricSegmento;"Employee internal historic".Segmento)
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

