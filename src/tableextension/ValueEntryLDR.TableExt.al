tableextension 50399 ValueEntry_LDR extends "Value Entry"
{
    fields
    {
        field(50000; "On Deposit"; Boolean)
        {
            Description = 'SERCABLE';
        }
        field(50001; "Shop Code"; Text[30])
        {
            CalcFormula = Lookup("User Dimensions_LDR"."Shop Code" WHERE("Location Code" = FIELD("Location Code")));
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
    }
}
