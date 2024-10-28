pageextension 50049 "Inventory Setup" extends "Inventory Setup"
{
    layout
    {
        addafter("Prevent Negative Inventory")
        {
            field("Grupo contable producto"; Rec."Grupo contable producto")
            {
                ApplicationArea = All;
            }
            field("Grupo contable inventario"; Rec."Grupo contable inventario")
            {
                ApplicationArea = All;
            }
        }
    }
}
