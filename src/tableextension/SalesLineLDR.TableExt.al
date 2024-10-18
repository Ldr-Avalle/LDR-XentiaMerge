tableextension 50227 "SalesLine_LDR" extends "Sales Line"
{
    fields
    {
        field(50000; "Serial No."; Code[20])
        {
            Description = 'SERCABLE';
        }
        field(50001; "On Deposit"; Boolean)
        {
            Description = 'SERCABLE';
        }
    }
}
