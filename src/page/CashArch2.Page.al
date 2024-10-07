page 50047 "Cash Arch2"
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
            group(General)
            {
                Caption = 'General';
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
                // field(; '') //TODO:REVISAR CAMPO
                // {
                //     ApplicationArea = All;
                //     Caption = '', Comment = 'ESP=""';
                //     ToolTip = 'Especifica';
                //     CaptionClass = Text19039054;
                // }
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
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("10 cent."; Rec."10 cent.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("20 cent."; Rec."20 cent.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("50 cent."; Rec."50 cent.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("1 euro"; Rec."1 euro")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("2 euros"; Rec."2 euros")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                // field("Arch-Start cash"; Rec."Arch-Start cash") //TODO:REVISAR CAMPO
                // {
                //     ApplicationArea = All;
                //     Caption = '', Comment = 'ESP=""';
                //     ToolTip = 'Especifica';
                // }
                field("Card Sales"; Rec."Card Sales")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("POS Amount"; Rec."POS Amount")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                // field(; '') //TODO:REVISAR CAMPO
                // {
                //     ApplicationArea = All;
                //     Caption = '', Comment = 'ESP=""';
                //     ToolTip = 'Especifica';
                //     CaptionClass = Text19015188;
                // }
                field(Arch; Rec.Arch)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                // field(; '') //TODO:REVISAR CAMPO
                // {
                //     ApplicationArea = All;
                //     Caption = '', Comment = 'ESP=""';
                //     ToolTip = 'Especifica';
                //     CaptionClass = Text19032138;
                // }
                field("End cash"; Rec."end cash")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                // field(; '') //TODO:REVISAR CAMPO
                // {
                //     ApplicationArea = All;
                //     Caption = '', Comment = 'ESP=""';
                //     ToolTip = 'Especifica';
                //     CaptionClass = Text19070665;
                // }
                field(Discrepancy; Rec.Discrepancy)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Comentarios; Rec.Comentarios)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    MultiLine = true;
                }
                field("Pay-to Bank"; Rec."Pay-to Bank")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                // field(; '') //TODO:REVISAR CAMPO
                // {
                //     ApplicationArea = All;
                //     Caption = '', Comment = 'ESP=""';
                //     ToolTip = 'Especifica';
                //     CaptionClass = Text19032010;
                // }
                field("5 euros"; Rec."5 euros")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("10 euros"; Rec."10 euros")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("20 euros"; Rec."20 euros")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("50 euros"; Rec."50 euros")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("100 euros"; Rec."100 euros")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("200 euros"; Rec."200 euros")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("500 euros"; Rec."500 euros")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
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
        Text19039054: Label '*Importe existente en la caja al inicio de la jornada';
        Text19015188: Label '*Resultado de la totalización del datáfono';
        Text19032138: Label '*Importe que debería haber en la caja al finalizar el día';
        Text19070665: Label '*Importe existente en la caja al finalizar el día';
        Text19032010: Label '*Cantidad ingresada en el banco';

#pragma warning disable AL0299
    local procedure OnAfterGetCurrRecord()
#pragma warning restore AL0299
    begin
        xRec := Rec;
        if UserDims.existsUser(UserId) then Rec.SetFilter("User ID", '%1', UserId);
    end;
}