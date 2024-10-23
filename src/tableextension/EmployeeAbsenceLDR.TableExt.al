tableextension 50014 EmployeeAbsence_LDR extends "Employee Absence"
{
    fields
    {
        field(50000; "Privacy Blocked_LDR"; Boolean)
        {
            Caption = 'Privacidad bloqueada';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        // key(Key10; "Employee No.", "Entry No.")
        // {
        // }
    }
}