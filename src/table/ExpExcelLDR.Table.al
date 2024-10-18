table 50013 "Exp. Excel_LDR"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Código; Code[10])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Código)
        {
            Clustered = true;
        }
    }
}