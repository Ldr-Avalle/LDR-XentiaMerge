pageextension 50016 "Sales Order" extends "Sales Order"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field(ShortcutDimCode3; ShortcutDimCode[3])
            {
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_3;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
            field(ShortcutDimCode4; ShortcutDimCode[4])
            {
                CaptionClass = '1,2,4';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_4;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                end;
            }
            field(ShortcutDimCode5; ShortcutDimCode[5])
            {
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_5;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                end;
            }
            field(ShortcutDimCode6; ShortcutDimCode[6])
            {
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_6;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                end;
            }
            field(ShortcutDimCode7; ShortcutDimCode[7])
            {
                CaptionClass = '1,2,7';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_7;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                end;
            }
            field(ShortcutDimCode8; ShortcutDimCode[8])
            {
                CaptionClass = '1,2,8';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                            "Dimension Value Type" = CONST(Standard),
                                                            Blocked = CONST(false));
                Visible = ShowDim_8;
                trigger OnValidate()
                begin
                    rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                end;
            }
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = all;
            Visible = ShowDim_1;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = all;
            Visible = ShowDim_2;
        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
            end;
        }
        modify("Post and Print Prepmt. Invoic&e")
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
            end;
        }
        modify("Post and Print Prepmt. Cr. Mem&o")
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
            end;
        }
        modify(PostAndNew)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
            end;
        }
        modify(PostAndSend)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
            end;
        }
    }

    trigger OnOpenPage()
    begin
        GeneralLedgerSetup.GET;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 1 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_1 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 2 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_2 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 3 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_3 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 4 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_4 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 5 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_5 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 6 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_6 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 7 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_7 := TRUE;

        Dimension.RESET;
        Dimension.SETCURRENTKEY(Code);
        Dimension.SETRANGE(Code, GeneralLedgerSetup."Shortcut Dimension 8 Code");
        IF Dimension.FINDSET THEN
            IF Dimension."Use Dimension" = Dimension."Use Dimension"::Sales THEN
                ShowDim_8 := TRUE;
    end;

    PROCEDURE ValidateDim();
    BEGIN
        IF (ShowDim_1) AND (rec."Shortcut Dimension 1 Code" = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 1);
            ERROR(msg);
        END;

        IF (ShowDim_2) AND (rec."Shortcut Dimension 2 Code" = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 2);
            ERROR(msg);
        END;

        IF (ShowDim_3) AND (ShortcutDimCode[3] = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 3);
            ERROR(msg);
        END;

        IF (ShowDim_4) AND (ShortcutDimCode[4] = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 4);
            ERROR(msg);
        END;

        IF (ShowDim_5) AND (ShortcutDimCode[5] = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 5);
            ERROR(msg);
        END;
        IF (ShowDim_6) AND (ShortcutDimCode[6] = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 6);
            ERROR(msg);
        END;
        IF (ShowDim_7) AND (ShortcutDimCode[7] = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 7);
            ERROR(msg);
        END;
        IF (ShowDim_8) AND (ShortcutDimCode[8] = '') THEN BEGIN
            msg := STRSUBSTNO(Text50000, 8);
            ERROR(msg);
        END;
    END;

    var
        GeneralLedgerSetup: Record 98;
        Dimension: Record 348;
        codCli: Code[20];
        show: Boolean;
        ShortcutDimCode: ARRAY[8] OF Code[20];
        ShowDim: ARRAY[8] OF Boolean;
        i: Integer;
        ShowDim_1: Boolean;
        ShowDim_2: Boolean;
        ShowDim_3: Boolean;
        ShowDim_4: Boolean;
        ShowDim_5: Boolean;
        ShowDim_6: Boolean;
        ShowDim_7: Boolean;
        ShowDim_8: Boolean;
        msg: Text;
        Text50000: Label 'El valor de la dimension %1 no puede estar vacio';
        OpenPostedSalesOrderQst: Label 'El pedido se registró y se movió a la ventana de facturas de venta registradas.\\¿Quiere abrir la factura registrada?';
        OperationDescription: Text[500];

}
