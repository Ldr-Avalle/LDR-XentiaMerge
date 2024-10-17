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
        EmployeeAbsence.SETFILTER("Employee No.", '%1', "Employee No.");
        IF EmployeeAbsence.FINDLAST THEN
            "Entry No." := EmployeeAbsence."Entry No." + 1
        ELSE
            "Entry No." := 1;
    end;
}