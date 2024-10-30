pageextension 50007 "Vendor List_LDR" extends "Vendor List"
{
    layout
    {
        addlast(Control1)
        {
            field("Net Change_LDR"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("Retención"; Rec."Retención")
            {
                ApplicationArea = All;
            }
            field("VAT Registration No._LDR"; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
            }
            field(Address_LDR; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2_LDR"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field(City_LDR; Rec.City)
            {
                ApplicationArea = All;
            }
            field(Balance_LDR; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("Invoice Amounts_LDR"; Rec."Invoice Amounts")
            {
                ApplicationArea = All;
            }
            field("Cr. Memo Amounts_LDR"; Rec."Cr. Memo Amounts")
            {
                ApplicationArea = All;
            }
        }
        modify("Post Code")
        {
            ApplicationArea = All;
            Visible = true;
        }
    }
    actions
    {
        modify("Ven&dor")
        {
            Visible = ProveedorVisible;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify(DimensionsSingle)
        {
            Visible = false;
        }
        modify(DimensionsMultiple)
        {
            Visible = false;
        }
        modify("Bank Accounts")
        {
            Visible = false;
        }
        modify(OrderAddresses)
        {
            Visible = false;
        }
        modify("P&ayment Days")
        {
            Visible = false;
        }
        modify("Non-Pa&yment Periods")
        {
            Visible = false;
        }
        modify("Item Refe&rences")
        {
            Visible = false;
        }
        modify(Purchases)
        {
            Visible = ComprasVisible;
        }
        modify(Items)
        {
            Visible = false;
        }
        modify("Invoice &Discounts")
        {
            Visible = false;
        }
        modify(PriceLists)
        {
            Visible = false;
        }
        modify(DiscountLines)
        {
            Visible = false;
        }
        modify("Prepa&yment Percentages")
        {
            Visible = false;
        }
        modify(Quotes)
        {
            Visible = false;
        }
        modify("Blanket Orders")
        {
            Visible = false;
        }
    }
    trigger OnOpenPage()
    begin
        gbldimensiones.SetRange(gbldimensiones.Usuario, UserId);
        if gbldimensiones.FindFirst() then
            Rec.SetFilter("No. Series", '%1', 'PROV');
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if UserDims.existsUser(UserId) then begin
            Rec.SetFilter("No. Series", '%1', 'PROV');
            ProveedorVisible := false;
            ComprasVisible := false;
        end;
    end;

    var
        UserDims: Record "User Dimensions_LDR";
        ProveedorVisible: Boolean;
        ComprasVisible: Boolean;
        gbldimensiones: Record "User Dimensions_LDR";
}
