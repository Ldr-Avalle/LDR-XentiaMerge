table 50002 "Cash Notes_LDR"
{
    Caption = 'Anotaciones Caja';

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(2; Date; Date)
        {
            Caption = 'Fecha';
            DataClassification = ToBeClassified;
        }
        field(3; "User ID"; Code[50])
        {
            Caption = 'Id. usuario';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Importe';
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[70])
        {
            Caption = 'Descripción';
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