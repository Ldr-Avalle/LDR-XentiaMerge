tableextension 50200 SalesReceivablesSetup_LDR extends "Sales & Receivables Setup"
{

    fields
    {
        field(50000; "Automat. Tracking Unit Cost"; Boolean)
        {
            Caption = 'Automatizar Coste unitario por Nº serie';
            Description = 'SERCABLE';
        }
        field(50001; "Tracking Invoice Qty. Limit"; Boolean)
        {
            Caption = 'Facturación Unitaria en Prod. Seg.';
            Description = 'SERCABLE';
        }
    }
}
