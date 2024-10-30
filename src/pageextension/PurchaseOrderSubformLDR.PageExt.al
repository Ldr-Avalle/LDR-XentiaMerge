pageextension 50027 "Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
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
    VAR
        UserDims: Record 50000;
        show: Boolean;
    BEGIN
        //nuevo
        show := NOT UserDims.existsUser(USERID);
        QtytoInvoiceVisible := show;
        QuantityInvoicedVisible := show;
    END;

    trigger OnAfterGetRecord()
    begin
        dimension3 := '';
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec.Type := rec.Type::Item;
    end;

    var
        QtytoInvoiceVisible: Boolean;
        QuantityInvoicedVisible: Boolean;
        gbldimensiones: Record 50000;
        dimension3: Code[30];
        dimension4: Code[30];

}
