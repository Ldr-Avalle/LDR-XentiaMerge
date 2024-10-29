pageextension 50077 "Small Business Owner RC" extends "Small Business Owner RC"
{
    actions
    {
        addbefore("Bill Group - Export Factoring")
        {
            action(RemesaExportarN19)
            {
                ApplicationArea = All;
                Caption = 'Remesa - Exportar N19';
                RunObject = report 7000092;
                Image = Report;
            }
            action(RemesaExportarN32)
            {
                ApplicationArea = All;
                Caption = 'Remesa - Exportar N32';
                RunObject = report 7000093;
                Image = Report;
            }
            action(RemesaExportarN58)
            {
                ApplicationArea = All;
                Caption = 'Remesa - Exportar N58';
                RunObject = report 7000091;
                Image = Report;
            }
        }
    }
}
