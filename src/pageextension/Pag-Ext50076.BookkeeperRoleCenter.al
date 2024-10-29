pageextension 50076 "Bookkeeper Role Center" extends "Bookkeeper Role Center"
{
    actions
    {
        addafter("G/L Registers")
        {
            action(InformeRetenciones)
            {
                Caption = 'Informe de Retenciones';
                Image = Report;
                RunObject = report 50040;
            }
            action(AlbaranesCompraMes)
            {
                Caption = 'Albaranes compra facturados mes diferente';
                Image = Shipment;
                RunObject = report 50090;
            }
            action(AlbaranesSinFacturar)
            {
                Caption = 'Albaranes sin facturar';
                Image = Shipment;
                RunObject = report 50057;
            }
        }
        addafter("Bill Group - Export Formats")
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
