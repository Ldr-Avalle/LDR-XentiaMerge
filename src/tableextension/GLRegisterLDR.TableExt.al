tableextension 50256 GLRegister_LDR extends "G/L Register"
{
    fields
    {
        field(50000; "Fecha registro en Mov cont"; Date)
        {
            CalcFormula = lookup("G/L Entry"."Posting Date" where("Transaction No." = field("No.")));
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
        field(50001; "Num Asiento en Mov cont"; Integer)
        {
            CalcFormula = lookup("G/L Entry"."Transaction No." where("Entry No." = field("From Entry No.")));
            FieldClass = FlowField;
        }
        field(50002; "Fecha Asiento en Mov conta"; Date)
        {
            CalcFormula = lookup("G/L Entry"."Posting Date" where("Entry No." = field("From Entry No.")));
            FieldClass = FlowField;
        }
    }
}
