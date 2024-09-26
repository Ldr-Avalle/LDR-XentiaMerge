table 50012 Work_LDR
{
    Caption = 'Obra';
    DrillDownPageID = "Works List_LDR";
    LookupPageID = "Works List_LDR";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Descripción';
            DataClassification = ToBeClassified;
        }
        field(3; "No. of Contracts"; Integer)
        {
            Caption = 'Nº contratos';
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract" where(Work = field(Code)));
            Editable = false;
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
        Work: Record Work_LDR;
    begin
        if Code = '' then begin
            if Work.Findlast then
                Code := IncStr(Work.Code)
            else
                Code := '001';
        end;
    end;
}

