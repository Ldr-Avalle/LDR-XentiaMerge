table 50011 "Service Components_LDR"
{
    Caption = 'Componentes servicio';

    fields
    {
        field(1; Service; Code[20])
        {
            Caption = 'Servicio';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item";
        }
        field(2; Component; Code[20])
        {
            Caption = 'Componente';
            DataClassification = ToBeClassified;
            TableRelation = "Service Item";

            trigger OnValidate()
            var
                ServiceItem: Record "Service Item";
            begin
                ServiceItem.Get(Component);
                if ServiceItem.Type <> ServiceItem.Type::Fixed then
                    ServiceItem.FieldError(Type);
            end;
        }
        field(3; "Component description"; Text[100])
        {
            Caption = 'Descripción comp.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Service Item".Description where("No." = field(Component)));
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

    trigger OnInsert()
    var
        ServiceItem: Record "Service Item";
    begin
        ServiceItem.Get(Service);
        if ServiceItem.Type <> ServiceItem.Type::Pack then
            ServiceItem.FieldError(Type);
    end;
}

