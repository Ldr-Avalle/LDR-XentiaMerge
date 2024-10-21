report 50005 "Contract exportation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Contract exportation.rdl';

    dataset
    {
        dataitem("G/L Register CP"; "G/L Register CP_LDR")
        {
            dataitem("Contract lines"; "Contract lines_LDR")
            {
                DataItemLink = Contract = FIELD("No.");
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

    trigger OnPostReport()
    begin
        Excel.mostrarExcel(TRUE);
        Win.CLOSE;
    end;

    trigger OnPreReport()
    var
        TemplateName: Text[100];
    begin
        winCont := 1;
        Win.OPEN('#1##################\' +
                 '#2##################\' +
                 '@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

        TemplateName := 'PlantillaExportacionTelecable.xlsx';

        Excel.crearExcel(FALSE);
        //todo: esto no existe ahora, no se en que hay que convertirlo
        //IF FILE.EXISTS('C:\' + TemplateName) THEN FILE.ERASE('C:\' + TemplateName);
        //FILE.COPY('\\NavSercable\Compartida\' + TemplateName, 'C:\' + TemplateName);
        Excel.abrirExcel('C:\' + TemplateName);
    end;

    var
        Excel: Record "Exp. Excel_LDR";
        Win: Dialog;
        winCont: Integer;
        winRef: Integer;
        i: Integer;
}

