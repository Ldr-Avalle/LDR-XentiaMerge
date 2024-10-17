tableextension 50453 ReturnShipmentLine_LDR extends "Return Shipment Line"
{
    fields
    {
        modify("Area")
        {
            Caption = 'Cód. provincia';
        }

        field(50000; "Vendor Nº"; Code[35])
        {
            CalcFormula = Lookup("Return Shipment Header"."Vendor Authorization No." WHERE("No." = FIELD("Document No.")));
            Caption = ' Nº autorización del proveedor ';
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
    }
}
