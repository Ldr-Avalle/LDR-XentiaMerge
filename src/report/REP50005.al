report 50005 "Contract exportation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Contract exportation.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table50005)
        {
            dataitem(DataItem1000000001;Table50006)
            {
                DataItemLink = Contract=FIELD(No.);
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
        Win.OPEN('#1##################\'+
                 '#2##################\'+
                 '@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

        TemplateName := 'PlantillaExportacionTelecable.xlsx';

        Excel.crearExcel(FALSE);
        IF FILE.EXISTS('C:\'+TemplateName) THEN FILE.ERASE('C:\'+TemplateName);
        FILE.COPY('\\NavSercable\Compartida\'+TemplateName, 'C:\'+TemplateName);
        Excel.abrirExcel('C:\'+TemplateName);
    end;

    var
        Excel: Record "50013";
        Win: Dialog;
        winCont: Integer;
        winRef: Integer;
        i: Integer;
}

