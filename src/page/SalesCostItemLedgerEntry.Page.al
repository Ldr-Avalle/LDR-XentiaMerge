page 50049 "SalesCost Item Ledger Entry"
{
    ApplicationArea = All;
    Caption = 'Análisis movs. venta prods. con nº serie';
    PageType = Card;
    SourceTable = "SaleCost Item Ledger Entry_LDR";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                Editable = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Entry No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                    Caption = 'Serial No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Sales Amount (Actual)"; Rec."Sales Amount (Actual)")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Amount (Actual)', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Purch. Rcpt. Cost"; Rec."Purch. Rcpt. Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Purch. Rcpt. Cost', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Purch. Inv. Cost"; Rec."Purch. Inv. Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Purch. Inv. Cost', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Consultar ventas y precios de compra")
            {
                ApplicationArea = All;
                Caption = 'Consultar ventas y precios de compra';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ItemLdgEntry: Record "Item Ledger Entry";
                    ItemLdgEntryPurchase: Record "Item Ledger Entry";
                    PurchRcptLine: Record "Purch. Rcpt. Line";
                    PurchInvLine: Record "Purch. Inv. Line" temporary;
                begin
                    if Confirm('Se crearón registros con movs. de prods. de venta con nº de serie y su precio de compra. ¿Continuar?') then begin
                        Rec.DeleteAll();
                        ItemLdgEntry.SetFilter("Serial No.", '<>%1', '');
                        ItemLdgEntry.SetFilter("Entry Type", '%1', ItemLdgEntry."Entry Type"::Sale);
                        ItemLdgEntry.SetFilter("Document Type", '%1', ItemLdgEntry."Document Type"::"Sales Invoice");
                        if ItemLdgEntry.FindFirst() then
                            repeat
                                Rec.Init();
                                Rec.TransferFields(ItemLdgEntry);

                                ItemLdgEntryPurchase.SetFilter("Item No.", '%1', ItemLdgEntry."Item No.");
                                ItemLdgEntryPurchase.SetFilter("Serial No.", '%1', ItemLdgEntry."Serial No.");
                                ItemLdgEntryPurchase.SetFilter("Entry Type", '%1', ItemLdgEntryPurchase."Entry Type"::Purchase);
                                ItemLdgEntryPurchase.SetFilter("Document Type", '%1', ItemLdgEntryPurchase."Document Type"::"Purchase Receipt");
                                if ItemLdgEntryPurchase.FindFirst() then begin
                                    PurchRcptLine.SetFilter("Document No.", '%1', ItemLdgEntryPurchase."Document No.");
                                    PurchRcptLine.SetFilter(Type, '%1', PurchRcptLine.Type::Item);
                                    PurchRcptLine.SetFilter("No.", '%1', ItemLdgEntryPurchase."Item No.");
                                    if PurchRcptLine.FindFirst() then begin
                                        Rec.Description := PurchRcptLine.Description;
                                        Rec."Purch. Rcpt. Cost" := PurchRcptLine."Unit Cost (LCY)";

                                        PurchInvLine.Reset();
                                        PurchRcptLine.GetPurchInvLines(PurchInvLine);
                                        if PurchInvLine.FindFirst() then Rec."Purch. Inv. Cost" := PurchInvLine."Unit Cost (LCY)";
                                    end;
                                end;

                                Rec.Insert(false);
                            until ItemLdgEntry.Next() = 0;
                    end;
                end;
            }
        }
    }
}