pageextension 50017 "Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addafter("Sell-to Customer No.")
        {
            field(codCli; codCli)
            {
                ApplicationArea = all;
                Visible = DocNoVisible;
                Caption = 'CIF Cliente';
                trigger OnValidate()
                VAR
                    Cust: Record 18;
                BEGIN
                    //nuevo
                    //CARLOS COSME
                    IF codCli <> '' THEN BEGIN
                        IF Cust.GET(codCli) = FALSE THEN BEGIN
                            IF CONFIRM('No existe ning£n cliente con ese CIF.\¨Lo quiere crear?') THEN BEGIN
                                Cust.INIT;
                                Cust."No." := codCli;
                                Cust.INSERT(TRUE);
                                PAGE.RUN(PAGE::"Customer Card", Cust);
                                //VALIDATE("Sell-to Customer No.", codCli);
                            END;
                        END ELSE
                            rec.VALIDATE("Sell-to Customer No.", codCli);
                    END;
                    CodClienOnAfterValidate;
                END;

                trigger OnLookup(var text: Text): Boolean
                VAR
                    Customer: Record 18;
                BEGIN
                    //nuevo
                    //CARLOS COSME - si no existe el cliente abro la ficha
                    IF Customer.GET(Text) = FALSE THEN BEGIN
                        Customer.INIT;
                        Customer.VALIDATE("No.", Text);
                        Customer.INSERT(TRUE);
                        COMMIT;
                        PAGE.RUNMODAL(PAGE::"Customer Card", Customer);
                    END;
                END;
            }
        }
        addafter("Posting No.")
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = all;
            }
            /*
            field("Prices Including VAT"; Rec."Prices Including VAT")
            {
                ApplicationArea = all;
            }
            */
            field("Amount Including VAT"; Rec."Amount Including VAT")
            {
                ApplicationArea = all;
            }
        }
        addafter("Succeeded VAT Registration No.")
        {
            field(FacturaFin; Rec.FacturaFin)
            {
                ApplicationArea = all;
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
        addlast(General)
        {
            field("Factura Simplificada"; Rec."Factura Simplificada")
            {
                trigger OnValidate()
                BEGIN
                    IF rec."Factura Simplificada" = Rec."Factura Simplificada"::N THEN
                        FacturaSimplificada := FALSE;
                END;
            }
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = all;
            Visible = ShowDim_1;
            trigger OnBeforeValidate()
            begin
                CurrPage.SalesLines.PAGE.UpdatePage(TRUE);
            end;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = all;
            Visible = ShowDim_2;
            trigger OnBeforeValidate()
            begin
                CurrPage.SalesLines.PAGE.UpdatePage(TRUE);
            end;
        }
        modify("External Document No.")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Salesperson Code")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Posting No.")
        {
            Visible = true;
        }
        modify("Bill-to Contact No.")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Bill-to Name")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Bill-to Address")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Bill-to Address 2")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Bill-to Post Code")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Bill-to City")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Bill-to County")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Bill-to Country/Region Code")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Ship-to Code")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Ship-to Name")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Ship-to Address")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Ship-to Address 2")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Ship-to Post Code")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Ship-to City")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Ship-to County")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Ship-to Contact")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Shipment Method Code")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Shipping Agent Code")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Package Tracking No.")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Shipment Date")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Applies-to Doc. Type")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Applies-to Doc. No.")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Cust. Bank Acc. Code")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Currency Code")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("EU 3-Party Trade")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Transaction Type")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Transaction Specification")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Transport Method")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify("Exit Point")
        {
            Visible = show;
            ApplicationArea = all;
        }
        modify(SalesLines)
        {
            Visible = show;
        }
    }

    actions
    {
        addafter(Post)
        {
            action(Finalizar)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Finalizar';
                Image = PostOrder;
                ShortCutKey = 'Shift+F9';
                //AboutTitle = 'When all is set, you post';
                //AboutText = 'After entering the sales lines and other information, you post the invoice to make it count.? After posting, the sales invoice is moved to the Posted Sales Invoices list.';
                //ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                begin
                    ValidateDim;
                    PAGE.RUNMODAL(PAGE::"Invoice Payment Method", Rec);

                END;
            }
        }
        modify(CalculateInvoiceDiscount)
        {
            Visible = false;
        }
        modify(CalculateInvoiceDiscount_Promoted)
        {
            Visible = false;
        }
        modify(Post)
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
    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        clear(codCli);
    end;

    trigger OnAfterGetCurrRecord()
    var
        UserDims: Record 50000;
    begin
        codCli := rec."Sell-to Customer No.";
        IF UserDims.existsUser(USERID) THEN
            rec.SETFILTER("Assigned User ID", '%1', USERID); //CARLOS COSME
        show := NOT UserDims.existsUser(USERID);

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

    PROCEDURE CodClienOnAfterValidate();
    BEGIN
        CurrPage.UPDATE;
    END;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions(rec."Dimension Set ID", ShortcutDimCode);
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        GeneralLedgerSetup: Record 98;
        Dimension: Record 348;
        codCli: Code[20];
        DocNoVisible: Boolean;
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
        Text50000: Label 'El valor de la dimension %1 no puede estar vacio';
        msg: Text;
        OperationDescription: Text[500];
        TicketBAI: Codeunit 10700;
        TBAIActivated: Boolean;
        facturarectificativa: Boolean;
        Factura3odest: Boolean;
        FacturaSimplificadaSustituci: Boolean;
        FacturaSimplificada: Boolean;
        SerieFacturaAnterior_: Text;
        NumFacturaAnterior_: Code[20];
        FechaExpedicionFacturaAnterior_: Text;
        SignatureValueFirmaFacturaAnterior_: Text;
        TBAIManagement: Codeunit 10700;
}
