page 50045 "Cash Note Card2"
{
    ApplicationArea = All;
    Caption = 'Ficha anotaciones caja';
    PageType = Card;
    SourceTable = "Cash Notes_LDR";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Caption = 'Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Comment = 'ESP="Descripción"';
                    ToolTip = 'Especifica la descripción';
                }
            }
        }
    }
}