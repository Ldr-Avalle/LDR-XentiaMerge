pageextension 50024 "Purchase Invoice_LDR" extends "Purchase Invoice"
{
    layout
    {
        addafter("Buy-from Contact")
        {
            field("Posting No. Series_LDR"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
            field("Posting No._LDR"; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field(ShortcutDimCode3_LDR; ShortcutDimCode[3])
            {
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3),
                                                            "Dimension Value Type" = const(Standard),
                                                            Blocked = const(false));
                Visible = ShowDim_3;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
            field(ShortcutDimCode4_LDR; ShortcutDimCode[4])
            {
                CaptionClass = '1,2,4';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4),
                                                            "Dimension Value Type" = const(Standard),
                                                            Blocked = const(false));
                Visible = ShowDim_4;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                end;
            }
            field(ShortcutDimCode5_LDR; ShortcutDimCode[5])
            {
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5),
                                                            "Dimension Value Type" = const(Standard),
                                                            Blocked = const(false));
                Visible = ShowDim_5;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                end;
            }
            field(ShortcutDimCode6_LDR; ShortcutDimCode[6])
            {
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6),
                                                            "Dimension Value Type" = const(Standard),
                                                            Blocked = const(false));
                Visible = ShowDim_6;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                end;
            }
            field(ShortcutDimCode7_LDR; ShortcutDimCode[7])
            {
                CaptionClass = '1,2,7';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7),
                                                            "Dimension Value Type" = const(Standard),
                                                            Blocked = const(false));
                Visible = ShowDim_7;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                end;
            }
            field(ShortcutDimCode8_LDR; ShortcutDimCode[8])
            {
                CaptionClass = '1,2,8';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8),
                                                            "Dimension Value Type" = const(Standard),
                                                            Blocked = const(false));
                Visible = ShowDim_8;
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                end;
            }
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = All;
            Visible = ShowDim_1;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = All;
            Visible = ShowDim_2;
        }
    }
    actions
    {
        addafter(Reopen)
        {
            action(AsientoRetencion_LDR)
            {
                Caption = 'Proponer Asiento de Retención';
                ApplicationArea = All;
                trigger OnAction()
                var
                    rec23: Record Vendor;
                    rec39: Record "Purchase Line";
                    rec39b: Record "Purchase Line";
                    NextLineNo: Integer;
                    totalRetencion: Decimal;
                begin
                    rec23.Get(Rec."Buy-from Vendor No.");
                    if CopyStr(rec23."No.", 1, 2) <> 'AC' then Error('Solo pueden practicarse retenciones a acreedores');
                    rec23.TestField("Retención");

                    rec23.TestField("No.Cuenta");

                    //si ya existe la l­nea de retenci½n la elimino
                    rec39.SetRange("Document Type", Rec."Document Type");
                    rec39.SetRange("Document No.", Rec."No.");
                    rec39.SetRange(Type, rec39.Type::"G/L Account");
                    rec39.SetRange("No.", rec23."No.Cuenta");
                    if rec39.FindFirst then rec39.Delete;

                    //recupero el nœmero de la l­nea a insertar con la propuesta de retenci½n
                    NextLineNo := 10000;
                    rec39b.SetRange("Document Type", Rec."Document Type");
                    rec39b.SetRange("Document No.", Rec."No.");
                    rec39b.SetRange(Retenible, true);
                    if rec39b.Find('+') then
                        NextLineNo := rec39b."Line No." + 10000;

                    //recorro las l­neas calculando la retenci½n de cada una y actualizando el total de l­nea
                    totalRetencion := 0;
                    rec39b.SetFilter(Type, '<>0');
                    if rec39b.FindFirst then
                        repeat
                            totalRetencion := totalRetencion + Round(rec39b."Line Amount" * rec23."Retención", 0.01);
                        until rec39b.Next = 0;

                    //inserto la l­nea de retenci½n si no existe
                    rec39.Init;
                    rec39."Document Type" := Rec."Document Type";
                    rec39."Document No." := Rec."No.";
                    rec39."Line No." := NextLineNo;
                    rec39.Type := rec39.Type::"G/L Account";
                    rec39.Validate("No.", rec23."No.Cuenta");
                    rec39.Validate(Quantity, 1);
                    rec39.Validate("Direct Unit Cost", -totalRetencion);
                    rec39.Insert;
                end;
            }
        }
        addafter(MoveNegativeLines)
        {
            action(PrononerAsientosRetencion_LDR)
            {
                ApplicationArea = All;
                Caption = 'Proponer Asientos de Retención';
                trigger OnAction()
                var
                    rec23: Record Vendor;
                    rec39: Record "Purchase Line";
                    rec39b: Record "Purchase Line";
                    NextLineNo: Integer;
                    totalRetencion: Decimal;
                    UltimaLinea: Integer;
                begin
                    if Rec.Amount > 0 then begin
                        rec23.Get(Rec."Buy-from Vendor No.");
                        //IF rec23."No. Series" <> 'AC' THEN ERROR('Solo pueden practicarse retenciones a acreedores'); // comento c¢digo, la retenci¢n puede aplicarse a prov. y acr.
                        rec23.TestField("Retención");

                        rec23.TestField("No.Cuenta");

                        //si ya existe la l¡nea de retenci¢n la elimino
                        rec39.SetRange("Document Type", Rec."Document Type");
                        rec39.SetRange("Document No.", Rec."No.");
                        rec39.SetRange(Type, rec39.Type::"G/L Account");
                        rec39.SetRange("No.", rec23."No.Cuenta");

                        if rec39.FindFirst then rec39.Delete;

                        //recupero el n£mero de la l¡nea a insertar con la propuesta de retenci¢n

                        //posicionarse en £ltima l¡nea
                        rec39b.SetFilter("Document No.", Rec."No.");
                        if rec39b.FindLast then
                            UltimaLinea := rec39b."Line No.";
                        //MESSAGE('%1',UltimaLinea);
                        //posicionarse en £ltima l¡nea

                        NextLineNo := 10000;
                        rec39b.SetRange("Document Type", Rec."Document Type");
                        rec39b.SetRange("Document No.", Rec."No.");
                        rec39b.SetRange(Retenible, true);
                        if rec39b.Find('+') then
                            NextLineNo := UltimaLinea + 10000; //cambio rec39b."Line No." por UltimaLinea

                        //recorro las l¡neas calculando la retenci¢n de cada una y actualizando el total de l¡nea
                        totalRetencion := 0;
                        rec39b.SetFilter(Type, '<>0');
                        if rec39b.FindFirst then
                            repeat
                                totalRetencion := totalRetencion + Round(rec39b."Line Amount" * rec23."Retención", 0.01);

                            until rec39b.Next = 0;

                        //inserto la l¡nea de retenci¢n si no existe
                        rec39.Init;
                        rec39."Document Type" := Rec."Document Type";
                        rec39."Document No." := Rec."No.";
                        rec39."Line No." := NextLineNo;
                        rec39.Type := rec39.Type::"G/L Account";
                        rec39.Validate("No.", rec23."No.Cuenta");

                        rec39.Validate(Quantity, 1);
                        rec39.Validate("Direct Unit Cost", -totalRetencion);
                        rec39.Insert;
                    end;
                end;
            }
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
            end;
        }
        modify(TestReport)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
            end;
        }
        modify(PostBatch)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim;
            end;
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);
    end;

    trigger OnOpenPage()
    begin
        GeneralLedgerSetup.Get;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 1 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_1 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 2 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_2 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 3 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_3 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 4 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_4 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 5 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_5 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 6 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_6 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 7 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_7 := true;

        Dimension.Reset;
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 8 Code");
        if Dimension.FindSet then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_8 := true;
    end;

    procedure ValidateDim();
    begin
        if (ShowDim_1) and (Rec."Shortcut Dimension 1 Code" = '') then begin
            msg := StrSubstNo(Text50000, 1);
            Error(msg);
        end;

        if (ShowDim_2) and (Rec."Shortcut Dimension 2 Code" = '') then begin
            msg := StrSubstNo(Text50000, 2);
            Error(msg);
        end;

        if (ShowDim_3) and (ShortcutDimCode[3] = '') then begin
            msg := StrSubstNo(Text50000, 3);
            Error(msg);
        end;

        if (ShowDim_4) and (ShortcutDimCode[4] = '') then begin
            msg := StrSubstNo(Text50000, 4);
            Error(msg);
        end;

        if (ShowDim_5) and (ShortcutDimCode[5] = '') then begin
            msg := StrSubstNo(Text50000, 5);
            Error(msg);
        end;
        if (ShowDim_6) and (ShortcutDimCode[6] = '') then begin
            msg := StrSubstNo(Text50000, 6);
            Error(msg);
        end;
        if (ShowDim_7) and (ShortcutDimCode[7] = '') then begin
            msg := StrSubstNo(Text50000, 7);
            Error(msg);
        end;
        if (ShowDim_8) and (ShortcutDimCode[8] = '') then begin
            msg := StrSubstNo(Text50000, 8);
            Error(msg);
        end;
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        GeneralLedgerSetup: Record "General Ledger Setup";
        Dimension: Record Dimension;
        //codCli: Code[20];
        //show: Boolean;
        ShortcutDimCode: array[8] of Code[20];
        //ShowDim: array[8] of Boolean;
        //i: Integer;
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
    //OperationDescription: Text[500];
}
