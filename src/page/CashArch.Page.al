page 50017 "Cash Arch"
{
    ApplicationArea = All;
    Caption = 'Arqueo de caja';
    PageType = Card;
    SourceTable = "Cash Arch_LDR";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            field(Date; Rec.Date)
            {
                ApplicationArea = All;
                Caption = 'Date', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("Start cash"; Rec."Start cash")
            {
                ApplicationArea = All;
                Caption = 'Start cash', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("*Importe existente en la caja al inicio de la jornada"; '')
            {
                ApplicationArea = All;
                Caption = '*Importe existente en la caja al inicio de la jornada';
                ToolTip = 'Especifica';
                MultiLine = true;
            }
            field("Cash Notes"; Rec."Cash Notes")
            {
                ApplicationArea = All;
                Caption = 'Cash Notes', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("1 cent."; Rec."1 cent.")
            {
                ApplicationArea = All;
                Caption = '1 cent.', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("2 cent."; Rec."2 cent.")
            {
                ApplicationArea = All;
                Caption = '2 cent.', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("5 cent."; Rec."5 cent.")
            {
                ApplicationArea = All;
                Caption = '5 cent.', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("10 cent."; Rec."10 cent.")
            {
                ApplicationArea = All;
                Caption = '10 cent.', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("20 cent."; Rec."20 cent.")
            {
                ApplicationArea = All;
                Caption = '20 cent.', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("50 cent."; Rec."50 cent.")
            {
                ApplicationArea = All;
                Caption = '50 cent.', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("1 euro"; Rec."1 euro")
            {
                ApplicationArea = All;
                Caption = '1 euro', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("2 euros"; Rec."2 euros")
            {
                ApplicationArea = All;
                Caption = '2 euros', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("5 euros"; Rec."5 euros")
            {
                ApplicationArea = All;
                Caption = '5 euros', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("10 euros"; Rec."10 euros")
            {
                ApplicationArea = All;
                Caption = '10 euros', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("20 euros"; Rec."20 euros")
            {
                ApplicationArea = All;
                Caption = '20 euros', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("50 euros"; Rec."50 euros")
            {
                ApplicationArea = All;
                Caption = '50 euros', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("100 euros"; Rec."100 euros")
            {
                ApplicationArea = All;
                Caption = '100 euros', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("200 euros"; Rec."200 euros")
            {
                ApplicationArea = All;
                Caption = '200 euros', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field("500 euros"; Rec."500 euros")
            {
                ApplicationArea = All;
                Caption = '500 euros', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            // field("Arch-Start cash"; Rec."Arch-Start cash") //TODO: REVISAR CAMPO
            // {
            //     Caption = 'Ventas contado';

            //     trigger OnDrillDown()
            //     begin
            //         LedgerEntry.SETFILTER("User ID", '%1', Rec."User ID");
            //         LedgerEntry.SETFILTER("Posting Date", '%1', Rec.Date);
            //         LedgerEntry.SETFILTER("G/L Account No.", '%1', '430000000');
            //         LedgerEntry.SETFILTER("Bal. Account No.", '%1..%2', '57', '579999999');

            //         IF LedgerEntry.FINDFIRST THEN
            //             PAGE.RUNMODAL(PAGE::"Ledger List", LedgerEntry);
            //     end;
            // }
            field("Card Sales"; Rec."Card Sales")
            {
                ApplicationArea = All;
                Caption = 'Card Sales', Comment = 'ESP=""';
                ToolTip = 'Especifica';

                trigger OnDrillDown()
                begin
                    LedgerEntry.SetFilter("User ID", '%1', Rec."User ID");
                    LedgerEntry.SetFilter("Posting Date", '%1', Rec.Date);
                    LedgerEntry.SetFilter("G/L Account No.", '%1', '430000000');
                    LedgerEntry.SetFilter("Bal. Account No.", '%1..%2', '55', '559999999');
                    if LedgerEntry.FindFirst() then
                        Page.RunModal(Page::"Ledger List", LedgerEntry);
                end;
            }
            field("POS Amount"; Rec."POS Amount")
            {
                ApplicationArea = All;
                Caption = 'POS Amount', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            // field(; '') //TODO: REVISAR CAMPO
            // {
            //     CaptionClass = Text19015188;
            // }
            field(Arch; Rec.Arch)
            {
                ApplicationArea = All;
                Caption = 'Arch', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            // field(; '') //TODO: REVISAR CAMPO
            // {
            //     CaptionClass = Text19032138;
            //     MultiLine = true;
            // }
            field("End cash"; Rec."end cash")
            {
                ApplicationArea = All;
                Caption = 'End cash', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            // field(; '') //TODO: REVISAR CAMPO
            // {
            //     CaptionClass = Text19070665;
            // }
            field(Discrepancy; Rec.Discrepancy)
            {
                ApplicationArea = All;
                Caption = 'Discrepancy', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            field(Comentarios; Rec.Comentarios)
            {
                ApplicationArea = All;
                Caption = 'Comentarios', Comment = 'ESP=""';
                ToolTip = 'Especifica';
                MultiLine = false;
            }
            field("Pay-to Bank"; Rec."Pay-to Bank")
            {
                ApplicationArea = All;
                Caption = 'Pay-to Bank', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
            // field(; '') //TODO: REVISAR CAMPO
            // {
            //     CaptionClass = Text19032010;
            // }
            field(Registered; Rec.Registered)
            {
                ApplicationArea = All;
                Caption = 'Registered', Comment = 'ESP=""';
                ToolTip = 'Especifica';
                Editable = false;
            }
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
                Caption = 'User ID', Comment = 'ESP=""';
                ToolTip = 'Especifica';
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(Acciones)
            {
                Caption = 'Acciones';
                action(Registrar)
                {
                    Caption = 'Registrar';

                    trigger OnAction()
                    begin
                        Rec.register();
                    end;
                }
                action(Lista)
                {
                    Caption = 'Lista';
                    RunObject = page "Cash Arch List";
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    var
        UserDims: Record "User Dimensions_LDR";
        gbldimensiones: Record "User Dimensions_LDR";
        LedgerEntry: Record "G/L Entry";
        Text19039054: Label '*Importe existente en la caja al inicio de la jornada                                                                                                                                                                             ';
        Text19015188: Label '*Resultado de la totalización del datáfono>                                                                                                                                                                                  ';
        Text19032138: Label '*Importe que debería haber en la caja al finalizar el día                                                                                                                                                                                  ';
        Text19070665: Label '*Importe existente en la caja al finalizar el día                                                                                                                                                                                  ';
        Text19032010: Label '*Cantidad ingresada en el banco                                                                                                                                                                                  ';

#pragma warning disable AL0299
    local procedure OnAfterGetCurrRecord()
#pragma warning restore AL0299
    begin
        xRec := Rec;
        if UserDims.existsUser(UserId) then Rec.SetFilter(Rec."User ID", '%1', UserId);
    end;
}