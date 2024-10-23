tableextension 50121 "GLEntry_LDR" extends "G/L Entry"
{
    fields
    {
        field(50001; Punteado; Boolean)
        {
            Caption = 'Punteado';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50002; "Unid producción"; Code[20])
        {
            Caption = 'Unid. producción';
            DataClassification = ToBeClassified;
            Description = 'Sercable, rev flowfilter';
        }
        field(50098; "Transaction No.Copy"; Integer)
        {
            Caption = 'Transaction no.bk';
            DataClassification = ToBeClassified;
        }
        field(50099; FacturaFin; Code[20])
        {
            Caption = 'Factura Fin';
            DataClassification = ToBeClassified;
        }
        field(99998; NumAsientoPer; Integer)
        {
            Caption = 'Nº Asiento Per.';
        }
        field(99999; FechaRegistro45; Date)
        {
            Caption = 'Fecha Registro 45';
        }
    }
    keys
    {
        // key(Key20; "G/L Account No.", "Document Date", "Document No.")
        // {
        // }
        // key(Key21; "G/L Account No.", "Source No.")
        // {
        //     SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        // }
    }
}