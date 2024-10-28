pageextension 50025 "Purchase Credit Memo" extends "Purchase Credit Memo"
{
    layout
    {
        addafter("Corrected Invoice No.")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
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
        addafter(Reopen)
        {
            action(ProponerAsientoRetencion)
            {
                Caption = 'Proponer Asiento de Retención';
                trigger OnAction()
                VAR
                    rec23: Record 23;
                    rec39: Record 39;
                    rec39b: Record 39;
                    NextLineNo: Integer;
                    totalRetencion: Decimal;
                BEGIN
                    rec23.GET(rec."Buy-from Vendor No.");
                    IF COPYSTR(rec23."No.", 1, 2) <> 'AC' THEN ERROR('Solo pueden practicarse retenciones a acreedores');
                    rec23.TESTFIELD("Retención");

                    rec23.TESTFIELD("No.Cuenta");

                    //si ya existe la l­nea de retenci½n la elimino
                    rec39.SETRANGE("Document Type", rec."Document Type");
                    rec39.SETRANGE("Document No.", rec."No.");
                    rec39.SETRANGE(Type, rec39.Type::"G/L Account");
                    rec39.SETRANGE("No.", rec23."No.Cuenta");
                    IF rec39.FINDFIRST THEN rec39.DELETE;

                    //recupero el nœmero de la l­nea a insertar con la propuesta de retenci½n
                    NextLineNo := 10000;
                    rec39b.SETRANGE("Document Type", rec."Document Type");
                    rec39b.SETRANGE("Document No.", rec."No.");
                    rec39b.SETRANGE(Retenible, TRUE);
                    IF rec39b.FIND('+') THEN
                        NextLineNo := rec39b."Line No." + 10000;

                    //recorro las l­neas calculando la retenci½n de cada una y actualizando el total de l­nea
                    totalRetencion := 0;
                    rec39b.SETFILTER(Type, '<>0');
                    IF rec39b.FINDFIRST THEN BEGIN
                        REPEAT
                            totalRetencion := totalRetencion + ROUND(rec39b."Line Amount" * rec23."Retención", 0.01);
                        UNTIL rec39b.NEXT = 0;
                    END;

                    //inserto la l­nea de retenci½n si no existe
                    rec39.INIT;
                    rec39."Document Type" := rec."Document Type";
                    rec39."Document No." := rec."No.";
                    rec39."Line No." := NextLineNo;
                    rec39.Type := rec39.Type::"G/L Account";
                    rec39.VALIDATE("No.", rec23."No.Cuenta");
                    rec39.VALIDATE(Quantity, 1);
                    rec39.VALIDATE("Direct Unit Cost", -totalRetencion);
                    rec39.INSERT;
                END;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

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
        OperationDescription: Text[500];
}
