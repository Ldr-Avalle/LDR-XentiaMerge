pageextension 50076 "Bookkeeper Role Center_LDR" extends "Bookkeeper Role Center"
{
    actions
    {
        addafter("G/L Registers")
        {
            action(InformeRetenciones_LDR)
            {
                Caption = 'Informe de Retenciones';
                Image = Report;
                RunObject = report "Informe de retenciones";
                ApplicationArea = All;
            }
            action(AlbaranesCompraMes_LDR)
            {
                Caption = 'Albaranes compra facturados mes diferente';
                Image = Shipment;
                RunObject = report "Control albaranes compra";
                ApplicationArea = All;
            }
            action(AlbaranesSinFacturar_LDR)
            {
                Caption = 'Albaranes sin facturar';
                Image = Shipment;
                RunObject = report "Listado Albaranes Compra y dev";
                ApplicationArea = All;
            }
        }
        addafter("Bill Group - Export Formats")
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
