table 50028 "SaleCost Item Ledger Entry_LDR"
{
    Caption = 'Mov. producto coste venta';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Nº mov.';
            DataClassification = ToBeClassified;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Nº producto';
            DataClassification = ToBeClassified;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Fecha registro';
            DataClassification = ToBeClassified;
        }
        field(4; "Entry Type"; Option)
        {
            Caption = 'Tipo mov.';
            DataClassification = ToBeClassified;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        }
        field(5; "Source No."; Code[20])
        {
            Caption = 'Cód Origen';
            DataClassification = ToBeClassified;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Nº documento';
            DataClassification = ToBeClassified;
        }
        field(7; Description; Text[70])
        {
            Caption = 'Descripción';
            DataClassification = ToBeClassified;
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Cód ubicación';
            DataClassification = ToBeClassified;
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Cantidad';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(13; "Remaining Quantity"; Decimal)
        {
            Caption = 'Cantidad pendiente';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(14; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Cantidad facturada';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(28; "Applies-to Entry"; Integer)
        {
            Caption = 'Mov. aplicado';
            DataClassification = ToBeClassified;
        }
        field(29; Open; Boolean)
        {
            Caption = 'Abierto';
            DataClassification = ToBeClassified;
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Cod dimensión global 1';
            DataClassification = ToBeClassified;
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Cod dimensión global 2';
            DataClassification = ToBeClassified;
        }
        field(36; Positive; Boolean)
        {
            Caption = 'Positivo';
            DataClassification = ToBeClassified;
        }
        field(41; "Source Type"; Option)
        {
            Caption = 'Tipo origen';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(47; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
        }
        field(50; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
        }
        field(51; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
        }
        field(52; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
        }
        field(59; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Entry/exit Point';
        }
        field(60; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(61; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(62; "Area"; Code[10])
        {
            Caption = 'Area';
        }
        field(63; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
        }
        field(64; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(70; "Reserved Quantity"; Decimal)
        {
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(79; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = ' ,Sales Shipment,Sales Invoice,Sales Return Receipt,Sales Credit Memo,Purchase Receipt,Purchase Invoice,Purchase Return Shipment,Purchase Credit Memo,Transfer Shipment,Transfer Receipt,Service Shipment,Service Invoice,Service Credit Memo';
            OptionMembers = " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo";
        }
        field(80; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(1000; "Job No."; Code[20])
        {
            Caption = 'Job No.';
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
        }
        field(1002; "Job Purchase"; Boolean)
        {
            Caption = 'Job Purchase';
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(5408; "Derived from Blanket Order"; Boolean)
        {
            Caption = 'Derived from Blanket Order';
        }
        field(5700; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
        }
        field(5701; "Originally Ordered No."; Code[20])
        {
            Caption = 'Originally Ordered No.';
        }
        field(5702; "Originally Ordered Var. Code"; Code[10])
        {
            Caption = 'Originally Ordered Var. Code';
        }
        field(5703; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
        }
        field(5704; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
        }
        field(5705; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
        }
        field(5706; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
        }
        field(5707; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
        }
        field(5740; "Transfer Order No."; Code[20])
        {
            Caption = 'Transfer Order No.';
            Editable = false;
        }
        field(5800; "Completely Invoiced"; Boolean)
        {
            Caption = 'Completely Invoiced';
        }
        field(5801; "Last Invoice Date"; Date)
        {
            Caption = 'Last Invoice Date';
        }
        field(5802; "Applied Entry to Adjust"; Boolean)
        {
            Caption = 'Applied Entry to Adjust';
        }
        field(5803; "Cost Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Expected)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5804; "Cost Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Actual)';
            Editable = true;
            FieldClass = FlowField;
        }
        field(5805; "Cost Amount (Non-Invtbl.)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Non-Invtbl.)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5806; "Cost Amount (Expected) (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Expected) (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5807; "Cost Amount (Actual) (ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Actual) (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5808; "Cost Amount (Non-Invtbl.)(ACY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount (Non-Invtbl.)(ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5813; "Purchase Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Purchase Amount (Expected)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5814; "Purchase Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Purchase Amount (Actual)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5815; "Sales Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Amount (Expected)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5816; "Sales Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales Amount (Actual)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5817; Correction; Boolean)
        {
            Caption = 'Correction';
            DataClassification = ToBeClassified;
        }
        field(5818; "Shipped Qty. Not Returned"; Decimal)
        {
            Caption = 'Shipped Qty. not Returned';
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(5832; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            DataClassification = ToBeClassified;
        }
        field(5833; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
            DataClassification = ToBeClassified;
        }
        field(5900; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
            DataClassification = ToBeClassified;
        }
        field(6500; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            DataClassification = ToBeClassified;
        }
        field(6501; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            DataClassification = ToBeClassified;
        }
        field(6502; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
            DataClassification = ToBeClassified;
        }
        field(6503; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = ToBeClassified;
        }
        field(6510; "Item Tracking"; Option)
        {
            Caption = 'Item Tracking';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'None,Lot No.,Lot and Serial No.,Serial No.';
            OptionMembers = "None","Lot No.","Lot and Serial No.","Serial No.";
        }
        field(6602; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            DataClassification = ToBeClassified;
        }
        field(10700; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            DataClassification = ToBeClassified;
        }
        field(50000; "On Deposit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Purch. Rcpt. Cost"; Decimal)
        {
            Caption = 'Coste albarán';
            DataClassification = ToBeClassified;
        }
        field(50002; "Purch. Inv. Cost"; Decimal)
        {
            Caption = 'Coste factura';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Item No.", "Posting Date")
        {
        }
        key(Key3; "Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date")
        {
            SumIndexfields = Quantity, "Invoiced Quantity";
        }
        key(Key4; "Source Type", "Source No.", "Item No.", "Variant Code", "Posting Date")
        {
            SumIndexfields = Quantity;
        }
        key(Key5; "Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date")
        {
            SumIndexfields = Quantity, "Remaining Quantity";
        }
        key(Key6; "Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.")
        {
            SumIndexfields = Quantity, "Remaining Quantity";
        }
        key(Key7; "Country/Region Code", "Entry Type", "Posting Date")
        {
        }
        key(Key8; "Document No.", "Document Type", "Document Line No.")
        {
        }
        key(Key9; "Prod. Order No.", "Prod. Order Line No.", "Entry Type", "Prod. Order Comp. Line No.")
        {
            MaintainSifTIndex = false;
            SumIndexfields = Quantity;
        }
        key(Key10; "Item No.", "Applied Entry to Adjust")
        {
        }
        key(Key11; "Item No.", Positive, "Location Code", "Variant Code")
        {
        }
        key(Key12; "Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.")
        {
            MaintainSifTIndex = false;
            MaintainSQLIndex = false;
        }
        key(Key13; "Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.")
        {
            MaintainSifTIndex = false;
            MaintainSQLIndex = false;
            SumIndexfields = "Remaining Quantity";
        }
        key(Key14; "Serial No.")
        {
        }
        key(Key15; "Item No.", "Global Dimension 1 Code", "Posting Date")
        {
            SumIndexfields = Quantity;
        }
        key(Key16; "Entry Type", "Global Dimension 1 Code", "Item No.", "Posting Date", "Location Code")
        {
            SumIndexfields = "Invoiced Quantity", Quantity;
        }
    }
}