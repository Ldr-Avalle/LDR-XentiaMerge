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
                    Caption = 'Service', Comment = 'ESP="Servicio"';
                    ToolTip = 'Especifica el servicio';
                }
                field("Service name"; Rec."Service name")
                {
                    ApplicationArea = All;
                    Caption = 'Service name', Comment = 'ESP="Nombre servicio"';
                    ToolTip = 'Especifica el nombre servicio';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity', Comment = 'ESP="Cantidad"';
                    ToolTip = 'Especifica la cantidad';
                }
                field("Activation date"; Rec."Activation date")
                {
                    ApplicationArea = All;
                    Caption = 'Activation date', Comment = 'ESP="Fecha activación"';
                    ToolTip = 'Especifica la fecha activación';
                }
                field(Promotion; Rec.Promotion)
                {
                    ApplicationArea = All;
                    Caption = 'Promotion', Comment = 'ESP="Campaña"';
                    ToolTip = 'Especifica la campaña';
                }
                field("Export date"; Rec."Export date")
                {
                    ApplicationArea = All;
                    Caption = 'Export date', Comment = 'ESP="Fecha exportación"';
                    ToolTip = 'Especifica la fecha exportación';
                }
                field("Clearance date"; Rec."Clearance date")
                {
                    ApplicationArea = All;
                    Caption = 'Clearance date', Comment = 'ESP="Fecha liquidación"';
                    ToolTip = 'Especifica la fecha liquidación';
                }
                field("SharePoint ID"; Rec."SharePoint ID")
                {
                    ApplicationArea = All;
                    Caption = 'SharePoint ID', Comment = 'ESP="SharePoint ID"';
                    ToolTip = 'Especifica el sharePoint ID';
                }
            }
        }
    }
}