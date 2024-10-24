pageextension 50021 "Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        modify("Type")
        {
            trigger OnBeforeValidate()
            begin
                rec.ShowShortcutDimCode(ShortcutDimCode);
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                gbldimensiones.RESET;
                gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
                IF gbldimensiones.FINDFIRST THEN BEGIN
                    Rec."Location Code" := gbldimensiones."Location Code";
                    rec.MODIFY;
                    CurrPage.UPDATE;
                END;
            end;
        }
        modify("Location Code")
        {
            Visible = true;
            ApplicationArea = All;
        }
        modify("Line Amount")
        {
            Visible = true;
            ApplicationArea = All;
            trigger OnAfterValidate()
            begin
                RedistributeTotalsOnAfterValidate;
            end;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
            ApplicationArea = All;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
            ApplicationArea = All;
        }
    }
    trigger OnNewRecord(BelowXrec: Boolean)
    begin
        rec.Type := rec.Type::Item;
    end;

    var
        gbldimensiones: Record 50000;
}
