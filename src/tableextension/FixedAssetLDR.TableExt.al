tableextension 50364 "FixedAsset_LDR" extends "Fixed Asset"
{
    fields
    {
        field(50000; Location; Code[20])
        {
            Caption = 'Ubicación';
            Description = 'SERCABLE';
            Editable = false;
        }
        field(50001; Date; Date)
        {
            Description = 'SERCABLE';
        }
        field(50002; Proyecto; Code[20])
        {
        }
        field(50003; GrupoContable; Code[20])
        {
        }
    }
}