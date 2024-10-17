tableextension 50147 JobJournalLine_LDR extends "Job Journal Line"
{
    fields
    {
        modify("No.")
        {
            //todo:creo que hay que eliminarlo
            TableRelation = IF (Type = CONST(Resource)) Resource
            ELSE IF (Type = CONST(Item)) Item WHERE(Type = CONST(Inventory))
            ELSE IF (Type = CONST("G/L Account")) "G/L Account";
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
