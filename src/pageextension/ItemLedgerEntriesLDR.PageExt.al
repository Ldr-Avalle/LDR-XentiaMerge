pageextension 50013 "Item Ledger Entries_LDR" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field("On Deposit_LDR"; Rec."On Deposit")
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
    var
        UserDims: Record "User Dimensions_LDR";
        show: Boolean;
    begin
        show := not UserDims.existsUser(UserId);
        MovimientoVisible := show;
        LiquidacionVisible := show;
        AccionesVisible := show;
        NavegarVisible := show;
    end;

    var
        MovimientoVisible: Boolean;
        LiquidacionVisible: Boolean;
        AccionesVisible: Boolean;
        NavegarVisible: Boolean;
}
