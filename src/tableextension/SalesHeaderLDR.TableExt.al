tableextension 50220 "SalesHeader_LDR" extends "Sales Header"
{
    DataCaptionFields = "Document Type";

    fields
    {
        field(50009; "Factura Simplificada"; Option)
        {
            Caption = 'Factura Simplificada';
            Description = 'TBAI_AL_01 factura simplificada';
            OptionCaption = '';
            OptionMembers = ticket;
        }
        field(50099; FacturaFin; Code[20])
        {
        }
        field(50100; SendToTicketBAI; Boolean)
        {
            Caption = 'Enviar Factura a Ticket BAI';
            Description = 'TBAI_AL_01';
        }
    }
}