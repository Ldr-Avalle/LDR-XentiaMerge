tableextension 50364 FixedAsset_LDR extends "Fixed Asset"
{
    fields
    {
        field(50000; Location; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Table ID" = CONST(5600),
                                                                                   "No." = field("No."),
                                                                                   "Dimension Code" = CONST('UNIDADES PRODUCCIÓN')));
            Caption = 'Ubicación';
            Description = 'SERCABLE';
            Editable = false;
        }
        field(50001; Date; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("FA Depreciation Book"."Acquisition Date" WHERE("FA No." = FIELD("No.")));
            Description = 'SERCABLE';
        }
        field(50002; Proyecto; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" WHERE("Table ID" = FILTER(5600),
                                                                                   "No." = FIELD("No."),
                                                                                   "Dimension Code" = FILTER('PROYECTO')));
        }
        field(50003; GrupoContable; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("FA Depreciation Book"."FA Posting Group" WHERE("FA No." = FIELD("No.")));
        }
    }
}
