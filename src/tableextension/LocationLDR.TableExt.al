tableextension 50002 "Location_LDR" extends Location
{
    fields
    {
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
        }
    }
}