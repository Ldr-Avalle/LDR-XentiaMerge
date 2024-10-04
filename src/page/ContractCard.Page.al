page 50002 "Contract Card"
{
    ApplicationArea = All;
    Caption = 'Ficha contrato';
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "G/L Register CP_LDR";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = '"No."', Comment = 'ESP"Nº"';
                    ToolTip = 'Especifica el nº';
                }
                field("From Entry No."; Rec."From Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'From Entry No.', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    Caption = 'Journal Batch Name', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                field("From VAT Entry No."; Rec."From VAT Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'From VAT Entry No.', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                field("To VAT Entry No."; Rec."To VAT Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'To VAT Entry No.', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    Caption = 'Reversed', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                //TODO:PREGUNTAR A AITOR SI LOS AÑADO A LA TABLA DE LA QUE TIRA O LOS ELIMINO YA QUE NO LOS CONTIENE ACTUALMENTE ESTOS CAMPOS
                // field(Floor; Rec.Floor) 
                // {
                // }
                // field(CP; Rec.CP)
                // {
                // }
                // field(County; Rec.County)
                // {
                // }
                // field("Phone 1"; Rec."Phone 1")
                // {
                // }
                // field("Phone 2"; Rec."Phone 2")
                // {
                // }
                // field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                // {
                // }
                // field("Creation Date"; Rec."Creation Date")
                // {
                // }
                field("To Entry No."; Rec."To Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'To Entry No.', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    Caption = 'Source Code', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID', Comment = 'ESP""';
                    ToolTip = 'Especifica';
                }
            }
            part("Contract lines subform"; "Contract lines subform")
            {
                //SubPageLink = Contract = FIELD("No."); //TODO:REVISAR
            }
            group(Registro)
            {
                Caption = 'Registro';
                //TODO:PREGUNTAR A AITOR SI LOS AÑADO A LA TABLA DE LA QUE TIRA O LOS ELIMINO YA QUE NO LOS CONTIENE ACTUALMENTE ESTOS CAMPOS
                // field("SharePoint ID"; Rec."SharePoint ID")
                // {
                // }
                // field("SharePoint Created"; Rec."SharePoint Created")
                // {
                // }
                // field("SharePoint Created by ID"; Rec."SharePoint Created by ID")
                // {
                // }
                // field("SharePoint Created by"; Rec."SharePoint Created by")
                // {
                // }
                // field("SharePoint Modified"; Rec."SharePoint Modified")
                // {
                // }
                // field("SharePoint Modified by ID"; Rec."SharePoint Modified by ID")
                // {
                // }
                // field("SharePoint Modified by"; Rec."SharePoint Modified by")
                // {
                // }
                // field("NAV Created by"; Rec."NAV Created by")
                // {
                // }
                // field("Creation date"; Rec."Creation date")
                // {
                // }
                // field("Creation time"; Rec."Creation time")
                // {
                // }
                // field("NAV Modified by"; Rec."NAV Modified by")
                // {
                // }
                // field("Modification date"; Rec."Modification date")
                // {
                // }
                // field("Modification time"; Rec."Modification time")
                // {
                // }
            }
        }
    }
}