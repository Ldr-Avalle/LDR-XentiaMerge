page 50016 "NºAsientos posible erroneos"
{
    ApplicationArea = All;
    Caption = '', Comment = 'ESP=""';
    PageType = List;
    SourceTable = "TBAI Alava2_LDR";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    Caption = 'ID', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Envios; Rec.Envios)
                {
                    ApplicationArea = All;
                    Caption = 'Envios', Comment = 'ESP=""';
                    ToolTip = 'Especifica';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        GLEntry: Record "G/L Entry";
                    begin
                        GLEntry.SetRange("Transaction No.", Rec.Envios);
                        Page.Run(Page::"General Ledger Entries", GLEntry);
                    end;
                }
                //TODO:PREGUNTAR A AITOR SI LOS AÑADO A LA TABLA DE LA QUE TIRA O LOS ELIMINO YA QUE NO LOS CONTIENE ACTUALMENTE ESTOS CAMPOS
                // field(Respuestas; Rec.Respuestas)
                // {
                //     ApplicationArea = All;
                //     Caption = '', Comment = 'ESP=""';
                //     ToolTip = 'Especifica';

                //     trigger OnLookup(var Text: Text): Boolean
                //     var
                //         GLEntry: Record "17";
                //     begin
                //         GLEntry.SETRANGE("Document No.", Rec.Respuestas);
                //         PAGE.RUN(20, GLEntry);
                //     end;
                // }
                // field("Posting Date"; Rec."Posting Date")
                // {
                //     ApplicationArea = All;
                //     Caption = '', Comment = 'ESP=""';
                //     ToolTip = 'Especifica';
                // }
                field(Configuracion; Rec.Configuracion)
                {
                    ApplicationArea = All;
                    Caption = 'Configuracion', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Visible = false;
                }
                field(R_Codigo; Rec.R_Codigo)
                {
                    ApplicationArea = All;
                    Caption = 'R_Codigo', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_URLTBAIAlava_envio; Rec.C_URLTBAIAlava_envio)
                {
                    ApplicationArea = All;
                    Caption = 'C_URLTBAIAlava_envio', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(NS_NosSerie6; Rec.NS_NosSerie6)
                {
                    ApplicationArea = All;
                    Caption = 'NS_NosSerie6', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_DEnvioFacturaSimple; Rec.C_DEnvioFacturaSimple)
                {
                    ApplicationArea = All;
                    Caption = 'C_DEnvioFacturaSimple', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_DirectorioFicherosNAV; Rec.C_DirectorioFicherosNAV)
                {
                    ApplicationArea = All;
                    Caption = 'C_DirectorioFicherosNAV', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(TipoRegistro; Rec.TipoRegistro)
                {
                    ApplicationArea = All;
                    Caption = 'TipoRegistro', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(NS_NosSerie7; Rec.NS_NosSerie7)
                {
                    ApplicationArea = All;
                    Caption = 'NS_NosSerie7', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_I_URLFormularioTBAIAlava; Rec.C_I_URLFormularioTBAIAlava)
                {
                    ApplicationArea = All;
                    Caption = 'C_I_URLFormularioTBAIAlava', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                // field(; Rec.NS_NosSerie8)
                // {
                //     ApplicationArea = All;
                //     Caption = '', Comment = 'ESP=""';
                //     ToolTip = 'Especifica';
                // }
                field(C_I_URLValidaciones; Rec.C_I_URLValidaciones)
                {
                    ApplicationArea = All;
                    Caption = 'C_I_URLValidaciones', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(MovContSinMovBank)
            {
                Caption = '1-MovContSinMovBank';
                Image = "Filter";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange(NS_NosSerie7/*, true*/); //TODO:REVISAR
                    CurrPage.Update();
                    Message(Format(Rec.Count));
                end;
            }
            action(MovBancoSinMovCont)
            {
                Caption = '2-MovBancoSinMovCont';
                Image = "Filter";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange(C_I_URLFormularioTBAIAlava/*, true*/);
                    CurrPage.Update();
                    Message(Format(Rec.Count));
                end;
            }
            action(MovBancCuentaNoEs52010)
            {
                Caption = '3-MovBancCuentaNoEs52010';
                Image = "Filter";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange(NS_NosSerie8/*, true*/);
                    CurrPage.Update();
                    Message(Format(Rec.Count));
                end;
            }
            action(AsientoSaldoErroneo)
            {
                Caption = '4-AsientoSaldoErroneo';
                Image = "Filter";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange(C_I_URLValidaciones/*, true*/);
                    CurrPage.Update();
                    Message(Format(Rec.Count));
                end;
            }
        }
    }
}