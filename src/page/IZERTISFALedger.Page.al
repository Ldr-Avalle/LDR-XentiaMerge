page 50091 "IZERTIS: FA Ledger"
{
    ApplicationArea = All;
    Caption = 'IZERTIS: FA Ledger', Comment = 'ESP=""';
    PageType = List;
    Permissions = tabledata "FA Ledger Entry" = rimd;
    SourceTable = "FA Ledger Entry";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Debit Amount', Comment = 'ESP="Importe debe"';
                    ToolTip = 'Especifica el importe debe';
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Credit Amount', Comment = 'ESP="Importe haber"';
                    ToolTip = 'Especifica el importe haber';
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                    Caption = 'Reversed', Comment = 'ESP="Revertido"';
                    ToolTip = 'Especifica el revertido';
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Reversed by Entry No.', Comment = 'ESP="Revertido por el movimiento nº"';
                    ToolTip = 'Especifica el revertido por el movimiento nº';
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Reversed Entry No.', Comment = 'ESP="Nº movimiento revertido"';
                    ToolTip = 'Especifica el nº movimiento revertido';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Entry No.', Comment = 'ESP="Nº mov."';
                    ToolTip = 'Especifica el nº mov.';
                }
                field("G/L Entry No."; Rec."G/L Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'G/L Entry No.', Comment = 'ESP="Nº mov. contabilidad"';
                    ToolTip = 'Especifica el nº mov. contabilidad';
                }
                field("FA No."; Rec."FA No.")
                {
                    ApplicationArea = All;
                    Caption = 'FA No.', Comment = 'ESP="A/F Nº"';
                    ToolTip = 'Especifica el A/F Nº';
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'FA Posting Date', Comment = 'ESP="A/F Fecha registro"';
                    ToolTip = 'Especifica el A/F Fecha registro';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date', Comment = 'ESP="Fecha registro"';
                    ToolTip = 'Especifica la fecha registro';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type', Comment = 'ESP="Tipo documento"';
                    ToolTip = 'Especifica el tipo documento';
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Caption = 'Document Date', Comment = 'ESP="Fecha emisión documento"';
                    ToolTip = 'Especifica la fecha emisión documento';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.', Comment = 'ESP="Nº documento"';
                    ToolTip = 'Especifica el nº documento';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'External Document No.', Comment = 'ESP="Nº documento externo"';
                    ToolTip = 'Especifica el nº documento externo';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Description', Comment = 'ESP="Descripción"';
                    ToolTip = 'Especifica la descripción';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                    Caption = 'Depreciation Book Code', Comment = 'ESP="Cód. libro amortización"';
                    ToolTip = 'Especifica el cód. libro amortización';
                }
                field("FA Posting Category"; Rec."FA Posting Category")
                {
                    ApplicationArea = All;
                    Caption = 'FA Posting Category', Comment = 'ESP="A/F Categoría registro"';
                    ToolTip = 'Especifica';
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    ApplicationArea = All;
                    Caption = 'FA Posting Type', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Reclassification Entry"; Rec."Reclassification Entry")
                {
                    ApplicationArea = All;
                    Caption = 'Reclassification Entry', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Part of Book Value"; Rec."Part of Book Value")
                {
                    ApplicationArea = All;
                    Caption = 'Part of Book Value', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Part of Depreciable Basis"; Rec."Part of Depreciable Basis")
                {
                    ApplicationArea = All;
                    Caption = 'Part of Depreciable Basis', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Disposal Calculation Method"; Rec."Disposal Calculation Method")
                {
                    ApplicationArea = All;
                    Caption = 'Disposal Calculation Method', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Disposal Entry No."; Rec."Disposal Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Disposal Entry No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("No. of Depreciation Days"; Rec."No. of Depreciation Days")
                {
                    ApplicationArea = All;
                    Caption = 'No. of Depreciation Days', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("FA No./Budgeted FA No."; Rec."FA No./Budgeted FA No.")
                {
                    ApplicationArea = All;
                    Caption = 'FA No./Budgeted FA No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    ApplicationArea = All;
                    Caption = 'FA Subclass Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("FA Location Code"; Rec."FA Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'FA Location Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("FA Posting Group"; Rec."FA Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'FA Posting Group', Comment = 'ESP=""';
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Depreciation Method"; Rec."Depreciation Method")
                {
                    ApplicationArea = All;
                    Caption = 'Depreciation Method', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Depreciation Starting Date"; Rec."Depreciation Starting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Depreciation Starting Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Straight-Line %"; Rec."Straight-Line %")
                {
                    ApplicationArea = All;
                    Caption = 'Straight-Line %', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("No. of Depreciation Years"; Rec."No. of Depreciation Years")
                {
                    ApplicationArea = All;
                    Caption = 'No. of Depreciation Years', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Fixed Depr. Amount"; Rec."Fixed Depr. Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Depr. Amount', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Declining-Balance %"; Rec."Declining-Balance %")
                {
                    ApplicationArea = All;
                    Caption = 'Declining-Balance %', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Depreciation Table Code"; Rec."Depreciation Table Code")
                {
                    ApplicationArea = All;
                    Caption = 'Depreciation Table Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    Caption = 'Journal Batch Name', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                    Caption = 'Source Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                    Caption = 'Reason Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                    Caption = 'Transaction No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                    Caption = 'Bal. Account Type', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                    Caption = 'Bal. Account No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Amount', Comment = 'ESP=""';
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
                field("FA Class Code"; Rec."FA Class Code")
                {
                    ApplicationArea = All;
                    Caption = 'FA Class Code', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("FA Exchange Rate"; Rec."FA Exchange Rate")
                {
                    ApplicationArea = All;
                    Caption = 'FA Exchange Rate', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    Caption = 'Amount (LCY)', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Result on Disposal"; Rec."Result on Disposal")
                {
                    ApplicationArea = All;
                    Caption = 'Result on Disposal', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Correction; Rec.Correction)
                {
                    ApplicationArea = All;
                    Caption = 'Correction', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Index Entry"; Rec."Index Entry")
                {
                    ApplicationArea = All;
                    Caption = 'Index Entry', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Canceled from FA No."; Rec."Canceled from FA No.")
                {
                    ApplicationArea = All;
                    Caption = 'Canceled from FA No.', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Depreciation Ending Date"; Rec."Depreciation Ending Date")
                {
                    ApplicationArea = All;
                    Caption = 'Depreciation Ending Date', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Use FA Ledger Check"; Rec."Use FA Ledger Check")
                {
                    ApplicationArea = All;
                    Caption = 'Use FA Ledger Check', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Automatic Entry"; Rec."Automatic Entry")
                {
                    ApplicationArea = All;
                    Caption = 'Automatic Entry', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Depr. Starting Date (Custom 1)"; Rec."Depr. Starting Date (Custom 1)")
                {
                    ApplicationArea = All;
                    Caption = 'Depr. Starting Date (Custom 1)', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Depr. Ending Date (Custom 1)"; Rec."Depr. Ending Date (Custom 1)")
                {
                    ApplicationArea = All;
                    Caption = 'Depr. Ending Date (Custom 1)', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Accum. Depr. % (Custom 1)"; Rec."Accum. Depr. % (Custom 1)")
                {
                    ApplicationArea = All;
                    Caption = 'Accum. Depr. % (Custom 1)', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Depr. % this year (Custom 1)"; Rec."Depr. % this year (Custom 1)")
                {
                    ApplicationArea = All;
                    Caption = 'Depr. % this year (Custom 1)', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Property Class (Custom 1)"; Rec."Property Class (Custom 1)")
                {
                    ApplicationArea = All;
                    Caption = 'Property Class (Custom 1)', Comment = 'ESP=""';
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
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension Set ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Location; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            Description = 'test';
            action(funcgo)
            {
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunPageMode = View;

                trigger OnAction()
                begin
                    func();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        func();
    end;

    local procedure func()
    var
        FALedgerEntry: Record "FA Ledger Entry";
    begin
        FALedgerEntry.SetFilter("FA No.", '<>AF000468');

#pragma warning disable AL0667
        if FALedgerEntry.FindSet(true, true) then
#pragma warning restore AL0667
            repeat
                if FALedgerEntry."Reversed by Entry No." = 4670 then begin
                    FALedgerEntry."Reversed by Entry No." := 0;
                    FALedgerEntry.Modify(false);
                end;
                if FALedgerEntry."Reversed Entry No." = 4670 then begin
                    FALedgerEntry."Reversed Entry No." := 0;
                    FALedgerEntry.Modify(false);
                end;
            until FALedgerEntry.Next() = 0;
        Message('ok');
    end;
}