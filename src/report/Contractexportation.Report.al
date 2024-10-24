report 50005 "Contract exportation"
{
    ApplicationArea = All;
    Caption = 'Contract exportation';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Contract exportation.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Register CP"; "G/L Register CP_LDR")
        {
            dataitem("Contract lines"; "Contract Lines_LDR")
            {
                DataItemLink = Contract = field("No.");
            }
        }
    }

    trigger OnPostReport()
    begin
        Excel.MostrarExcel(true);
        Win.Close();
    end;

    trigger OnPreReport()
    var
        TemplateName: Text[100];
    begin
        winCont := 1;
        Win.Open('#1##################\' + '#2##################\' + '@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');

        TemplateName := 'PlantillaExportacionTelecable.xlsx';

        Excel.CrearExcel(false);
        // IF FILE.EXISTS('C:\' + TemplateName) THEN FILE.ERASE('C:\' + TemplateName); //TODO:OnPrem
        // FILE.COPY('\\NavSercable\Compartida\' + TemplateName, 'C:\' + TemplateName);
        Excel.AbrirExcel('C:\' + TemplateName);
    end;

    var
        Excel: Record "Exp. Excel_LDR";
        Win: Dialog;
        winCont: Integer;
        winRef: Integer;
        i: Integer;
}