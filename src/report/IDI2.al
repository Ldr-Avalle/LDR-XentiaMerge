report 50074 IDI2
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/IDI2.rdl';

    dataset
    {
        dataitem(IDI; IDI_LDR)
        {
            CalcFields = Name, "First Family Name", "Second Family Name";
            DataItemTableView = sorting(Employee, "Año", Mes)
                                order(ascending);
            RequestFilterFields = "Año", Mes, Employee;
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(IDiAnio; IDI."Año")
            {
            }
            column(IDiMes; IDI.Mes)
            {
            }
            column(IDiEmployee; IDI.Employee)
            {
            }
            column(IDiName; IDI.Name)
            {
            }
            column(IDiFirstFamilyName; IDI."First Family Name")
            {
            }
            column(IDiSecondFamilyName; IDI."Second Family Name")
            {
            }
            column(IDiCosteHorajust; IDI."Coste/Hora just.")
            {
            }
            column(IDiEmployee2; IDI.Employee)
            {
            }
            column(IDiName2; IDI.Name)
            {
            }
            column(IDiFirstFamilyName2; IDI."First Family Name")
            {
            }
            column(IDiSecondFamilyName2; IDI."Second Family Name")
            {
            }
            column(IDiCosteHorajust2; IDI."Coste/Hora just.")
            {
            }
            column(IDiCosteHorajust3; IDI."Coste/Hora just.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CalcFields(Picture);
            end;
        }
    }

    var
        CompanyInfo: Record "Company Information";
}

