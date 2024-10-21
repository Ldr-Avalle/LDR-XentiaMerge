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
            CalcFormula = lookup("Default Dimension"."Dimension Value Code" where("Table ID" = const(5600),
                                                                                   "No." = field("FA No."),
                                                                                   "Dimension Code" = const('UNIDADES PRODUCCIÓN')));
            Description = 'SERCABLE';

        }
    }
}
