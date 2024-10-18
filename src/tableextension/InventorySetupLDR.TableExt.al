tableextension 50202 InventorySetup_LDR extends "Inventory Setup"
{
    fields
    {
        field(50000; "Grupo contable producto"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "Gen. Product Posting Group";
        }
        field(50001; "Grupo contable inventario"; Code[20])
        {
            FieldClass = Normal;
            TableRelation = "Inventory Posting Group";
        }
    }
}