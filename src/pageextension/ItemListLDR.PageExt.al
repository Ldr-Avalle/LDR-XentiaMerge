pageextension 50012 "Item List_LDR" extends "Item List"
{
    layout
    {
        addafter("Created From Nonstock Item")
        {
            field("On Deposit_LDR"; Rec."On Deposit")
            {
                ApplicationArea = All;
                Caption = 'En Depósito';
                ToolTip = 'Indica si el artículo está en depósito.';
            }
            field("Net Invoiced Qty._LDR"; Rec."Net Invoiced Qty.")
            {
                ApplicationArea = All;
                Caption = 'Cantidad Facturada Neta';
                ToolTip = 'Cantidad neta facturada del artículo.';
            }
            field(Inventory_LDR; Rec.Inventory)
            {
                ApplicationArea = All;
                Caption = 'Inventario';
                ToolTip = 'Indica si el artículo es un artículo de inventario.';
            }
            /*
            field("Location Filter_LDR"; Rec."Location Filter")
            {
                ApplicationArea = All;
                Caption = 'Filtro de Ubicación';
                ToolTip = 'Filtro de ubicación del artículo.';
            }
            */
        }
        addafter("Substitutes Exist")
        {
            /*
            field("Global Dimension 1 Filter_LDR"; Rec."Global Dimension 1 Filter")
            {
                ApplicationArea = All;
                Caption = 'Proyecto';
                ToolTip = 'Proyecto del artículo.';
            }
            */
        }
        addafter("Assembly BOM")
        {
            field("Global Dimension 1 Code_LDR"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Proyecto';
                ToolTip = 'Proyecto del artículo.';
            }
        }
    }
    actions
    {
        modify(Availability)
        {
            Visible = false;
        }
        modify("Items b&y Location")
        {
            Visible = false;
        }
        modify("&Item Availability by")
        {
            Visible = false;
        }
        modify("Assembly/Production")
        {
            Visible = false;
        }
        modify(History)
        {
            Visible = false;
        }
        modify("E&ntries")
        {
            Visible = false;
        }
        modify(Statistics)
        {
            Visible = false;
        }
        modify(Sales)
        {
            Visible = false;
        }
        modify(Purchases)
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify("&Bin Contents")
        {
            Visible = false;
        }
        addafter("&Bin Contents")
        {
            action("Bin Contents_LDR")
            {
                ApplicationArea = Warehouse;
                Caption = 'Contenidos Ubicación';
                Image = BinContent;
                RunObject = page "Bin Content";
                RunPageLink = "Item No." = field("No."), "Unit of Measure Code" = field("Base Unit of Measure");
                RunPageView = sorting("Item No.");
                ToolTip = 'View the quantities of the item in each bin where it exists. You can see all the important parameters relating to bin content, and you can modify certain bin content parameters in this window.';
            }
        }
        modify("Stockkeepin&g Units")
        {
            Visible = false;
        }
        modify(RequestApproval)
        {
            Visible = false;
        }
        modify(Functions)
        {
            Visible = false;
        }
        modify("Inventory - List")
        {
            Visible = true;
        }
    }
    trigger OnAfterGetRecord()
    var
        UserDim: Record "User Dimensions_LDR";
        Proyecto: Code[10];
    begin
        Proyecto := copystr(UserDim.getProjectDim(UserId), 1, 10);
        if Proyecto <> '' then
            Rec.SetFilter("Global Dimension 1 Code", '%1|%2', Proyecto, '');
    end;
}
