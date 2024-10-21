tableextension 50166 VATEntry_LDR extends "VAT Entry"
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
        //todo:no se de donde ha salido
        /*
        field(50199; "Transaction No. BK"; Integer)
        {
            Caption = 'Transaction No. BK';
            Editable = false;
        }
        */
        field(50000; "On Deposit"; Boolean)
        {
            Caption = 'On Deposit';
            Description = 'SERCABLE';
        }
        //todo: value entry no tiene location code
        field(50001; "Shop Code"; Text[30])
        {
            //FieldClass = FlowField;
            //CalcFormula = Lookup("User Dimensions_LDR"."Shop Code" WHERE("Location Code" = FIELD("Location Code")));

            Caption = 'Shop Code';
            Description = 'SERCABLE';
        }
    }
}