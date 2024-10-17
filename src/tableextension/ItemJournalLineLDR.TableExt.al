tableextension 50529 ItemJournalLine_LDR extends "Item Journal Line"
{
    fields
    {
        modify(Description)
        {
            Description = 'SERCABLE';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Grupo contable negocio';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Grupo contable producto';
        }
        modify("Area")
        {
            Caption = 'Cód. provincia';
        }
        field(50000; "On Deposit"; Boolean)
        {
            Description = 'SERCABLE';
        }
    }
}
