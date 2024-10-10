report 50004 "Employee aut. expirations"
{
    // //report de procesamiento utilizado para enviar un email con los usuarios
    // //sin contrato activo para darlos de baja principalmente en la intranet

    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000;Table5200)
        {
            DataItemTableView = SORTING(Name,First Family Name,Second Family Name)
                                ORDER(Ascending);
            RequestFilterFields = "Global Dimension 1 Code";

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Contract active");
                IF ("Contract active" = FALSE) THEN MARK(TRUE);
            end;

            trigger OnPostDataItem()
            var
                Mail: Codeunit "397";
                RRHHSetup: Record "5218";
                Body: Text[250];
                Fichero: File;
                FileName: Text[100];
                i: Integer;
                SheetName: Text[30];
            begin

                RRHHSetup.GET;
                RRHHSetup.TESTFIELD("Notification email title");

                //defino el cuerpo con saltos de l´Š¢nea
                Employee.MARKEDONLY(TRUE);
                i := 1;
                IF Employee.FINDFIRST THEN BEGIN
                  //creo el fichero
                  FileName := 'C:\BajasSercable.xlsx';
                  SheetName := 'Bajas';
                  Excel.crearExcel(FALSE);
                  Excel.nuevoWorkbook(SheetName);

                  //inserto cabecera Excel
                  Excel.nuevoValor(SheetName, 'A' + FORMAT(i), 'Empleado', TRUE, FALSE, FALSE, 10, 1, 2);
                  Excel.nuevoValor(SheetName, 'B' + FORMAT(i), 'Email empresa', TRUE, FALSE, FALSE, 10, 1, 2);
                  Excel.nuevoValor(SheetName, 'C' + FORMAT(i), 'Proyecto', TRUE, FALSE, FALSE, 10, 1, 2);

                  //insert empleados
                  REPEAT
                    i += 1;
                    Excel.nuevoValor(SheetName, 'A' + FORMAT(i), Employee.FullName, FALSE, FALSE, FALSE, 10, 1, 2);
                    Excel.nuevoValor(SheetName, 'B' + FORMAT(i), Employee."Company E-Mail", FALSE, FALSE, FALSE, 10, 1, 2);
                    Excel.nuevoValor(SheetName, 'C' + FORMAT(i), Employee."Global Dimension 1 Code", FALSE, FALSE, FALSE, 10, 1, 2);

                    //aplico la fecha de notificaci´Š¢n al empleado
                    Employee."Aut. notification date" := TODAY;
                    Employee.MODIFY;
                  UNTIL Employee.NEXT = 0;

                  //ajusto columnas
                  Excel.ajustarColumnas(SheetName,1,50);
                  Excel.ajustarColumnas(SheetName,2,50);
                  Excel.ajustarColumnas(SheetName,3,50);

                  //almaceno el fichero
                  IF FILE.EXISTS(FileName) THEN FILE.ERASE(FileName);
                  Excel.guardarComo(FileName);
                  Excel.cerrarExcel(2);

                  //env´Š¢o el email
                  //NewMessage(ToName : Text[80];CCName : Text[80];Subject : Text[260];Body : Text[260];AttachFileName : Text[260];OpenDialog : Boolean) MailSent //funci´Š¢n en 2009
                  //Mail.NewMessage(RRHHSetup."Notification email", '', 'Bajas Sercable ' + FORMAT(TODAY), 'Ver fichero adjunto', FileName, FALSE);

                  //NewMessage(ToAddresses : Text;CcAddresses : Text;BccAddresses : Text;Subject : Text;Body : Text;AttachFilename : Text;ShowNewMailDialogOnSend : Boolean) : Boolean //funci´Š¢n en 2016
                  Mail.NewMessage(RRHHSetup."Notification email",'','','Bajas Sercable ' + FORMAT(TODAY),'Ver fichero adjunto',FileName, FALSE);
                END;

                //destruyo el fichero
                IF FILE.EXISTS(FileName) THEN FILE.ERASE(FileName);
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Company E-Mail", '<>%1', '');
                SETFILTER("Aut. notification date", '%1', 0D);
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
        Excel: Record "50013";
        i: Integer;
}

