tableextension 50153 "Vendor_LDR" extends Vendor
{
    fields
    {
        field(50004; "Retención"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'SERCABLE';
        }
        field(50005; "No.Cuenta"; Text[20])
        {
            Description = 'SERCABLE';
        }
        field(50705; "Excluir del 347"; Boolean)
        {
            Description = 'SERCABLE';
        }
    }
}