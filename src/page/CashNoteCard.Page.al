page 50005 "Cash Note Card"
{
    ApplicationArea = All;
    Caption = 'Ficha anotaciones caja';
    PageType = Card;
    SourceTable = "Cash Notes_LDR";
    UsageCategory = Lists;

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
            }
        }
    }
}