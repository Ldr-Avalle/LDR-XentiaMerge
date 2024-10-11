tableextension 50121 "GLEntry_LDR" extends "G/L Entry"
{
    fields
    {
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
        modify("Reversed by Entry No.")
        {
            Caption = 'Revertido por el movimiento nº';
        }
        field(50001; Punteado; Boolean)
        {
            Caption = 'Punteado';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50002; "Unid producción"; Code[20])
        {
            Caption = 'Unid. producción';
            DataClassification = ToBeClassified;
            Description = 'Sercable, rev flowfilter';
        }
        field(50098; "Transaction No.Copy"; Integer)
        {
            Caption = 'Transaction no.bk';
            DataClassification = ToBeClassified;
        }
        field(50099; FacturaFin; Code[20])
        {
            Caption = 'Factura Fin';
            DataClassification = ToBeClassified;
        }
        field(99998; NumAsientoPer; Integer)
        {
            Caption = 'Nº Asiento Per.';
            //CalcFormula = Lookup("G/L Register"."Period Trans. No." where("No." = field("Transaction No."))); //TODO: Revisar campo eliminado
            FieldClass = FlowField;
        }
        field(99999; FechaRegistro45; Date)
        {
            Caption = 'Fecha Registro 45';
            //CalcFormula = Lookup("G/L Register"."Posting Date" where("No." = field("Transaction No."))); //TODO: Revisar campo eliminado
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key20; "G/L Account No.", "Document Date", "Document No.")
        {
        }
        key(Key21; "G/L Account No.", "Source No.")
        {
            SumIndexFields = Amount, "Debit Amount", "Credit Amount", "Additional-Currency Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount";
        }
    }

    procedure GetBase() base: Decimal
    var
        PurchInvHead: Record "Purch. Inv. Header";
    begin
        if PurchInvHead.Get("Document No.") then begin
            PurchInvHead.CalcFields(Amount);
            exit(PurchInvHead.Amount + "Credit Amount");
        end else
            exit(0);
    end;

    procedure GetRetentionBase() RetBase: Decimal
    var
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
    begin
        RetBase := 0;
        case "Document Type" OF
            "Document Type"::Invoice:
                begin
                    PurchInvLine.SetFilter("Document No.", '%1', "Document No.");
                    //PurchInvLine.SetFilter(Retenible, '%1', true); TODO: Descomentar cuando el campo se añada a la tabla
                    if PurchInvLine.FindFirst then begin
                        repeat
                            RetBase += PurchInvLine.Amount;
                        until PurchInvLine.Next() = 0;
                    end;
                end;
            "Document Type"::"Credit Memo":
                begin
                    PurchCrMemoLine.SetFilter("Document No.", '%1', "Document No.");
                    //PurchCrMemoLine.SetFilter(Retenible, '%1', true); TODO: Descomentar cuando el campo se añada a la tabla
                    if PurchCrMemoLine.FindFirst then begin
                        repeat
                            RetBase += -(PurchCrMemoLine.Amount);
                        until PurchCrMemoLine.NEXT = 0;
                    end;
                end;
        end;
        exit(RetBase);
    end;
}