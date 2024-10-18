tableextension 50041 SalesInvoiceHeader_LDR extends "Sales Invoice Header"
{
    DataCaptionFields = "Customer Type";

    fields
    {
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Grupo contable negocio';
        }
        modify("Area")
        {
            Caption = 'Cód. provincia';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Grupo registro IVA neg.';
        }
        field(50000; "Descuento en factura"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line"."Inv. Discount Amount" where("Document No." = field("No.")));
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
        field(50001; "Descuento en factura %"; Decimal)
        {
            CalcFormula = lookup("Cust. Invoice Disc."."Discount %" where(Code = field("Bill-to Customer No.")));
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
        field(50002; "Pmt. Disc. Given Amount"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line"."Pmt. Discount Amount" where("Document No." = field("No.")));
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
        field(50004; InvoiceType; Option)
        {
            Caption = 'Tipo de factura';
            Description = 'SERCABLE';
            OptionMembers = OO,CO,OC,CC;
            trigger OnValidate()
            var
                Text0001: Label 'A copy can''t be requeasted without the original invoice signed.\Path: %1';
                Text0002: Label 'Original invoice digitally signed.\Path %1';
            begin
            end;
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
        field(50009; "Factura Simplificada"; Enum TbaiNS)
        {
            Caption = 'Factura Simplificada';
            Description = 'TBAI_AL_01 factura simplificada';
        }
        field(50010; "Factura Simplificada Sustituci"; Enum TbaiNS)
        {
            Caption = 'Factura emitida en sustitución de factura simplificada';
            Description = 'TBAI_AL_01 factura emitida en sustitución de factura simplificada';
        }
        field(50011; "Factura 3 o dest"; Enum Factura3oDest)
        {
            Caption = 'Factura emitida por tercero o por destinatario';
            Description = 'TBAI_AL_01 Factura emitida por tercero o por destinatario';
        }
        field(50012; "varios destinatarios"; Enum TbaiNS)
        {
            Caption = 'Varios destinatarios';
            Description = 'TBAI_AL_01 varios destinatarios';
        }
        field(50013; "factura rectificativa"; Enum TbaiFacturaRectificativa)
        {
            Caption = 'Factura rectificativa';
            Description = 'TBAI_AL_01 factura rectificativafactura rectificativa tipo';
        }
        field(50014; "factura rectificativa tipo"; Enum Tbais0SI)
        {
            Caption = 'Factura rectificativa tipo';
            Description = 'TBAI_AL_01 factura rectificativa tipo';
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
        field(50018; ClaveRegimenIvaOpTrascendencia; Enum TbaiClaveRegimenIvaOpTrascen)
        {
            Caption = 'Clave Regimen Iva Op Trascendencia';
            Description = 'TBAI_AL_01 ClaveRegimenIvaOpTrascendencia';
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
            TableRelation = "No. Series";
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
        field(50024; TipoRegistro; Enum TbaiTipoRegistro)
        {
            Caption = 'Tipo Registro TBAI';
            Description = 'TBAI_AL_01';
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
        key(Key14; "Document Date", "No.")
        {
        }
        key(Ke15; "VAT Bus. Posting Group")
        {
        }
    }

    trigger OnAfterInsert()
    begin
        Rec."Posting Hour" := Time;
    end;
}
