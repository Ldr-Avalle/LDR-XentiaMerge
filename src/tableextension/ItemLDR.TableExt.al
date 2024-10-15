tableextension 50174 "Item_LDR" extends "Item"
{
    DataCaptionFields = "Reordering Policy";

    fields
    {
        modify(Description)
        {
            Description = 'SERCABLE';

            trigger OnAfterValidate()
            var
                UserDim: Record "User Dimensions_LDR";
                Proyecto: Code[10];
            begin
                Proyecto := UserDim.getProjectDim(UserId);
                Validate("Global Dimension 1 Code", Proyecto);
            end;
        }
        modify("Profit %")
        {
            Description = 'SERCABLE';
        }
        modify(Inventory)
        {
            Description = 'SERCABLE';
        }
        modify("Net Invoiced Qty.")
        {
            Description = 'SERCABLE';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("Planned Order Receipt (Qty.)")
        {
            Caption = 'Planned Order Receipt (Qty.)';
        }
        modify("Qty. on Component Lines")
        {
            Caption = 'Qty. on Component Lines';
        }
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
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST("Return Order"),
                                                                               Type = CONST(Item),
                                                                               "No." = FIELD("No."),
                                                                               "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                               "Location Code" = FIELD("Location Filter"),
                                                                               "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                               "Variant Code" = FIELD("Variant Filter"),
                                                                               "Bin Code" = FIELD("Bin Filter"),
                                                                               "Expected Receipt Date" = FIELD("Date Filter")));
            DecimalPlaces = 0 : 5;
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
    }

    trigger OnAfterInsert()
    var
        ItemUnitMeasure: Record "Item Unit of Measure";
        UserDim: Record "User Dimensions_LDR";
        Proyecto: Code[10];
    begin
        Proyecto := UserDim.getProjectDim(USERID);
        "Global Dimension 1 Code" := Proyecto;
        ConfInventario.GET;
        "Gen. Prod. Posting Group" := ConfInventario."Grupo contable producto";
        "VAT Prod. Posting Group" := 'IVA21';
        "Inventory Posting Group" := ConfInventario."Grupo contable inventario";
        "Costing Method" := "Costing Method"::Average;
        VALIDATE("Price Includes VAT", TRUE);
        "Base Unit of Measure" := 'UDS';
        "Sales Unit of Measure" := 'UDS';
        "Purch. Unit of Measure" := 'UDS';
        ItemUnitMeasure.INIT;
        ItemUnitMeasure."Item No." := "No.";
        ItemUnitMeasure.Code := 'UDS';
        ItemUnitMeasure."Qty. per Unit of Measure" := 1;
        IF ItemUnitMeasure.INSERT THEN;
    end;

    var
        ItemUnitMeasure: Record "Item Unit of Measure";
        PurchOrderLine: Record "Purchase Line";
        SalesOrderLine: Record "Sales Line";
        ConfInventario: Record "Inventory Setup";
        TextMercaderia: Label 'MERCADERÍA';
}