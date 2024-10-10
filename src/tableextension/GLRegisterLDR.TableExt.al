tableextension 50256 "GLRegister_LDR" extends "G/L Register"
{
    fields
    {
        field(50000; "Fecha registro en Mov cont"; Date)
        {
            CalcFormula = Lookup("G/L Entry"."Posting Date" WHERE("Transaction No." = FIELD("No.")));
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
        field(50001; "Num Asiento en Mov cont"; Integer)
        {
            CalcFormula = Lookup("G/L Entry"."Transaction No." WHERE("Entry No." = FIELD("From Entry No.")));
            FieldClass = FlowField;
        }
        field(50002; "Fecha Asiento en Mov conta"; Date)
        {
            CalcFormula = Lookup("G/L Entry"."Posting Date" WHERE("Entry No." = FIELD("From Entry No.")));
            FieldClass = FlowField;
        }
    }
}
