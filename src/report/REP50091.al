report 50091 "Registrar justificaci´Š¢n"
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
        dataitem(DataItem1000000000;Table50027)
        {
            RequestFilterFields = Proyecto,"A´Š¢o",Mes;

            trigger OnAfterGetRecord()
            var
                Employee: Record "5200";
                IDi2: Record "50027";
                Hours: Decimal;
            begin
                //Errors 1
                IF "Horas just." <= 0 THEN Errors[1] += 1;

                //Errors 2
                IF "Coste/Hora just." = 0 THEN Errors[2] += 1;

                //Errors 3
                IF "Horas just." > JobSetup."M´Š¢x. IDi hours per month" THEN Errors[3] += 1;

                //Errors 4
                IF "Justification register date" <> 0D THEN Errors[4] += 1;

                //Warnings 1
                IDi2.SETFILTER(Employee, '%1', IDi.Employee);
                IDi2.SETFILTER(A´Š¢o, '%1', IDi.A´Š¢o);
                IDi2.SETFILTER(Mes, '%1', IDi.Mes);
                IF IDi2.FINDFIRST THEN
                  REPEAT
                    Hours += IDi2."Horas just.";
                  UNTIL IDi2.NEXT = 0;
                IF Hours > JobSetup."M´Š¢x. IDi hours per month" THEN Warnings[1] += 1;

                //Warnings 2
                IF EmpTerminated = FALSE THEN BEGIN
                  Employee.GET(IDi.Employee);
                  IF Employee."Termination Date" <= "Justification date" THEN EmpTerminated := TRUE;
                END;

                //Warnings 3
                IF "Horas just." > "Horas present." THEN Warnings[3] += 1;

                IF OnlyCheck = FALSE THEN BEGIN
                  "Justification date" := JustificationDate;
                  "Justification register date" := TODAY;
                  MODIFY;
                END;
            end;

            trigger OnPostDataItem()
            var
                ErrorsExists: Boolean;
                i: Integer;
                Text0001: Label 'Informe de proceso\Errores:\  Horas justificadas no informadas: %1\  Coste-hora no informado: %2\  L´Š¢neas que superan %3 horas: %4\  L´Š¢neas que ya se han registrado anteriormente: %5\-\Advertencias:\  Empleados que superan %6 horas-periodo: %7\  Empleados con fecha terminaci´Š¢n: %8\  Horas justificadas superiores a las presentadas %9';
            begin
                ErrorsExists := FALSE;
                FOR i := 1 TO 4 DO BEGIN
                  IF Errors[i] > 0 THEN ErrorsExists := TRUE;
                END;

                IF ErrorsExists THEN
                  ERROR(Text0001,Errors[1],Errors[2],JobSetup."M´Š¢x. IDi hours per month",Errors[3],Errors[4],JobSetup."M´Š¢x. IDi hours per month",
                  Warnings[1],EmpTerminated, Warnings[3])
                ELSE
                  IF OnlyCheck = FALSE THEN MESSAGE('Todos los registros han sido procesados')
                  ELSE MESSAGE('Prueba de registro ejecutada. No se han modificado datos');
            end;

            trigger OnPreDataItem()
            var
                Text0001: Label 'Se continua se registrar´Š¢n como justificados todos los datos de\Proyectos: %1\A´Š¢os: %2\Meses: %3';
            begin
                JobSetup.GET;
                JobSetup.TESTFIELD("M´Š¢x. IDi hours per month");
                EmpTerminated := FALSE;

                IF (JustificationDate = 0D) OR (IDi.GETFILTER(Proyecto) = '') OR (IDi.GETFILTER(A´Š¢o) = '')
                   OR (IDi.GETFILTER(Mes) = '') THEN ERROR(Text0001);

                IF OnlyCheck = FALSE THEN
                  IF CONFIRM(Text0001, FALSE, GETFILTER(Proyecto), GETFILTER(A´Š¢o), GETFILTER(Mes)) = FALSE THEN CurrReport.QUIT;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(JustificationDate;JustificationDate)
                {
                    Caption = 'Fecha justificaci´Š¢n';
                }
                field(OnlyCheck;OnlyCheck)
                {
                    Caption = 'Test';
                    ToolTip = 'Ejecutar´Š¢ el proceso de registro de la justificaci´Š¢n, sin hacer realmente el registro. Servir´Š¢ para hacer las comprobacioens previas al mismo.';
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

    var
        JustificationDate: Date;
        OnlyCheck: Boolean;
        Errors: array [5] of Integer;
        Warnings: array [5] of Integer;
        JobSetup: Record "315";
        EmpTerminated: Boolean;
        Text0001: Label 'Debe indicar la fecha de justificaci´Š¢n, as´Š¢ como los filtros para Proyecto, A´Š¢o y Mes.';
}

