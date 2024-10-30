pageextension 50021 "Sales Invoice Subform_LDR" extends "Sales Invoice Subform"
{
    layout
    {
        modify("Type")
        {
            trigger OnBeforeValidate()
            begin
                Rec.ShowShortcutDimCode(ShortcutDimCode);
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                gbldimensiones.Reset();
                gbldimensiones.SetRange(gbldimensiones.Usuario, UserId);
                if gbldimensiones.FindFirst() then begin
                    Rec."Location Code" := gbldimensiones."Location Code";
                    Rec.Modify();
                    CurrPage.Update();
                end;
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
                RedistributeTotalsOnAfterValidate();
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
        Rec.Type := Rec.Type::Item;
    end;

    var
        gbldimensiones: Record "User Dimensions_LDR";
}
