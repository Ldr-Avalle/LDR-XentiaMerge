pageextension 50069 "Item Tracing" extends "Item Tracing"
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
        UserDim: Record 50000;
    begin
        VariantFilterVisible := (NOT UserDim.existsUser(USERID));
        LotNoFilterVisible := (NOT UserDim.existsUser(USERID));
        ShowComponentsVisible := (NOT UserDim.existsUser(USERID));
    end;

    var
        VariantFilterVisible: Boolean;
        LotNoFilterVisible: Boolean;
        ShowComponentsVisible: Boolean;
}
