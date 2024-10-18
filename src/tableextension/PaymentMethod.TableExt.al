tableextension 50016 "Payment Method" extends "Payment Method"
{
    fields
    {
        field(50000; "Área PM"; Boolean)
        {
            Caption = 'Método de pago de Área';
            Description = 'SERCABLE';
        }
        field(50001; "Facturae Code"; Code[10])
        {
            Caption = 'Código Facturae';
            Description = 'SERCABLE';
        }
        field(50002; "Project"; Code[20])
        {
            Caption = 'Proyecto';
            Description = 'SERCABLE';
            //todo: pondría el block
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1));
        }
    }
}
