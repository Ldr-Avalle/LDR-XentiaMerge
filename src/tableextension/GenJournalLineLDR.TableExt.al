tableextension 50525 "GenJournalLine_LDR" extends "Gen. Journal Line"
{
    fields
    {
        modify("Shortcut Dimension 1 Code")
        {
            //todo: quitaría esto
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        modify("Shortcut Dimension 2 Code")
        {
            //todo: quitaría esto
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Grupo contable negocio';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Grupo contable producto';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Grupo registro IVA neg.';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'Grupo registro IVA prod.';
        }
        modify("Bal. VAT Bus. Posting Group")
        {
            Caption = 'Gr. registro IVA neg. contrap.';
        }
        modify("Bal. VAT Prod. Posting Group")
        {
            Caption = 'Gr. registro IVA prod. contrp.';
        }
        //todo: se va a eliminar
        /*
        modify("IC Partner G/L Acc. No.")
        {
            Caption = 'IC Partner G/L Acc. No.';
        }
        */
        modify("Payment Reference")
        {
            trigger OnAfterValidate()
            begin
                if rec."Payment Reference" <> '' then
                    rec.TestField("Creditor No.");
            end;
        }
        modify("IC Partner Transaction No.")
        {
            Caption = 'IC Partner Transaction No.';
        }
        modify("Job Planning Line No.")
        {
            Caption = 'Job Planning Line No.';
        }
        modify("No. of Depreciation Days")
        {
            Caption = 'No. of Depreciation Days';
        }
        modify("FA Error Entry No.")
        {
            Caption = 'FA Error Entry No.';
        }
        field(50099; FacturaFin; Code[20])
        {
            Caption = 'Factura Fin';
        }
    }

    var
        AccTypeNotSupportedErr: Label 'You cannot specify a deferral code for this type of account.';
}