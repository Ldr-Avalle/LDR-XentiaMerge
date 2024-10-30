pageextension 50006 "Vendor Card_LDR" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("No. Series_LDR"; Rec."No. Series")
            {
                ApplicationArea = All;
            }
            field("Retención"; Rec."Retención")
            {
                ApplicationArea = All;
            }
            field("No.Cuenta_LDR"; Rec."No.Cuenta")
            {
                ApplicationArea = All;
            }
            field("Net Change_LDR"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("Excluir del 347_LDR"; Rec."Excluir del 347")
            {
                ApplicationArea = All;
            }
        }
    }
}
