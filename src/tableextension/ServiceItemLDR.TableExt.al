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
        }
        field(50002; Segment; Option)
        {
            Caption = 'Segmento';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            OptionCaption = '';
            OptionMembers = ServiceItemSegment;
        }
        field(50003; Type; Option)
        {
            Caption = 'Tipo';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            OptionCaption = '';
            OptionMembers = ServiceItemSegment;
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
}