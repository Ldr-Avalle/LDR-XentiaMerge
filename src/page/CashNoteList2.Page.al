page 50046 "Cash Note List2"
{
    ApplicationArea = All;
    Caption = 'Lista notas caja';
    Editable = false;
    PageType = Card;
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
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }
}