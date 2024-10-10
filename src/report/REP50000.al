report 50000 Services
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Services.rdl';

    dataset
    {
        dataitem("Cash Notes_LDR"; "Cash Notes_LDR")
        {
            RequestFilterFields = "Code", Date, "User ID", Description;
            column(CompanyName; COMPANYNAME)
            {
            }
            //TODO: no exite la tabla 50001
            /*dataitem(DataItem1000000001; Table50001)
            {
                DataItemLink = Field1 = FIELD(User ID);
                DataItemTableView = SORTING(Field1);
                dataitem(Contract; Table50005)
                {
                    DataItemLink = No.=FIELD(Field1);
                    DataItemTableView = SORTING(No., From Entry No., To Entry No.);
                    RequestFilterFields = "To Entry No.", "Creation Date";
                    column(Contract_NIF; Contract."Journal Batch Name")
                    {
                    }
                    column(Contract_Signdate; Contract."From Entry No.")
                    {
                    }
                    dataitem(DataItem1000000003; Table50004)
                    {
                        DataItemLink = Employee = FIELD(From Entry No.);
                        DataItemTableView = SORTING(Employee);

                        trigger OnPreDataItem()
                        begin
                            LastFieldNo := FIELDNO(Employee);
                        end;
                    }
                }
            }*/
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

