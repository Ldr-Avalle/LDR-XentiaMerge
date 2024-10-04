page 50020 "Works List"
{
    ApplicationArea = All;
    Caption = 'Lista de obras';
    PageType = Card;
    SourceTable = Work_LDR;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("No. of Contracts"; Rec."No. of Contracts")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }
}