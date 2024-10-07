tableextension 50015 "EmploymentContract_LDR" extends "Employment Contract"
{
    fields
    {
        modify(Description)
        {
            Description = 'Sercable';
        }
        field(50000; "Working %"; Integer)
        {
            Caption = '% Jornada';
            DataClassification = ToBeClassified;
            Description = 'SERCABLE';
            MaxValue = 100;
            MinValue = 0;
        }
    }
}
