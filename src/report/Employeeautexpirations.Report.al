report 50004 "Employee aut. expirations"
{
    ApplicationArea = All;
    Caption = 'Employee aut. expirations';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting(Name, "First Family Name", "Second Family Name") order(ascending);
            RequestFilterFields = "Global Dimension 1 Code";

            trigger OnAfterGetRecord()
            begin
                CalcFields("Contract active");
                if ("Contract active" = false) then Mark(true);
            end;

            trigger OnPostDataItem()
            var
                Mail: Codeunit Mail;
                RRHHSetup: Record "Human Resources Setup";
                Body: Text[250];
                Fichero: File;
                FileName: Text[100];
                i: Integer;
                SheetName: Text[30];
            begin
                RRHHSetup.Get();
                RRHHSetup.TestField("Notification email title");

                Employee.MarkedOnly(true);
                i := 1;
                if Employee.FindFirst() then begin
                    FileName := 'C:\BajasSercable.xlsx';
                    SheetName := 'Bajas';
                    Excel.CrearExcel(false);
                    Excel.NuevoWorkbook(SheetName);

                    Excel.NuevoValor(SheetName, 'A' + Format(i), 'Empleado', true, false, false, 10, 1, 2);
                    Excel.NuevoValor(SheetName, 'B' + Format(i), 'Email empresa', true, false, false, 10, 1, 2);
                    Excel.NuevoValor(SheetName, 'C' + Format(i), 'Proyecto', true, false, false, 10, 1, 2);

                    repeat
                        i += 1;
                        Excel.NuevoValor(SheetName, 'A' + Format(i), Employee.FullName(), false, false, false, 10, 1, 2);
                        Excel.NuevoValor(SheetName, 'B' + Format(i), Employee."Company E-Mail", false, false, false, 10, 1, 2);
                        Excel.NuevoValor(SheetName, 'C' + Format(i), Employee."Global Dimension 1 Code", false, false, false, 10, 1, 2);

                        Employee."Aut. notification date" := Today;
                        Employee.Modify();
                    until Employee.Next() = 0;

                    Excel.AjustarColumnas(SheetName, 1, 50);
                    Excel.AjustarColumnas(SheetName, 2, 50);
                    Excel.AjustarColumnas(SheetName, 3, 50);

                    Excel.GuardarComo(FileName);
                    Excel.CerrarExcel(2);

                    Mail.CreateMessage(RRHHSetup."Notification email", '', '', 'Bajas Sercable ' + Format(Today), 'Ver fichero adjunto', false, false);
                    //Mail.AttachFile(FileName); //TODO:Onprem
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("Company E-Mail", '<>%1', '');
                SetFilter("Aut. notification date", '%1', 0D);
            end;
        }
    }

    var
        Excel: Record "Exp. Excel_LDR";
        i: Integer;
}