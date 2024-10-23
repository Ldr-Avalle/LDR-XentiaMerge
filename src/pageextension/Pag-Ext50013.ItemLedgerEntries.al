pageextension 50013 "Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field("On Deposit"; Rec."On Deposit")
            {
                ApplicationArea = All;
                Caption = 'En Depósito';
                ToolTip = 'Indica si el artículo está en depósito.';
            }
        }
        modify("Serial No.")
        {
            Visible = true;
            ApplicationArea = All;
        }
    }

    actions
    {
        modify("Ent&ry")
        {
            Visible = MovimientoVisible;
        }
        modify("&Application")
        {
            Visible = LiquidacionVisible;
        }
        modify("F&unctions")
        {
            Visible = AccionesVisible;
        }
        modify("&Navigate")
        {
            Visible = NavegarVisible;
        }
    }

    trigger OnOpenPage()
    VAR
        UserDims: Record 50000;
        show: Boolean;
    BEGIN
        show := NOT UserDims.existsUser(USERID);
        MovimientoVisible := show;
        LiquidacionVisible := show;
        AccionesVisible := show;
        NavegarVisible := show;
    END;

    var
        MovimientoVisible: Boolean;
        LiquidacionVisible: Boolean;
        AccionesVisible: Boolean;
        NavegarVisible: Boolean;
}
