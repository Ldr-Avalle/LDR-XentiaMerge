report 50091 "Registrar justificacion"
{
    // Errors
    //   - 1: Horas justificadas no informadas
    //   - 2: Coste/Hora no informado
    //   - 3: L´Š¢neas que superan el m´Š¢ximo de horas mes de la configuraci´Š¢n
    //   - 4: L´Š¢neas que ya se han registrado anteriormente
    // 
    // Warnings
    //   - 1: Empleados que superan para un periodo (a´Š¢o/mes) el m´Š¢ximo de horas mes de la configuraci´Š¢n
    //   - 2: Empleados que a fecha del registro tienen fecha de terminaci´Š¢n informada
    //   - 3: Horas justificadas superiores a las presentadas

    ProcessingOnly = true;

    dataset
    {
        dataitem(IDI; IDI_LDR)
        {
            RequestFilterFields = Proyecto, "Año", Mes;

            trigger OnAfterGetRecord()
            var
                Employee: Record Employee;
                IDi2: Record IDI_LDR;
                Hours: Decimal;
            begin
                //Errors 1
                if "Horas just." <= 0 then Errors[1] += 1;

                //Errors 2
                if "Coste/Hora just." = 0 then Errors[2] += 1;

                //Errors 3
                if "Horas just." > JobSetup."Max. IDI hours per month" then Errors[3] += 1;

                //Errors 4
                if "Justification register date" <> 0D then Errors[4] += 1;

                //Warnings 1
                IDi2.SetFilter(Employee, '%1', IDI.Employee);
                IDi2.SetFilter("Año", '%1', IDI."Año");
                IDi2.SetFilter(Mes, '%1', IDI.Mes);
                if IDi2.FindFirst then
                    repeat
                        Hours += IDi2."Horas just.";
                    until IDi2.Next = 0;
                if Hours > JobSetup."Max. IDI hours per month" then Warnings[1] += 1;

                //Warnings 2
                if EmpTerminated = false then begin
                    Employee.Get(IDI.Employee);
                    if Employee."Termination Date" <= "Justification date" then EmpTerminated := true;
                end;

                //Warnings 3
                if "Horas just." > "Horas present." then Warnings[3] += 1;

                if OnlyCheck = false then begin
                    "Justification date" := JustificationDate;
                    "Justification register date" := Today;
                    Modify;
                end;
            end;

            trigger OnPostDataItem()
            var
                ErrorsExists: Boolean;
                i: Integer;
                Text0001: Label 'Informe de proceso\Errores:\  Horas justificadas no informadas: %1\  Coste-hora no informado: %2\  L´Š¢neas que superan %3 horas: %4\  L´Š¢neas que ya se han registrado anteriormente: %5\-\Advertencias:\  Empleados que superan %6 horas-periodo: %7\  Empleados con fecha terminaci´Š¢n: %8\  Horas justificadas superiores a las presentadas %9';
            begin
                ErrorsExists := false;
                for i := 1 to 4 do
                    if Errors[i] > 0 then ErrorsExists := true;

                if ErrorsExists then
                    Error(Text0001, Errors[1], Errors[2], JobSetup."Max. IDI hours per month", Errors[3], Errors[4], JobSetup."Max. IDI hours per month",
                    Warnings[1], EmpTerminated, Warnings[3])
                else
                    if OnlyCheck = false then
                        Message('Todos los registros han sido procesados')
                    else
                        Message('Prueba de registro ejecutada. No se han modificado datos');
            end;

            trigger OnPreDataItem()
            var
                Text0001: Label 'Se continua se registrar´Š¢n como justificados todos los datos de\Proyectos: %1\A´Š¢os: %2\Meses: %3';
            begin
                JobSetup.Get;
                JobSetup.TestField("Max. IDI hours per month");
                EmpTerminated := false;

                if (JustificationDate = 0D) or (IDI.GetFilter(Proyecto) = '') or (IDI.GetFilter("Año") = '')
                   or (IDI.GetFilter(Mes) = '') then
                    Error(Text0001);

                if OnlyCheck = false then
                    if Confirm(Text0001, false, GetFilter(Proyecto), GetFilter("Año"), GetFilter(Mes)) = false then CurrReport.Quit;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(JustificationDate; JustificationDate)
                {
                    Caption = 'Fecha justificación';
                }
                field(OnlyCheck; OnlyCheck)
                {
                    Caption = 'Test';
                    ToolTip = 'Ejecutará el proceso de registro de la justificación, sin hacer realmente el registro. Servir´Š¢ para hacer las comprobacioens previas al mismo.';
                }
            }
        }
    }

    var
        JustificationDate: Date;
        OnlyCheck: Boolean;
        Errors: array[5] of Integer;
        Warnings: array[5] of Integer;
        JobSetup: Record "Jobs Setup";
        EmpTerminated: Boolean;
        Text0001: Label 'Debe indicar la fecha de justificación, así como los filtros para Proyecto, Año y Mes.';
}

