tableextension 50174 Item_LDR extends Item
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
            Caption = 'Grupo contable producto';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'Grupo registro IVA prod.';
        }
        modify("Planned Order Receipt (Qty.)")
        {
            Caption = 'Recep. (cdad) O.P. planif.';
        }
        modify("Qty. on Component Lines")
        {
            Caption = 'Cdad. línea componentes';
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
            CalcFormula = sum("Purchase Line"."Outstanding Qty. (Base)" where("Document Type" = const("Return Order"),
                                                                               Type = const(Item),
                                                                               "No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Location Code" = field("Location Filter"),
                                                                               "Drop Shipment" = field("Drop Shipment Filter"),
                                                                               "Variant Code" = field("Variant Filter"),
                                                                               "Bin Code" = field("Bin Filter"),
                                                                               "Expected Receipt Date" = field("Date Filter")));
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
        Proyecto := UserDim.getProjectDim(UserId);
        "Global Dimension 1 Code" := Proyecto;
        ConfInventario.Get;
        "Gen. Prod. Posting Group" := ConfInventario."Grupo contable producto";
        "VAT Prod. Posting Group" := 'IVA21';
        "Inventory Posting Group" := ConfInventario."Grupo contable inventario";
        "Costing Method" := "Costing Method"::Average;
        Validate("Price Includes VAT", true);
        "Base Unit of Measure" := 'UDS';
        "Sales Unit of Measure" := 'UDS';
        "Purch. Unit of Measure" := 'UDS';
        ItemUnitMeasure.Init;
        ItemUnitMeasure."Item No." := "No.";
        ItemUnitMeasure.Code := 'UDS';
        ItemUnitMeasure."Qty. per Unit of Measure" := 1;
        if ItemUnitMeasure.Insert then;
    end;

    var
        ItemUnitMeasure: Record "Item Unit of Measure";
        PurchOrderLine: Record "Purchase Line";
        SalesOrderLine: Record "Sales Line";
        ConfInventario: Record "Inventory Setup";
        TextMercaderia: Label 'MERCADERÍA';
}