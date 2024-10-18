tableextension 50043 "SalesCrMemoHeader_LDR" extends "Sales Cr.Memo Header"
{
    DataCaptionFields = "Customer type";

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
            OptionMembers = "OR",CR;
        }
        field(50005; "Correction Method"; Option)
        {
            Description = 'SERCABLE';
            OptionMembers = "01","02","03","04";
        }
        field(50006; "Correction Method Description"; Option)
        {
            Description = 'SERCABLE';
            OptionMembers = "Rectificación íntegra","  Rectificación por diferencias ","  Rectificación por descuento por volumen de operaciones durante el periodo "," 04 Autorizadas por la Agencia Tributaria ";
        }
        field(50007; "Reason Description"; Text[100])
        {
            Description = 'SERCABLE';
        }
        field(50008; "Customer type"; Option)
        {
            Description = 'SERCABLE';
            OptionMembers = " ","Física","Jurídica";
        }
        field(50019; DocNoTBAI; Code[20])
        {
            Caption = 'No. Documento TBAI';
            Description = 'TBAI_AL_01 No. Documento TBAI';
            Editable = false;
        }
        field(50020; "No. SeriesTBAI"; Code[10])
        {
            Caption = 'No. Series TBAI';
            Description = 'TBAI_AL_01';
            Editable = false;
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
            Editable = false;
            OptionCaption = ' ,Envío, Anulación';
            OptionMembers = " ","Envío","Anulación";
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
        field(50101; "Posting Hour"; Time)
        {
            Description = 'TBAI_AL_01';
        }
    }
}