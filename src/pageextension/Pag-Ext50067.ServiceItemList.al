pageextension 50067 "Service Item List" extends "Service Item List"
{
    layout
    {
        addafter(Description)
        {
            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field(Segment; Rec.Segment)
            {
                ApplicationArea = All;
            }
            field(Type; Rec.Type)
            {
                ApplicationArea = All;
            }
            field(Commission; Rec.Commission)
            {
                ApplicationArea = All;
            }
            field("Category Code"; Rec."Category Code")
            {
                ApplicationArea = All;
            }
            field("Services per unit"; Rec."Services per unit")
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
            action("Com&ponentes List")
            {
                ApplicationArea = Service;
                Caption = 'Lista Componentes';
                Image = Components;
                RunObject = Page 50011;
                RunPageLink = Service = FIELD("No.");
                ToolTip = 'View components that are used in the service item.';
            }
        }
        addbefore("Service Item Lo&g")
        {
            action(Historial)
            {
                ApplicationArea = Service;
                Caption = 'Historial';
                Image = Log;
                RunObject = Page 50010;
                RunPageLink = Service = FIELD("No.");
                ToolTip = 'View the history.';
            }
        }
    }
}
