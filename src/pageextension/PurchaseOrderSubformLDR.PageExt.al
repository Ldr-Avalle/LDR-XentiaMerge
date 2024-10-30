pageextension 50027 "Purchase Order Subform_LDR" extends "Purchase Order Subform"
{
    layout
    {
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
        modify("Qty. to Invoice")
        {
            ApplicationArea = All;
            Visible = QtytoInvoiceVisible;
        }
        modify("Quantity Invoiced")
        {
            ApplicationArea = All;
            Visible = QuantityInvoicedVisible;
        }
        modify(ShortcutDimCode3)
        {
            Visible = true;
        }
        modify(ShortcutDimCode4)
        {
            Visible = true;
        }
    }
    trigger OnOpenPage()
    var
        UserDims: Record "User Dimensions_LDR";
        show: Boolean;
    begin
        //nuevo
        show := not UserDims.existsUser(UserId);
        QtytoInvoiceVisible := show;
        QuantityInvoicedVisible := show;
    end;

    trigger OnAfterGetRecord()
    begin
        dimension3 := '';
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Type := Rec.Type::Item;
    end;

    var
        QtytoInvoiceVisible: Boolean;
        QuantityInvoicedVisible: Boolean;
        gbldimensiones: Record "User Dimensions_LDR";
        dimension3: Code[30];
    //dimension4: Code[30];

}
