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
}
