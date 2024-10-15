page 50024 "Contar facturas de venta"
{
    ApplicationArea = All;
    Caption = 'Contar facturas de venta';
    PageType = Card;
    SourceTable = "Sales Invoice Header";
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
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Customer No.', Comment = 'ESP="Factura-a Nº cliente"';
                    ToolTip = 'Especifica la factura-a nº cliente';
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