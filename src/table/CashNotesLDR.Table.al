table 50002 "Cash Notes_LDR"
{
    Caption = 'Anotaciones Caja';
    LookupPageID = "Cash Note List";

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

    trigger OnInsert()
    var
        CashNotes: Record "Cash Notes_LDR";
    begin
        if CashNotes.FindLast() then
            Code := IncStr(CashNotes.Code)
        else
            Code := 'CN001';

        Date := WorkDate();
        "User ID" := UserID();
    end;

    trigger OnModify()
    var
        CashArch: Record "Cash Arch_LDR";
    begin
        "User ID" := UserID();
        TestField("User ID", UserID());
        CashArch.SetFilter(CashArch.Date, '%1', Date);
        CashArch.SetFilter(CashArch."User ID", '%1', "User ID");
        if CashArch.FindFirst() then
            CashArch.TestField(Registered, false);
    end;
}