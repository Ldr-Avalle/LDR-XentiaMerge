table 50014 Agreement_LDR
{
    Caption = 'Convenio';
    DrillDownPageID = "Agreement List";
    LookupPageID = "Agreement List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[70])
        {
            Caption = 'Nombre';
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
        Agreement: Record Agreement_LDR;
    begin
        if Code = '' then begin
            if Agreement.Findlast then
                Code := IncStr(Agreement.Code)
            else
                Code := '01';
        end;
    end;
}

