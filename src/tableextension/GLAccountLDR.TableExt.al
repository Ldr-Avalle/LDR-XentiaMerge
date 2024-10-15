tableextension 50096 "GLAccount_LDR" extends "G/L Account"
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
                IF (xRec."No." <> '') THEN
                    IF (STRLEN("No.") > 5) <> (STRLEN(xRec."No.") > 5) THEN
                        ERROR(Text1100001, FIELDNAME("Account Type"));
                EVALUATE(TestNo, COPYSTR("No.", 1, 1));

                IF TestNo IN [6 .. 7] THEN BEGIN
                    DefDim.INIT;
                    DefDim."Table ID" := 15;
                    DefDim."No." := "No.";
                    DefDim."Dimension Code" := 'Proyecto';
                    DefDim."Value Posting" := DefDim."Value Posting"::"Code Mandatory";
                    DefDim.INSERT;
                END;
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
            CalcFormula = Count("G/L Entry" where("G/L Account No." = field("No.")));
            FieldClass = FlowField;
        }
    }

    var
        DefDim: Record "Default Dimension";
        Text1100001: Label 'ENU=The length of the new value is not acceptable, as it implies a change in %1.;ESP=La nueva longitud no es correcta ya que implica un cambio en %1.';
}
