tableextension 50002 Location_LDR extends Location
{
    fields
    {
        modify("Open Shop Floor Bin Code")
        {
            Caption = 'Abre ubic. aprovision. manual';
        }
        field(50000; ShopCode; Text[30])
        {
            Caption = 'Código Tienda';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Cód. Dimensión Global 1';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = filter(1));
        }
    }

    procedure GetBinCode(UseFlushingMethod: Boolean; FlushingMethod: Option Manual,Forward,Backward,"Pick + Forward","Pick + Backward"): Code[20]
    begin
        if not UseFlushingMethod then
            exit("From-Production Bin Code");
        case FlushingMethod of
            FlushingMethod::Manual,
          FlushingMethod::"Pick + Forward",
          FlushingMethod::"Pick + Backward":
                exit("To-Production Bin Code");
            FlushingMethod::Forward,
          FlushingMethod::Backward:
                exit("Open Shop Floor Bin Code");
        end;
    end;
}
