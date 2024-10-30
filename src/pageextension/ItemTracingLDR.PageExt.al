pageextension 50069 "Item Tracing_LDR" extends "Item Tracing"
{
    layout
    {
        modify(LotNoFilter)
        {
            Visible = LotNoFilterVisible;
        }
        modify(VariantFilter)
        {
            Visible = VariantFilterVisible;
        }
        modify(ShowComponents)
        {
            Visible = ShowComponentsVisible;
        }
    }
    trigger OnOpenPage()
    var
        UserDim: Record "User Dimensions_LDR";
    begin
        VariantFilterVisible := (not UserDim.existsUser(UserId));
        LotNoFilterVisible := (not UserDim.existsUser(UserId));
        ShowComponentsVisible := (not UserDim.existsUser(UserId));
    end;

    var
        VariantFilterVisible: Boolean;
        LotNoFilterVisible: Boolean;
        ShowComponentsVisible: Boolean;
}
