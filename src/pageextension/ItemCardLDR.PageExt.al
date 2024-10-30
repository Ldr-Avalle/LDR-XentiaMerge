
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
            Visible = false;
        }
        modify("Item Category Code")
        {
            Visible = ItemCategoryCodeVisible;
        }
        modify("Service Item Group")
        {
            Visible = false;
        }
        modify("Blocked")
        {
            Editable = BlockedEditable;
        }
        modify("Last Date Modified")
        {
            Visible = LastDateModifiedVisible;
        }
        modify("Costing Method")
        {
            Visible = CostingMethodVisible;
        }
        modify("Cost is Adjusted")
        {
            Visible = CostisAdjustedVisible;
        }
        modify("Cost is Posted to G/L")
        {
            Visible = CostisPostedtoGLVisible;
        }
        modify("Standard Cost")
        {
            Visible = StandardCostVisible;
        }
        modify("Overhead Rate")
        {
            Visible = OverheadRateVisible;
        }
        modify("Indirect Cost %")
        {
            Visible = IndirectCostVisible;
        }
        modify("Last Direct Cost")
        {
            Visible = LastDirectCostVisible;
        }
        modify("Price/Profit Calculation")
        {
            Visible = PriceProfitCalculationVisible;
        }
        modify("Profit %")
        {
            Visible = ProfitVisible;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = GenProdPostingGroupVisible;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = VATProdPostingGroupVisible;
        }
        modify("Inventory Posting Group")
        {
            Visible = InventoryPostingGroupVisible;
        }
        modify("Sales Unit of Measure")
        {
            Visible = SalesUnitofMeasureVisible;
        }
        modify("Replenishment System")
        {
            Visible = ReplenishmentSystemVisible;
        }
        modify("Lead Time Calculation")
        {
            Visible = LeadTimeCalculationVisible;
        }
        modify("Vendor No.")
        {
            Visible = VendorNoVisible;
        }
        modify("Purch. Unit of Measure")
        {
            Visible = PurchUnitofMeasureVisible;
        }
        modify("Reordering Policy")
        {
            Visible = ReorderingPolicyVisible;
        }
        modify("Serial Nos.")
        {
            Visible = SerialNosVisible;
        }
        modify("Lot Nos.")
        {
            Visible = LotNosVisible;
        }
        addlast(Control61)
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
        addlast(Purchase)
        {
            field("On Deposit"; Rec."On Deposit")
            {
                ApplicationArea = All;
            }
            field("Quantity returns orders"; Rec."Quantity returns orders")
            {
                ApplicationArea = All;
            }
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

    var
        StandardCostVisible: Boolean;
        CostisAdjustedVisible: Boolean;
        CostisPostedtoGLVisible: Boolean;
        OverheadRateVisible: Boolean;
        IndirectCostVisible: Boolean;
        PriceProfitCalculationVisible: Boolean;
        ItemCategoryCodeVisible: Boolean;
        GenProdPostingGroupVisible: Boolean;
        VATProdPostingGroupVisible: Boolean;
        InventoryPostingGroupVisible: Boolean;
        SalesUnitofMeasureVisible: Boolean;
        ProfitVisible: Boolean;
        CostingMethodVisible: Boolean;
        ProductGroupCodeVisible: Boolean;
        LastDateModifiedVisible: Boolean;
        VendorNoVisible: Boolean;
        AutomaticExtTextsVisible: Boolean;
        ReorderingPolicyVisible: Boolean;
        LotNosVisible: Boolean;
        ReplenishmentSystemVisible: Boolean;
        PurchUnitofMeasureVisible: Boolean;
        LeadTimeCalculationVisible: Boolean;
        SerialNosVisible: Boolean;
        ShelfNoVisible: Boolean;
        LastDirectCostVisible: Boolean;
        UnitCostVisible: Boolean;
        BlockedEditable: Boolean;
        BaseUnitofMeasureEditable: Boolean;
        VentasVisible: Boolean;
        ComprasVisible: Boolean;
        AccionesVisible: Boolean;
}
