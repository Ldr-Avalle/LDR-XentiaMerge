table 50029 "G/L Register CP2_LDR"
{
    Caption = 'G/L Register';
    LookupPageID = "G/L Registers";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "From Entry No."; Integer)
        {
            Caption = 'Desde nº movimiento';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Entry";
#pragma warning disable AL0667
            TestTableRelation = false;
#pragma warning restore AL0667
        }
        field(3; "To Entry No."; Integer)
        {
            Caption = 'Hasta nº movimiento';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Entry";
#pragma warning disable AL0667
            TestTableRelation = false;
#pragma warning restore AL0667
        }
        field(4; "Creation Date"; Date)
        {
            Caption = 'Fecha creación';
            DataClassification = ToBeClassified;
        }
        field(5; "Source Code"; Code[10])
        {
            Caption = 'Cód. origen';
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
        }
        field(6; "User ID"; Code[50])
        {
            Caption = 'Id. usuario';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
#pragma warning disable AL0667
            TestTableRelation = false;
#pragma warning restore AL0667

            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
                UserMgt.DisplayUserInformationBySID("User ID");
            end;
        }
        field(7; "Journal Batch Name"; Code[10])
        {
            Caption = 'Nombre lote';
            DataClassification = ToBeClassified;
        }
        field(8; "From VAT Entry No."; Integer)
        {
            Caption = 'Desde nº asiento iva';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Entry";
#pragma warning disable AL0667
            TestTableRelation = false;
#pragma warning restore AL0667
        }
        field(9; "To VAT Entry No."; Integer)
        {
            Caption = 'Hasta nº asiento iva';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Entry";
#pragma warning disable AL0667
            TestTableRelation = false;
#pragma warning restore AL0667
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
            Caption = 'Nº de transacción de periodo';
            DataClassification = ToBeClassified;
        }
        field(50000; "Fecha registro en Mov cont"; Date)
        {
            Caption = 'Fecha registro en mov. cont';
            FieldClass = Flowfield;
            CalcFormula = Lookup("G/L Entry"."Posting Date" where("Transaction No." = field("No.")));
            Description = 'Sercable';
            Editable = false;
        }
        field(50001; "Num Asiento en Mov cont"; Integer)
        {
            Caption = 'Nº asiento en mov. cont';
            FieldClass = Flowfield;
            CalcFormula = Lookup("G/L Entry"."Transaction No." where("Entry No." = field("From Entry No.")));
            Editable = false;
        }
        field(50002; "Fecha Asiento en Mov conta"; Date)
        {
            Caption = 'Fecha asiento en mov. cont';
            FieldClass = Flowfield;
            CalcFormula = Lookup("G/L Entry"."Posting Date" where("Entry No." = field("From Entry No.")));
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

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "From Entry No.", "To Entry No.", "Creation Date", "Source Code")
        {
        }
    }
}

