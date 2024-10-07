page 50090 "IZERTIS: GL ENTRY"
{
    ApplicationArea = All;
    Caption = 'IZERTIS: GL ENTRY', Comment = 'ESP=""';
    PageType = List;
    Permissions = TableData "G/L Entry" = rimd;
    SourceTable = "G/L Entry";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Debit Amount', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Credit Amount', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Entry No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                    Caption = 'G/L Account No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                    Caption = 'Bal. Account No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Global Dimension 1 Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Global Dimension 2 Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    Caption = 'Source Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    ApplicationArea = All;
                    Caption = 'System-Created Entry', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Prior-Year Entry"; Rec."Prior-Year Entry")
                {
                    ApplicationArea = All;
                    Caption = 'Prior-Year Entry', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    Caption = 'Job No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Amount', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Business Unit Code"; Rec."Business Unit Code")
                {
                    ApplicationArea = All;
                    Caption = 'Business Unit Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    Caption = 'Journal Batch Name', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    Caption = 'Reason Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    ApplicationArea = All;
                    Caption = 'Gen. Posting Type', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'Gen. Bus. Posting Group', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'Gen. Prod. Posting Group', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                    Caption = 'Bal. Account Type', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                    Caption = 'Transaction No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Caption = 'Document Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'External Document No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    Caption = 'Source Type', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Caption = 'Source No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    Caption = 'No. Series', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    Caption = 'Tax Area Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    Caption = 'Tax Liable', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                    Caption = 'Tax Group Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Use Tax"; Rec."Use Tax")
                {
                    ApplicationArea = All;
                    Caption = 'Use Tax', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Bus. Posting Group', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Prod. Posting Group', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Additional-Currency Amount"; Rec."Additional-Currency Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Additional-Currency Amoun', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Add.-Currency Debit Amount"; Rec."Add.-Currency Debit Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Add.-Currency Debit Amount', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Add.-Currency Credit Amount"; Rec."Add.-Currency Credit Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Add.-Currency Credit Amount', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Close Income Statement Dim. ID"; Rec."Close Income Statement Dim. ID")
                {
                    ApplicationArea = All;
                    Caption = 'Close Income Statement Dim. ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    Caption = 'IC Partner Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    Caption = 'Reversed', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Reversed by Entry No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Reversed Entry No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = All;
                    Caption = 'G/L Account Name', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension Set ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Prod. Order No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("FA Entry Type"; Rec."FA Entry Type")
                {
                    ApplicationArea = All;
                    Caption = 'FA Entry Type', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("FA Entry No."; Rec."FA Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'FA Entry No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                // field("New G/L Account No."; Rec."New G/L Account No.") //TODO:REVISAR CAMPOS
                // { 

                // }
                // field("Old G/L Account No."; Rec."Old G/L Account No.")
                // {
                // }
                // field(Updated; Rec.Updated)
                // {
                // }
                field(Punteado; Rec.Punteado)
                {
                    ApplicationArea = All;
                    Caption = 'Punteado', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Unid producción"; Rec."Unid producción")
                {
                    ApplicationArea = All;
                    Caption = 'Unid producción', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(FacturaFin; Rec.FacturaFin)
                {
                    ApplicationArea = All;
                    Caption = 'FacturaFin', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Bill No."; Rec."Bill No.")
                {
                    ApplicationArea = All;
                    Caption = 'Bill No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }
}