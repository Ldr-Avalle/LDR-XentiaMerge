table 50014 "Agreement_LDR"
{
    Caption = 'Convenio';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[70])
        {
            Caption = 'Nombre';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }
}