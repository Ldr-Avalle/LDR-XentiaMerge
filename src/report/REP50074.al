report 50074 IDI2
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/IDI2.rdl';

    dataset
    {
        dataitem(IDI; IDI_LDR)
        {
            CalcFields = Name, "First Family Name", "Second Family Name";
            DataItemTableView = SORTING(Employee, "Año", Mes)
                                ORDER(Ascending);
            RequestFilterFields = "Año", Mes, Employee;
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(IDiAnio; IDi."Año")
            {
            }
            column(IDiMes; IDi.Mes)
            {
            }
            column(IDiEmployee; IDi.Employee)
            {
            }
            column(IDiName; IDi.Name)
            {
            }
            column(IDiFirstFamilyName; IDi."First Family Name")
            {
            }
            column(IDiSecondFamilyName; IDi."Second Family Name")
            {
            }
            column(IDiCosteHorajust; IDi."Coste/Hora just.")
            {
            }
            column(IDiEmployee2; IDi.Employee)
            {
            }
            column(IDiName2; IDi.Name)
            {
            }
            column(IDiFirstFamilyName2; IDi."First Family Name")
            {
            }
            column(IDiSecondFamilyName2; IDi."Second Family Name")
            {
            }
            column(IDiCosteHorajust2; IDi."Coste/Hora just.")
            {
            }
            column(IDiCosteHorajust3; IDi."Coste/Hora just.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.CALCFIELDS(Picture);
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
        CompanyInfo: Record "79";
}

