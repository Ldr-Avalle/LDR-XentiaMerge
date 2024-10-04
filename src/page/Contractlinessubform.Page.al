page 50003 "Contract lines subform"
{
    ApplicationArea = All;
    Caption = 'Subform. líneas contrato', Comment = 'ESP=""';
    PageType = Card;
    SourceTable = "Contract Lines_LDR";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(repeater)
            {
                field(Service; Rec.Service)
                {
                    ApplicationArea = All;
                    Caption = 'Service', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Service name"; Rec."Service name")
                {
                    ApplicationArea = All;
                    Caption = 'Service name', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Activation date"; Rec."Activation date")
                {
                    ApplicationArea = All;
                    Caption = 'Activation date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Promotion; Rec.Promotion)
                {
                    ApplicationArea = All;
                    Caption = 'Promotion', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Export date"; Rec."Export date")
                {
                    ApplicationArea = All;
                    Caption = 'Export date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Clearance date"; Rec."Clearance date")
                {
                    ApplicationArea = All;
                    Caption = 'Clearance date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("SharePoint ID"; Rec."SharePoint ID")
                {
                    ApplicationArea = All;
                    Caption = 'SharePoint ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }
}