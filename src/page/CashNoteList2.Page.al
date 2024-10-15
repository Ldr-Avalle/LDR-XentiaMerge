page 50046 "Cash Note List2"
{
    ApplicationArea = All;
    Caption = 'Lista notas caja';
    Editable = false;
    PageType = Card;
    SourceTable = "Cash Notes_LDR";
    UsageCategory = Administration;

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
                    Caption = 'Date', Comment = 'ESP="Fecha"';
                    ToolTip = 'Especifica la fecha';
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
                    Caption = 'User ID';
                    ToolTip = 'Especifica el user id';
                }
            }
        }
    }
}