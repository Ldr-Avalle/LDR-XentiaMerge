tableextension 50041 "SalesInvoiceHeader_LDR" extends "Sales Invoice Header"
{
    DataCaptionFields = "Customer Type";

    fields
    {
        field(50000; "Descuento en factura"; Decimal)
        {
            Description = 'SERCABLE';
        }
        field(50001; "Descuento en factura %"; Decimal)
        {
            Description = 'SERCABLE';
        }
        field(50002; "Pmt. Disc. Given Amount"; Decimal)
        {
            Description = 'SERCABLE';
        }
        field(50004; InvoiceType; Option)
        {
            Caption = 'Tipo de factura';
            Description = 'SERCABLE';
            OptionMembers = OO,CO,OC,CC;
        }
        field(50005; "Customer Type"; Option)
        {
            Caption = 'Tipo de cliente ';
            Description = 'Borrar, está en la ficha del cliente';
            OptionMembers = ,"Física"," Jurídica";
        }
        field(50006; "Start Date"; Date)
        {
            Description = 'SERCABLE';
        }
        field(50007; "End Date"; Date)
        {
            Description = 'SERCABLE';
        }
        field(50008; "Posting Hour"; Time)
        {
            Description = 'TBAI_AL_01';
        }
        field(50009; "Factura Simplificada"; Option)
        {
            Caption = 'Factura Simplificada';
            Description = 'TBAI_AL_01 factura simplificada';
            OptionCaption = '';
            OptionMembers = TbaiNS;
        }
        field(50010; "Factura Simplificada Sustituci"; Option)
        {
            Caption = 'Factura emitida en sustitución de factura simplificada';
            Description = 'TBAI_AL_01 factura emitida en sustitución de factura simplificada';
            OptionCaption = '';
            OptionMembers = TbaiNS;
        }
        field(50011; "Factura 3 o dest"; Option)
        {
            Caption = 'Factura emitida por tercero o por destinatario';
            Description = 'TBAI_AL_01 Factura emitida por tercero o por destinatario';
            OptionCaption = '';
            OptionMembers = Factura3oDest;
        }
        field(50012; "varios destinatarios"; Option)
        {
            Caption = 'Varios destinatarios';
            Description = 'TBAI_AL_01 varios destinatarios';
            OptionCaption = '';
            OptionMembers = TbaiNS;
        }
        field(50013; "factura rectificativa"; Option)
        {
            Caption = 'Factura rectificativa';
            Description = 'TBAI_AL_01 factura rectificativafactura rectificativa tipo';
            OptionCaption = '';
            OptionMembers = TbaiFacturaRectificativa;
        }
        field(50014; "factura rectificativa tipo"; Option)
        {
            Caption = 'Factura rectificativa tipo';
            Description = 'TBAI_AL_01 factura rectificativa tipo';
            OptionCaption = '';
            OptionMembers = TbaiNS;
        }
        field(50015; BaseRectificada; Decimal)
        {
            Caption = 'Base Rectificada';
            Description = 'TBAI_AL_01 ImporteRectificacionSustitutiva BaseRectificada';
        }
        field(50016; CuotaRectificada; Decimal)
        {
            Caption = 'Cuota Rectificada';
            Description = 'TBAI_AL_01 ImporteRectificacionSustitutiva CuotaRectificada';
        }
        field(50017; CuotaRecargoRectificada; Decimal)
        {
            Caption = 'Cuota Recargo Rectificada';
            Description = 'TBAI_AL_01 ImporteRectificacionSustitutiva CuotaRecargoRectificada';
        }
        field(50018; ClaveRegimenIvaOpTrascendencia; Option)
        {
            Caption = 'Clave Regimen Iva Op Trascendencia';
            Description = 'TBAI_AL_01 ClaveRegimenIvaOpTrascendencia';
            OptionCaption = '';
            OptionMembers = TbaiClaveRegimenIvaOpTrascen;
        }
        field(50019; DocNoTBAI; Code[20])
        {
            Caption = 'No. Documento TBAI';
            Description = 'TBAI_AL_01 No. Documento TBAI';
        }
        field(50020; "No. SeriesTBAI"; Code[10])
        {
            Caption = 'No. Series TBAI';
            Description = 'TBAI_AL_01';
            Editable = true;
        }
        field(50021; TBAIQRBlob; Blob)
        {
            Description = 'TBAI_AL_01 QRBLOB';
        }
        field(50022; R_Identificador_TBAI; Text[100])
        {
            Caption = 'Identificador TBAI';
            Description = 'TBAI_AL_01 identificador tbai';
        }
        field(50023; TBAI_Sended; Boolean)
        {
            Caption = 'Enviada a TBAI';
            Description = 'TBAI_AL_01 identificador tbai';
        }
        field(50024; TipoRegistro; Option)
        {
            Caption = 'Tipo Registro TBAI';
            Description = 'TBAI_AL_01';
            OptionCaption = '';
            OptionMembers = TbaiTipoRegistro;
        }
        field(50025; QR_CodeString; Text[200])
        {
            Description = 'TBAI_AL_01';
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
    keys
    {
        // key(Key14; "Document Date", "No.")
        // {
        // }
        // key(Ke15; "VAT Bus. Posting Group")
        // {
        // }
    }
}