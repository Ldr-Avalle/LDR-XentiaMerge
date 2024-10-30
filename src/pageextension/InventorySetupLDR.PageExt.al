pageextension 50049 "Inventory Setup_LDR" extends "Inventory Setup"
{
    layout
    {
        addafter("Prevent Negative Inventory")
        {
            field("Grupo contable producto_LDR"; Rec."Grupo contable producto")
            {
                ApplicationArea = All;
            }
            field("Grupo contable inventario_LDR"; Rec."Grupo contable inventario")
            {
                ApplicationArea = All;
            }
        }
    }
}
