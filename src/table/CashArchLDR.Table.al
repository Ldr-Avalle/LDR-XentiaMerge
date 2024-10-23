table 50003 "Cash Arch_LDR"
{
    Caption = 'Arqueo caja';
    DataCaptionFields = Title;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'Id. usuario';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Date; Date)
        {
            Caption = 'Fecha';
        }
        field(3; "Start cash"; Decimal)
        {
            Caption = 'Importe inicial';
            DataClassification = ToBeClassified;
        }
        field(4; "End cash"; Decimal)
        {
            Caption = 'Importe final';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Cash Notes"; Decimal)
        {
            Caption = 'Notas caja';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Registered; Boolean)
        {
            Caption = 'Registrado';
            DataClassification = ToBeClassified;
        }
        field(7; "1 cent."; Decimal)
        {
            Caption = '1 cént.';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(8; "2 cent."; Decimal)
        {
            Caption = '2 cént.';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(9; "5 cent."; Decimal)
        {
            Caption = '5 cént.';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(10; "10 cent."; Decimal)
        {
            Caption = '10 cént.';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(11; "20 cent."; Decimal)
        {
            Caption = '20 cént.';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(12; "50 cent."; Decimal)
        {
            Caption = '50 cént.';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(13; "1 euro"; Decimal)
        {
            Caption = '1 euro';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(14; "2 euros"; Decimal)
        {
            Caption = '2 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(15; "5 euros"; Decimal)
        {
            Caption = '5 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(16; "10 euros"; Decimal)
        {
            Caption = '10 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(17; "20 euros"; Decimal)
        {
            Caption = '20 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(18; "50 euros"; Decimal)
        {
            Caption = '50 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(19; "100 euros"; Decimal)
        {
            Caption = '100 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(20; "200 euros"; Decimal)
        {
            Caption = '200 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(21; "500 euros"; Decimal)
        {
            Caption = '500 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;
        }
        field(22; Discrepancy; Decimal)
        {
            Caption = 'Descuadre';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; Arch; Decimal)
        {
            Caption = 'Arqueo';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Card Sales"; Decimal)
        {
            Caption = 'Ventas tarjeta';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "POS Amount"; Decimal)
        {
            Caption = 'Importe datáfono';
            DataClassification = ToBeClassified;
        }
        field(26; "Pay-to Bank"; Decimal)
        {
            Caption = 'Ingreso en banco';
            DataClassification = ToBeClassified;
        }
        field(27; Comentarios; Text[250])
        {
            Caption = 'Comentarios';
            DataClassification = ToBeClassified;
        }
        field(28; Sales; Decimal)
        {
            Caption = 'Ventas';
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; Title; Option)
        {
            Caption = 'Título';
            OptionMembers = " ";
        }
    }

    keys
    {
        key(Key1; "User ID", Date)
        {
        }
    }
}