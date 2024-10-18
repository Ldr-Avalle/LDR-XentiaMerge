tableextension 50096 GLAccount_LDR extends "G/L Account"
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
        modify("Income/Balance")
        {
            trigger OnAfterValidate()
            var
                TestNo: Integer;
            begin
                if (xRec."No." <> '') then
                    if (StrLen("No.") > 5) <> (StrLen(xRec."No.") > 5) then
                        Error(Text1100001, FieldName("Account Type"));
                Evaluate(TestNo, CopyStr("No.", 1, 1));

                if TestNo in [6 .. 7] then begin
                    DefDim.Init;
                    DefDim."Table ID" := 15;
                    DefDim."No." := "No.";
                    DefDim."Dimension Code" := 'Proyecto';
                    DefDim."Value Posting" := DefDim."Value Posting"::"Code Mandatory";
                    DefDim.Insert;
                end;
            end;
        }
        field(50000; "Dimension 3 Filter"; Code[20])
        {
            Caption = 'Filtro Dimensión 3';
            CaptionClass = '1,3,1';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "Dimension Value".Code where("Dimension Code" = filter('UNIDADES PRODUCCIÓN'));
        }
        field(50001; "Qty Mov"; Integer)
        {
            Caption = 'Movimientos';
            CalcFormula = count("G/L Entry" where("G/L Account No." = field("No.")));
            FieldClass = FlowField;
        }
    }

    var
        DefDim: Record "Default Dimension";
        Text1100001: Label 'ENU=The length of the new value is not acceptable, as it implies a change in %1.;ESP=La nueva longitud no es correcta ya que implica un cambio en %1.';
}
