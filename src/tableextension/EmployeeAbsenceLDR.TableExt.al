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
        key(Key10; "Employee No.", "Entry No.")
        {
        }
    }
    trigger OnAfterInsert()
    var
        EmployeeAbsence: Record "Employee Absence";
    begin
        EmployeeAbsence.SetFilter("Employee No.", '%1', "Employee No.");
        if EmployeeAbsence.FindLast then
            "Entry No." := EmployeeAbsence."Entry No." + 1
        else
            "Entry No." := 1;
    end;
}