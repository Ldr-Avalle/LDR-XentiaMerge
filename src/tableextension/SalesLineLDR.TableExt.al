tableextension 50227 SalesLine_LDR extends "Sales Line"
{

    fields
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
            begin
                if rec.Type = rec.Type::Item then begin
                    Item.GET(rec."No.");
                    "On Deposit" := Item."On Deposit";
                end;
            end;
        }
        modify(Description)
        {
            Description = 'SERCABLE';
        }
        modify("Description 2")
        {
            Description = 'SERCABLE';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Grupo contable negocio';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Grupo contable producto';
        }
        modify("Area")
        {
            Caption = 'Cód. provincia';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Grupo registro IVA neg.';
        }
        modify("Job Contract Entry No.")
        {
            Caption = 'Nº mov. contrato proyecto';
        }
        field(50000; "Serial No."; Code[20])
        {
            Description = 'SERCABLE';
            trigger OnValidate()
            var
                ReservationEntry: Record "Reservation Entry";
                ReservationEntry2: Record "Reservation Entry";
                Item: Record Item;
                SalesLine: Record "Sales Line";
                ItemLdgEntry: Record "Item Ledger Entry";
                Text0001: Label 'El n´Š¢mero de serie especificado no se encuentra disponible';
                PurchRcptLine: Record "Purch. Rcpt. Line";
                QtyToApply: Integer;
            begin
                //compruebo que el producto tiene n´Š¢ seguimiento
                TESTFIELD(Type, Type::Item);
                TESTFIELD("Serial No.");
                Item.GET("No.");
                Item.TESTFIELD("Item Tracking Code");
                //compruebo que no existe en otra l´Š¢nea no registrada
                IF ("Document Type" IN ["Document Type"::Invoice]) THEN BEGIN
                    SalesLine.RESET();
                    SalesLine.SETFILTER("Serial No.", '%1', "Serial No.");
                    IF SalesLine.FINDFIRST() THEN ERROR('Ya existe el n´Š¢ de serie en la factura %1', SalesLine."Document No.")
                END;
                //Informo el Line No. si a´Š¢n no est´Š¢ insertado el registro para mantener trazabilidad con ReservationEntry
                SalesLine.RESET();
                SalesLine.SETFILTER("Document No.", '%1', "Document No.");
                IF SalesLine.FINDLAST() THEN
                    "Line No." := SalesLine."Line No." + 10000
                ELSE
                    "Line No." := 10000;
                //Hago el movimiento de reserva, creo o modifico si ya existe
                ReservationEntry.RESET();
                IF ("Serial No." <> '') THEN BEGIN
                    IF (xRec."Serial No." = '') THEN BEGIN
                        ReservationEntry.INIT();
                        IF ReservationEntry2.FINDLAST() THEN
                            ReservationEntry."Entry No." := ReservationEntry2."Entry No." + 1
                        ELSE
                            ReservationEntry."Entry No." := 1;
                        ReservationEntry."Item No." := "No.";
                        ReservationEntry."Location Code" := "Location Code";
                        ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Prospect;
                        ReservationEntry."Creation Date" := TODAY;
                        ReservationEntry."Source Type" := 37;
                        ReservationEntry."Source ID" := "Document No.";
                        ReservationEntry."Source Ref. No." := "Line No.";
                        ReservationEntry."Serial No." := "Serial No.";
                        ReservationEntry."Created By" := USERID;
                        ReservationEntry."Qty. per Unit of Measure" := 1;
                        IF ("Document Type" IN ["Document Type"::Invoice, "Document Type"::Order]) THEN BEGIN
                            QtyToApply := -1;
                            ReservationEntry.Positive := FALSE;
                            ReservationEntry."Source Subtype" := 2;
                            ReservationEntry."Shipment Date" := "Shipment Date";
                            ReservationEntry."Qty. to Handle (Base)" := QtyToApply;
                            ReservationEntry."Qty. to Invoice (Base)" := QtyToApply;
                        END ELSE BEGIN
                            QtyToApply := 1;
                            ReservationEntry.Positive := TRUE;
                            ReservationEntry."Source Subtype" := 3;
                            ReservationEntry."Expected Receipt Date" := TODAY;
                            ReservationEntry."Qty. to Handle (Base)" := 1;
                            ReservationEntry."Qty. to Invoice (Base)" := 1;
                        END;
                        ReservationEntry.Quantity := QtyToApply;
                        ReservationEntry."Quantity (Base)" := QtyToApply;
                        ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Serial No.";
                        IF ReservationEntry.INSERT() THEN;
                    END ELSE BEGIN
                        ReservationEntry.SETFILTER("Source ID", '%1', "Document No.");
                        ReservationEntry.SETFILTER("Source Ref. No.", '%1', "Line No.");
                        IF ReservationEntry.FINDFIRST() THEN BEGIN
                            ReservationEntry."Serial No." := "Serial No.";
                            ReservationEntry.MODIFY();
                        END;
                    END;
                    //traigo el coste del producto
                    IF ("Document Type" IN ["Document Type"::Invoice]) THEN BEGIN
                        ItemLdgEntry.SETFILTER("Item No.", '%1', "No.");
                        ItemLdgEntry.SETFILTER("Location Code", '%1', "Location Code");
                        ItemLdgEntry.SETFILTER("Serial No.", '%1', "Serial No.");
                        ItemLdgEntry.SETFILTER("Remaining Quantity", '%1', 1);
                        IF ItemLdgEntry.FINDFIRST() = FALSE THEN
                            ERROR(Text0001)
                        ELSE BEGIN
                            PurchRcptLine.SETFILTER("Document No.", '%1', ItemLdgEntry."Document No.");
                            PurchRcptLine.SETFILTER("Line No.", '%1', ItemLdgEntry."Document Line No.");
                            IF PurchRcptLine.FINDFIRST() THEN BEGIN
                                VALIDATE("Unit Cost", PurchRcptLine."Unit Cost");
                                VALIDATE("Unit Cost (LCY)", PurchRcptLine."Unit Cost");
                                "Unit Price" := PurchRcptLine."Unit Cost"; //no hago validate para que no machaque el importe l´Š¢nea ya introducido
                            END;
                        END;
                    END;
                END;
            end;
        }
        field(50001; "On Deposit"; Boolean)
        {
            Description = 'SERCABLE';
        }
    }

    trigger OnAfterInsert()
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SETFILTER("Document No.", '%1', rec."Document No.");
        IF SalesLine.FINDLAST() THEN
            rec."Line No." := SalesLine."Line No." + 10000
        ELSE
            rec."Line No." := 10000;
    end;


    trigger OnAfterModify()
    var
        UserDims: Record "User Dimensions_LDR";
    begin
        IF UserDims.existsUser(USERID) THEN
            IF NOT (Type IN [Type::Item, Type::"Charge (Item)"]) THEN
                FIELDERROR(Type);
    end;



















    /*


        local procedure setTrackingUnitCost("Document Type": Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; "Document No.": Code[20]; "Line No.": Integer; "Serial No.": Code[20])
        var
            SalesSetup: Record 311;
            Item: Record 27;
            SalesLine: Record 37;
            ItemLdgEntry: Record 32;
        begin
            SalesSetup.GET;
            IF SalesSetup."Automat. Tracking Unit Cost" THEN
                IF SalesLine.GET("Document Type", "Document No.", "Line No.") THEN
                    IF ((SalesLine.Type = SalesLine.Type::Item) AND (SalesLine.Quantity = 1)) THEN BEGIN
                        ItemLdgEntry.SETFILTER("Item No.", '%1', SalesLine."No.");
                        ItemLdgEntry.SETFILTER("Serial No.", '%1', "Serial No.");
                        IF ItemLdgEntry.FINDFIRST THEN BEGIN
                            SalesLine.VALIDATE("Appl.-to Item Entry", ItemLdgEntry."Entry No.");
                            SalesLine.MODIFY;
                        END;
                    END;
        end;
        */
    /*
    var
        Proyecto: Code[10];
        UserDim: Record 50000;


        SalesSetup: Record 311;
        Item: Record 27;

 


        SalesLine: Record 37;

 
        UserDims: Record 50000;

        gbldimensiones: Record 50000;
        */
}
