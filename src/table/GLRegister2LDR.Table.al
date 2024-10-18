table 50016 "G/L Register2_LDR"
{
    Caption = 'G/L Register2';

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "From Entry No."; Integer)
        {
            Caption = 'Desde entrada Nº';
            DataClassification = ToBeClassified;
        }
        field(3; "To Entry No."; Integer)
        {
            Caption = 'Hasta entrada Nº';
            DataClassification = ToBeClassified;
        }
        field(4; "Creation Date"; Date)
        {
            Caption = 'Fecha creación';
            DataClassification = ToBeClassified;
        }
        field(5; "Source Code"; Code[10])
        {
            Caption = 'Cód origen';
            DataClassification = ToBeClassified;
        }
        field(6; "User ID"; Code[50])
        {
            Caption = 'Id usuario';
            DataClassification = ToBeClassified;
        }
        field(7; "Journal Batch Name"; Code[10])
        {
            Caption = 'Nombre sección';
            DataClassification = ToBeClassified;
        }
        field(8; "From VAT Entry No."; Integer)
        {
            Caption = 'Desde entrada IVA Nº';
            DataClassification = ToBeClassified;
        }
        field(9; "To VAT Entry No."; Integer)
        {
            Caption = 'Hatsta entrada IVA Nº';
            DataClassification = ToBeClassified;
        }
        field(10; Reversed; Boolean)
        {
            Caption = 'Revertido';
            DataClassification = ToBeClassified;
        }
        field(10700; "Posting Date"; Date)
        {
            Caption = 'Fecha registro';
            DataClassification = ToBeClassified;
            ClosingDates = true;
        }
        field(10701; "Period Trans. No."; Integer)
        {
            BlankZero = true;
            Caption = 'Nº trans. periodo';
            DataClassification = ToBeClassified;
        }
        field(50000; "Fecha registro en Mov cont"; Date)
        {
            Caption = 'Fecha registro en Mov cont';
            Description = 'Sercable';
            Editable = false;
        }
        field(50001; "Num Asiento en Mov cont"; Integer)
        {
            Caption = 'Nº Asiento en mov. cont.';
            Editable = false;
        }
        field(50002; "Fecha Asiento en Mov conta"; Date)
        {
            Caption = 'Fecha Asiento en mov. cont.';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Creation Date")
        {
        }
        key(Key3; "Source Code", "Journal Batch Name", "Creation Date")
        {
        }
        key(Key4; "Posting Date")
        {
        }
        key(Key5; "Posting Date", "Period Trans. No.")
        {
        }
    }
}