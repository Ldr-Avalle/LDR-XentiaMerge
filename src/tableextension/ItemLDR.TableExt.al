tableextension 50174 "Item_LDR" extends "Item"
{
    DataCaptionFields = "Reordering Policy";

    fields
    {
        field(50000; accessories; Boolean)
        {
            Caption = 'Accesorios';
            Description = 'SERCABLE';
        }
        field(50001; "On Deposit"; Boolean)
        {
            Caption = 'En Depósito';
            Description = 'SERCABLE';
        }
        field(50002; "Quantity returns orders"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'SERCABLE';
        }
    }
}