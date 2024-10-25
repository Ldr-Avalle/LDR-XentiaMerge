report 50093 "Media empleados"
{
    ApplicationArea = All;
    Caption = 'Media empleados';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Media empleados.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Empleado; Employee)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "Global Dimension 1 Code", "Work position";

            column(CompanyInfoName; CompanyInfo.Name)
            {
            }

            dataitem("Employee Contract"; "Employee Contract")
            {
                DataItemLink = Employee = field("No.");
                RequestFilterFields = "Contract type", Segment, Category, Work, "Working center";

                column(EmployeeContractNo; "Employee Contract"."No.")
                {
                }
                column(EmpleadoName; Empleado.Name)
                {
                }
                column(EmpleadoFirstFamilyName; Empleado."First Family Name")
                {
                }
                column(EmpleadoSecondFamilyName; Empleado."Second Family Name")
                {
                }
                column(EmployeeContractCategory; "Employee Contract".Category)
                {
                }
                column(EmployeeContractDateofhire; "Employee Contract"."Date of hire")
                {
                }
                column(EmployeeContractExpirationdate; "Employee Contract"."Expiration date")
                {
                }
                column(EmpleadoGlobalDimension1Code; Empleado."Global Dimension 1 Code")
                {
                }
                column(EmployeeContractWorkingcenter; "Employee Contract"."Working center")
                {
                }
                column(ContractDaysEntreEndDateMenosInitDate1; ContractDays / (EndDate - InitDate + 1))
                {
                }

                trigger OnAfterGetRecord()
                var
                    CurrentContractDays: Integer;
                begin
                    if ("Date of hire" < InitDate) then
                        if ("Expiration date" = 0D) or ("Expiration date" > EndDate) then
                            CurrentContractDays := (EndDate - InitDate)
                        else
                            CurrentContractDays := ("Expiration date" - InitDate)
                    else
                        if ("Expiration date" = 0D) or ("Expiration date" > EndDate) then
                            CurrentContractDays := (EndDate - "Date of hire")
                        else
                            CurrentContractDays := ("Expiration date" - "Date of hire");

                    ContractDays += CurrentContractDays + 1;
                end;

                trigger OnPreDataItem()
                begin
                    SetFilter("Date of hire", '..%1', EndDate);
                    SetFilter("Expiration date", '%1..|%2', InitDate, 0D);
                end;
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(InitDate; InitDate)
                {
                    Caption = 'Fecha inicio';
                }
                field(EndDate; EndDate)
                {
                    Caption = 'Fecha fin';
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if InitDate = 0D then Error('InitDate');
        if EndDate = 0D then Error('EndDate');
    end;

    var
        CompanyInfo: Record "Company Information";
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        InitDate: Date;
        EndDate: Date;
        ContractDays: Integer;
}