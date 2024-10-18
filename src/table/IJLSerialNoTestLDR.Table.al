table 50099 "IJL Serial No. Test_LDR"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Nº Movimiento';
            DataClassification = ToBeClassified;
        }
        field(2; "Serial No."; Text[50])
        {
            Caption = 'Nº Serie';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }
}