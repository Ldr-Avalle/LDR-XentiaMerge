page 50006 "Cash Note List"
{
    ApplicationArea = All;
    Caption = 'Lista notas caja';
    CardPageID = "Cash Note Card";
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = "Cash Notes_LDR";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Caption = 'Date', Comment = 'ESP="Fecha"';
                    ToolTip = 'Especifica la fecha';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount', Comment = 'ESP="Cantidad"';
                    ToolTip = 'Especifica la cantidad';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Comment = 'ESP="Descripción"';
                    ToolTip = 'Especifica la descripción';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID', Comment = 'ESP="Id. usuario"';
                    ToolTip = 'Especifica el id. usuario';
                }
            }
        }
    }

    actions
    {
    }
}

