pageextension 50022 "Purchase Quote_LDR" extends "Purchase Quote"
{
    layout
    {
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
        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim();
            end;
        }
        modify(Reopen)
        {
            trigger OnBeforeAction()
            begin
                ValidateDim();
            end;
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    begin
        GeneralLedgerSetup.Get();

        Dimension.Reset();
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 1 Code");
        if Dimension.FindSet() then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_1 := true;

        Dimension.Reset();
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 2 Code");
        if Dimension.FindSet() then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_2 := true;

        Dimension.Reset();
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 3 Code");
        if Dimension.FindSet() then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_3 := true;

        Dimension.Reset();
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 4 Code");
        if Dimension.FindSet() then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_4 := true;

        Dimension.Reset();
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 5 Code");
        if Dimension.FindSet() then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_5 := true;

        Dimension.Reset();
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 6 Code");
        if Dimension.FindSet() then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_6 := true;

        Dimension.Reset();
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 7 Code");
        if Dimension.FindSet() then
            if Dimension."Use Dimension" = Dimension."Use Dimension"::Sales then
                ShowDim_7 := true;

        Dimension.Reset();
        Dimension.SetCurrentKey(Code);
        Dimension.SetRange(Code, GeneralLedgerSetup."Shortcut Dimension 8 Code");
        if Dimension.FindSet() then
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

}
