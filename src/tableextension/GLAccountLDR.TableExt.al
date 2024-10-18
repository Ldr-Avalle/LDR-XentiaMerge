tableextension 50096 "GLAccount_LDR" extends "G/L Account"
{
    fields
    {
        field(50000; "Dimension 3 Filter"; Code[20])
        {
            Caption = 'Filtro Dimensión 3';
            CaptionClass = '1,3,1';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50001; "Qty Mov"; Integer)
        {
            Caption = 'Movimientos';
        }
    }
}