pageextension 50077 "Small Business Owner RC_LDR" extends "Small Business Owner RC"
{
    actions
    {
        addbefore("Bill Group - Export Factoring")
        {
            action(RemesaExportarN19_LDR)
            {
                ApplicationArea = All;
                Caption = 'Remesa - Exportar N19';
                RunObject = report "Bill group - Export N19";
                Image = Report;
            }
            action(RemesaExportarN32_LDR)
            {
                ApplicationArea = All;
                Caption = 'Remesa - Exportar N32';
                RunObject = report "Bill group - Export N32";
                Image = Report;
            }
            action(RemesaExportarN58_LDR)
            {
                ApplicationArea = All;
                Caption = 'Remesa - Exportar N58';
                RunObject = report "Bill group - Export N58";
                Image = Report;
            }
        }
    }
}
