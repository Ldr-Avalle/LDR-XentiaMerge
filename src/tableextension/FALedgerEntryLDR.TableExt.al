tableextension 50365 FALedgerEntry_LDR extends "FA Ledger Entry"
{
    fields
    {
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Grupo contable negocio';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Grupo contable producto';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Grupo registro IVA neg.';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'Grupo registro IVA prod.';
        }
        field(50000; Location; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Table ID" = CONST(5600),
                                                                                   "No." = FIELD("FA No."),
                                                                                   "Dimension Code" = CONST('UNIDADES PRODUCCIÓN')));
            Description = 'SERCABLE';

        }
    }
}
