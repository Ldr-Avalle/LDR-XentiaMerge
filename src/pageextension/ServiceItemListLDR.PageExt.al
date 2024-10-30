pageextension 50067 "Service Item List_LDR" extends "Service Item List"
{
    layout
    {
        addafter(Description)
        {
            field("Shortcut Dimension 1 Code_LDR"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field(Segment_LDR; Rec.Segment)
            {
                ApplicationArea = All;
            }
            field(Type_LDR; Rec.Type)
            {
                ApplicationArea = All;
            }
            field(Commission_LDR; Rec.Commission)
            {
                ApplicationArea = All;
            }
            field("Category Code_LDR"; Rec."Category Code")
            {
                ApplicationArea = All;
            }
            field("Services per unit_LDR"; Rec."Services per unit")
            {
                ApplicationArea = All;
            }
        }
        modify(Blocked)
        {
            ApplicationArea = All;
            Visible = true;
        }
    }
    actions
    {
        modify("Com&ponent List")
        {
            Visible = false;
        }
        addafter("Com&ponent List")
        {
            action("Com&ponentes List_LDR")
            {
                ApplicationArea = Service;
                Caption = 'Lista Componentes';
                Image = Components;
                RunObject = page "Service components";
                RunPageLink = Service = field("No.");
                ToolTip = 'View components that are used in the service item.';
            }
        }
        addbefore("Service Item Lo&g")
        {
            action(Historial_LDR)
            {
                ApplicationArea = Service;
                Caption = 'Historial';
                Image = Log;
                RunObject = page "Service item historic";
                RunPageLink = Service = field("No.");
                ToolTip = 'View the history.';
            }
        }
    }
}
