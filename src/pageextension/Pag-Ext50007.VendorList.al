pageextension 50007 "Vendor List" extends "Vendor List"
{
    layout
    {
        addlast(Control1)
        {
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
            }
            field("Retención"; Rec."Retención")
            {
                ApplicationArea = All;
            }
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
            }
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field("City"; Rec."City")
            {
                ApplicationArea = All;
            }
            field(Balance; Rec.Balance)
            {
                ApplicationArea = All;
            }
            field("Invoice Amounts"; Rec."Invoice Amounts")
            {
                ApplicationArea = All;
            }
            field("Cr. Memo Amounts"; Rec."Cr. Memo Amounts")
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
        gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
        IF gbldimensiones.FINDFIRST THEN BEGIN
            rec.SETFILTER("No. Series", '%1', 'PROV');
        END;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        IF UserDims.existsUser(USERID) THEN BEGIN
            rec.SETFILTER("No. Series", '%1', 'PROV');
            ProveedorVisible := FALSE;
            ComprasVisible := FALSE;
        end;
    end;

    Var
        UserDims: Record 50000;
        ProveedorVisible: Boolean;
        ComprasVisible: Boolean;
        gbldimensiones: Record 50000;
}
