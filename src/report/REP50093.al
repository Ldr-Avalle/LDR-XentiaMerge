report 50093 "Media empleados"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Media empleados.rdlc';

    dataset
    {
        dataitem(Empleado;Table5200)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "Global Dimension 1 Code","Work position";
            column(CompanyInfoName;CompanyInfo.Name)
            {
            }
            dataitem(DataItem1000000001;Table50004)
            {
                DataItemLink = Employee=FIELD(No.);
                RequestFilterFields = "Contract type",Segment,Category,Work,"Working center";
                column(EmployeeContractNo;"Employee Contract"."No.")
                {
                }
                column(EmpleadoName;Empleado.Name)
                {
                }
                column(EmpleadoFirstFamilyName;Empleado."First Family Name")
                {
                }
                column(EmpleadoSecondFamilyName;Empleado."Second Family Name")
                {
                }
                column(EmployeeContractCategory;"Employee Contract".Category)
                {
                }
                column(EmployeeContractDateofhire;"Employee Contract"."Date of hire")
                {
                }
                column(EmployeeContractExpirationdate;"Employee Contract"."Expiration date")
                {
                }
                column(EmpleadoGlobalDimension1Code;Empleado."Global Dimension 1 Code")
                {
                }
                column(EmployeeContractWorkingcenter;"Employee Contract"."Working center")
                {
                }
                column(ContractDaysEntreEndDateMenosInitDate1;ContractDays/(EndDate-InitDate+1))
                {
                }

                trigger OnAfterGetRecord()
                var
                    CurrentContractDays: Integer;
                begin
                    IF ("Date of hire" < InitDate) THEN
                      IF ("Expiration date" = 0D) OR ("Expiration date" > EndDate) THEN CurrentContractDays := (EndDate - InitDate)
                      ELSE CurrentContractDays := ("Expiration date" - InitDate)
                    ELSE
                      IF ("Expiration date" = 0D) OR ("Expiration date" > EndDate) THEN CurrentContractDays := (EndDate - "Date of hire")
                      ELSE CurrentContractDays := ("Expiration date" - "Date of hire");

                    ContractDays += CurrentContractDays + 1;
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Date of hire", '..%1', EndDate);
                    SETFILTER("Expiration date", '%1..|%2', InitDate, 0D);
                end;
            }

            trigger OnPostDataItem()
            begin
                //MESSAGE('Media %1\Fecha inicio %2\Fecha fin %3\D´Š¢as periodo %4\D´Š¢as contratos %5',
                  //ContractDays/((EndDate-InitDate)+1), InitDate, EndDate, ((EndDate-InitDate)+1), ContractDays);
            end;

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
            area(content)
            {
                field(InitDate;InitDate)
                {
                    Caption = 'Fecha inicio';
                }
                field(EndDate;EndDate)
                {
                    Caption = 'Fecha fin';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF InitDate = 0D THEN ERROR('InitDate');
        IF EndDate = 0D THEN ERROR('EndDate');
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        InitDate: Date;
        EndDate: Date;
        ContractDays: Integer;
        CompanyInfo: Record "79";
}

