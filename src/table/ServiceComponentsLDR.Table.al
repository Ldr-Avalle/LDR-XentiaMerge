table 50011 "Service Components_LDR"
{
    Caption = 'Componentes servicio';

    fields
    {
        field(1; Service; Code[20])
        {
            Caption = 'Servicio';
            DataClassification = ToBeClassified;
        }
        field(2; Component; Code[20])
        {
            Caption = 'Componente';
            DataClassification = ToBeClassified;
        }
        field(3; "Component description"; Text[100])
        {
            Caption = 'Descripción comp.';
            Editable = false;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Cantidad';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Service, Component)
        {
        }
    }
}