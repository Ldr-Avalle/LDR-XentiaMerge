tableextension 50005 ServiceItem_LDR extends "Service Item"
{
    fields
    {
        field(50000; "Max. Qty. per Contract"; Integer)
        {
            BlankZero = true;
            Caption = 'Nº máximo por contrato';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            MinValue = 0;
        }
        field(50001; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Cód. dimensión 1';
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            Description = 'Sercable';
            Editable = false;
            //todo: metería el blocked
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            trigger OnValidate()
            begin
                CheckUniqueNameConditions();
            end;
        }
        field(50002; Segment; enum ServiceItemSegment)
        {
            Caption = 'Segmento';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            trigger OnValidate()
            begin
                CheckUniqueNameConditions();
            end;
        }
        field(50003; Type; enum ServiceItemType)
        {
            Caption = 'Tipo';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50004; Commission; Decimal)
        {
            Caption = 'Comisión';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50005; "Category Code"; Code[70])
        {
            Caption = 'Familia';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50007; "Services per unit"; Integer)
        {
            Caption = 'Servicios por unidad';
            DataClassification = ToBeClassified;
            Description = 'Algunos servicios cuentan doble';
            MaxValue = 2;
            MinValue = 1;
        }
    }

    keys
    {
        key(Key1; "Shortcut Dimension 1 Code")
        {
        }
        key(Key2; Segment)
        {
        }
        key(Key3; Type)
        {
        }
        key(Key10; Blocked)
        {
        }
    }

    procedure CheckUniqueNameConditions()
    var
        ServiceItem: Record "Service Item";
        Text0001: Label 'La descripción ya existe en el servicio %1';
    begin
        if (("Shortcut Dimension 1 Code" <> '') AND (Segment <> 0)) then begin
            ServiceItem.SetFilter("Shortcut Dimension 1 Code", '%1', "Shortcut Dimension 1 Code");
            ServiceItem.SetFilter(Segment, '%1', Segment);
            ServiceItem.SetFilter(Description, '%1', Description);
            if ServiceItem.FindFirst then
                repeat
                    if ServiceItem."No." <> "No." then FieldError(Description);
                until ServiceItem.Next() = 0;
        end;
    end;
}
