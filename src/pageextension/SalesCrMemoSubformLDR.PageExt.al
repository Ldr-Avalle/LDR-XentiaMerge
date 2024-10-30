pageextension 50031 "Sales Cr. Memo Subform_LDR" extends "Sales Cr. Memo Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Serial No._LDR"; Rec."Serial No.")
            {
                ApplicationArea = All;
            }
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                gbldimensiones.RESET();
                gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
                IF gbldimensiones.FINDFIRST() THEN BEGIN
                    Rec."Location Code" := gbldimensiones."Location Code";
                    rec.MODIFY();
                    CurrPage.UPDATE();
                END;
            end;
        }
    }
    var
        gbldimensiones: Record 50000;
}
