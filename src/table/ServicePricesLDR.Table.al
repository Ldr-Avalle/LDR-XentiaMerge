table 50010 "Service Prices_LDR"
{
    Caption = 'Precios servicio';

    fields
    {
        field(1; Service; Code[20])
        {
            Caption = 'Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item";
        }
        field(2; "Start Date"; Date)
        {
            Caption = 'Fecha inicio';
            DataClassification = ToBeClassified;
        }
        field(3; "End Date"; Date)
        {
            Caption = 'Fecha fin';
            DataClassification = ToBeClassified;
        }
        field(4; Price; Decimal)
        {
            Caption = 'Precio';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Service, "Start Date")
        {
        }
    }
}

