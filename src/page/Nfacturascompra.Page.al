page 50023 "Nº facturas compra"
{
    ApplicationArea = All;
    Caption = 'Nº facturas compra';
    PageType = Card;
    SourceTable = "Purch. Inv. Header";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.', Comment = 'ESP="Nº"';
                    ToolTip = 'Especifica el nº';
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                    Caption = 'Pay-to Vendor No.', Comment = 'ESP="Pago-a Nº proveedor"';
                    ToolTip = 'Especifica el pago-a nº proveedor';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date', Comment = 'ESP="Fecha registro"';
                    ToolTip = 'Especifica la fecha registro';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(action)
            {
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.FindFirst() then
                        Numero := Rec.Count;
                    Message(Format(Numero));
                end;
            }
        }
    }

    var
        Numero: Integer;
}