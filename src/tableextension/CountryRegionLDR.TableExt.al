tableextension 50001 CountryRegion_LDR extends "Country/Region"
{
    fields
    {
        field(50000; "Facturae Code"; Code[10])
        {
            Caption = 'Código facturae';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50001; "Facturae Region"; Code[10])
        {
            Caption = 'Región facturae';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
    }
}
