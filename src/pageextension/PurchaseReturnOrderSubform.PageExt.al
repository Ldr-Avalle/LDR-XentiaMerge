pageextension 50071 "Purchase Return Order Subform" extends "Purchase Return Order Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Return Reason Code")
        {
            Visible = false;
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
            Visible = false;
        }
        modify("Line Discount %")
        {
            Visible = false;
        }
        modify("Qty. to Invoice")
        {
            Visible = false;
        }
        modify("Quantity Invoiced")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
    }
    var
        gbldimensiones: Record "User Dimensions_LDR";
}
