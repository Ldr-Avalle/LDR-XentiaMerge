tableextension 50147 JobJournalLine_LDR extends "Job Journal Line"
{
    fields
    {
        modify("No.")
        {
            //todo:creo que hay que eliminarlo
            TableRelation = if (Type = const(Resource)) Resource
            else if (Type = const(Item)) Item where(Type = const(Inventory))
            else if (Type = const("G/L Account")) "G/L Account";
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
    }
}
