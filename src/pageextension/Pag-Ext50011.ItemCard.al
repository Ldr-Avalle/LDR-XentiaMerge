/*
pageextension 50011 "Item Card" extends "Item Card"
{
    layout
    {
        modify(Purchase)
        {
            Visible = ComprasVisible;
        }
        modify("Prices & Sales")
        {
            Visible = VentasVisible;
        }
        modify("Base Unit of Measure")
        {
            Editable = BaseUnitofMeasureEditable;
        }
        modify("Shelf No.")
        {
            Visible = ShelfNoVisible;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = AutomaticExtTextsVisible;
        }
        modify("Created From Nonstock Item")
        {
            Visible = CreatedFromNonstockItemVisible;
        }
        modify("Item Category Code")
        {
            Visible = ItemCategoryCodeVisible;
        }
    }
    trigger OnAfterGetRecord()
    var
        UserDim: Record 50000;
        Proyecto: Code[10];
    begin
        Proyecto := UserDim.getProjectDim(USERID);
        IF Proyecto <> '' THEN
            rec.SETFILTER("Global Dimension 1 Code", '%1|%2', Proyecto, '');
    end;

    trigger OnAfterGetCurrRecord()
    var
        show: Boolean;
        UserDims: Record 50000;
    begin
        show := NOT UserDims.existsUser(USERID);

        StandardCostVisible := show;
        CostisAdjustedVisible := show;
        CostisPostedtoGLVisible := show;
        OverheadRateVisible := show;
        IndirectCostVisible := show;
        PriceProfitCalculationVisible := show;
        ItemCategoryCodeVisible := show;
        GenProdPostingGroupVisible := show;
        VATProdPostingGroupVisible := show;
        InventoryPostingGroupVisible := show;
        SalesUnitofMeasureVisible := show;
        ProfitVisible := show;
        CostingMethodVisible := show;
        ProductGroupCodeVisible := show;
        LastDateModifiedVisible := show;
        VendorNoVisible := show;
        AutomaticExtTextsVisible := show;
        ReorderingPolicyVisible := show;
        LotNosVisible := show;
        ReplenishmentSystemVisible := show;
        PurchUnitofMeasureVisible := show;
        LeadTimeCalculationVisible := show;
        SerialNosVisible := show;
        ShelfNoVisible := show;
        LastDirectCostVisible := show;
        UnitCostVisible := show;
        BlockedEditable := show;
        BaseUnitofMeasureEditable := show;
        VentasVisible := show;
        ComprasVisible := show;
        AccionesVisible := show;
    end;
}
*/