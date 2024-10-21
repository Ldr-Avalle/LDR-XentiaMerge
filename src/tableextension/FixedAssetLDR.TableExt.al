tableextension 50364 FixedAsset_LDR extends "Fixed Asset"
{
    fields
    {
        field(50000; Location; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Default Dimension"."Dimension Value Code" where("Table ID" = const(5600),
                                                                                   "No." = field("No."),
                                                                                   "Dimension Code" = const('UNIDADES PRODUCCIÓN')));
            Caption = 'Ubicación';
            Description = 'SERCABLE';
            Editable = false;
        }
        field(50001; Date; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("FA Depreciation Book"."Acquisition Date" where("FA No." = field("No.")));
            Description = 'SERCABLE';
        }
        field(50002; Proyecto; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Default Dimension"."Dimension Value Code" where("Table ID" = filter(5600),
                                                                                   "No." = field("No."),
                                                                                   "Dimension Code" = filter('PROYECTO')));
        }
        field(50003; GrupoContable; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("FA Depreciation Book"."FA Posting Group" where("FA No." = field("No.")));
        }
    }
}
