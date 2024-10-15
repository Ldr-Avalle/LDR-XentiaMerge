page 50031 "Ticket BAI Configuración"
{
    ApplicationArea = All;
    Caption = 'Ticket BAI Configuración';
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    ShowFilter = false;
    SourceTable = "TBAI Alava2_LDR";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(C_Activar; Rec.C_Activar)
                {
                    ApplicationArea = All;
                    Caption = 'C_Activar';
                    ToolTip = 'Especifica C_Activar';
                }
                field(C_ID_Empresa; Rec.C_ID_Empresa)
                {
                    ApplicationArea = All;
                    Caption = 'C_ID_Empresa';
                    ToolTip = 'Especifica C_ID_Empresa';
                }
                field(C_Role_TBAI; Rec.C_Role_TBAI)
                {
                    ApplicationArea = All;
                    Caption = 'C_Role_TBAI';
                    ToolTip = 'Especifica C_Role_TBAI';
                }
                field(C_Admin_user; Rec.C_Admin_user)
                {
                    ApplicationArea = All;
                    Caption = 'C_Admin_user';
                    ToolTip = 'Especifica C_Admin_user';
                }
                field(C_CertSubject; Rec.C_CertSubject)
                {
                    ApplicationArea = All;
                    Caption = 'C_CertSubject';
                    ToolTip = 'Especifica C_CertSubject';
                }
                field(C_URLTBAIAlava_envio; Rec.C_URLTBAIAlava_envio)
                {
                    ApplicationArea = All;
                    Caption = 'C_URLTBAIAlava_envio';
                    ToolTip = 'Especifica C_URLTBAIAlava_envio';
                }
                field(C_URLTBAIAlava_anulacion; Rec.C_URLTBAIAlava_anulacion)
                {
                    ApplicationArea = All;
                    Caption = 'C_URLTBAIAlava_anulacion';
                    ToolTip = 'Especifica C_URLTBAIAlava_anulacion';
                }
                field(C_URLTBAIAlavaQR; Rec.C_URLTBAIAlavaQR)
                {
                    ApplicationArea = All;
                    Caption = 'C_URLTBAIAlavaQR';
                    ToolTip = 'Especifica C_URLTBAIAlavaQR';
                }
                field(C_I_URLValidaciones; Rec.C_I_URLValidaciones)
                {
                    ApplicationArea = All;
                    Caption = 'C_I_URLValidaciones';
                    ToolTip = 'Especifica C_I_URLValidaciones';
                }
                field(C_NoSeriesTBAI; Rec.C_NoSeriesTBAI)
                {
                    ApplicationArea = All;
                    Caption = 'C_NoSeriesTBAI';
                    ToolTip = 'Especifica C_NoSeriesTBAI';
                }
                field(C_I_URLFormularioTBAIAlava; Rec.C_I_URLFormularioTBAIAlava)
                {
                    ApplicationArea = All;
                    Caption = 'C_I_URLFormularioTBAIAlava';
                    ToolTip = 'Especifica C_I_URLFormularioTBAIAlava';
                }
                group("Carpetas TBAI")
                {
                    Caption = 'Carpetas TBAI';
                    field(C_DirectorioFicherosNAV; Rec.C_DirectorioFicherosNAV)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DirectorioFicherosNAV';
                        ToolTip = 'Especifica C_DirectorioFicherosNAV';
                    }
                    field(C_DEnvioFactura; Rec.C_DEnvioFactura)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DEnvioFactura';
                        ToolTip = 'Especifica C_DEnvioFactura';
                    }
                    field(C_DEnvioFacturaRectificativa; Rec.C_DEnvioFacturaRectificativa)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DEnvioFacturaRectificativa';
                        ToolTip = 'Especifica C_DEnvioFacturaRectificativa';
                        Visible = false;
                    }
                    field(C_DEnvioFacturaSimple; Rec.C_DEnvioFacturaSimple)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DEnvioFacturaSimple';
                        ToolTip = 'Especifica C_DEnvioFacturaSimple';
                    }
                    field(C_DRespuestaEnvioFactura; Rec.C_DRespuestaEnvioFactura)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DRespuestaEnvioFactura';
                        ToolTip = 'Especifica C_DRespuestaEnvioFactura';
                    }
                    field(C_DRespuestaEnvioIncorrecto; Rec.C_DRespuestaEnvioIncorrecto)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DRespuestaEnvioIncorrecto';
                        ToolTip = 'Especifica C_DRespuestaEnvioIncorrecto';
                    }
                    field(C_DRespuestaEnvioFacturaRectf; Rec.C_DRespuestaEnvioFacturaRectf)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DRespuestaEnvioFacturaRectf';
                        ToolTip = 'Especifica C_DRespuestaEnvioFacturaRectf';
                        Visible = false;
                    }
                    field(C_DRespuestaEnvioFacturaSimple; Rec.C_DRespuestaEnvioFacturaSimple)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DRespuestaEnvioFacturaSimple';
                        ToolTip = 'Especifica C_DRespuestaEnvioFacturaSimple';
                    }
                    field(C_DZuzenduEnvioModificacion; Rec.C_DZuzenduEnvioModificacion)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DZuzenduEnvioModificacion';
                        ToolTip = 'Especifica C_DZuzenduEnvioModificacion';
                        Visible = false;
                    }
                    field(C_DZuzenduEnvioSubsanar; Rec.C_DZuzenduEnvioSubsanar)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DZuzenduEnvioSubsanar';
                        ToolTip = 'Especifica C_DZuzenduEnvioSubsanar';
                        Visible = false;
                    }
                    field(C_DZuzenduRespuestaEnvioIncorr; Rec.C_DZuzenduRespuestaEnvioIncorr)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DZuzenduRespuestaEnvioIncorr';
                        ToolTip = 'Especifica C_DZuzenduRespuestaEnvioIncorr';
                        Visible = false;
                    }
                    field(C_DZuzenduRespuestaEnvioCorrec; Rec.C_DZuzenduRespuestaEnvioCorrec)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DZuzenduRespuestaEnvioCorrec';
                        ToolTip = 'Especifica C_DZuzenduRespuestaEnvioCorrec';
                        Visible = false;
                    }
                }
                group("Datos Empresa desarrolladora")
                {
                    Caption = 'Datos Empresa desarrolladora';
                    field(C_IDVersionTBAI; Rec.C_IDVersionTBAI)
                    {
                        ApplicationArea = All;
                        Caption = 'C_IDVersionTBAI';
                        ToolTip = 'Especifica C_IDVersionTBAI';
                    }
                    field(C_LicenciaTBAI; Rec.C_LicenciaTBAI)
                    {
                        ApplicationArea = All;
                        Caption = 'C_LicenciaTBAI';
                        ToolTip = 'Especifica C_LicenciaTBAI';
                    }
                    field(C_Nombre; Rec.C_Nombre)
                    {
                        ApplicationArea = All;
                        Caption = 'C_Nombre';
                        ToolTip = 'Especifica C_Nombre';
                    }
                    field(C_Version; Rec.C_Version)
                    {
                        ApplicationArea = All;
                        Caption = 'C_Version';
                        ToolTip = 'Especifica C_Version';
                    }
                    field(C_NIF; Rec.C_NIF)
                    {
                        ApplicationArea = All;
                        Caption = 'C_NIF';
                        ToolTip = 'Especifica C_NIF';
                    }
                    field(C_NumSerieDispositivo; Rec.C_NumSerieDispositivo)
                    {
                        ApplicationArea = All;
                        Caption = 'C_NumSerieDispositivo';
                        ToolTip = 'Especifica C_NumSerieDispositivo';
                    }
                }
            }
            group("Envíos automáticos a Ticket BAI")
            {
                field(C_AutomaticSend; Rec.C_AutomaticSend)
                {
                    ApplicationArea = All;
                    Caption = 'C_AutomaticSend';
                    ToolTip = 'Especifica C_AutomaticSend';
                }
                field(C_FechaInicioEnvioTbai; Rec.C_FechaInicioEnvioTbai)
                {
                    ApplicationArea = All;
                    Caption = 'C_FechaInicioEnvioTbai';
                    ToolTip = 'Especifica C_FechaInicioEnvioTbai';
                }
                group("Nos. Serie configurados para el envío automático a Ticket BAI")
                {
                    Caption = 'Nos. Serie configurados para el envío automático a Ticket BAI';
                    field(NS_NosSerie1; Rec.NS_NosSerie1)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie1';
                        ToolTip = 'Especifica NS_NosSerie1';
                    }
                    field(NS_NosSerie2; Rec.NS_NosSerie2)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie2';
                        ToolTip = 'Especifica NS_NosSerie2';
                    }
                    field(NS_NosSerie3; Rec.NS_NosSerie3)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie3';
                        ToolTip = 'Especifica NS_NosSerie3';
                    }
                    field(NS_NosSerie4; Rec.NS_NosSerie4)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie4';
                        ToolTip = 'Especifica NS_NosSerie4';
                    }
                    field(NS_NosSerie5; Rec.NS_NosSerie5)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie5';
                        ToolTip = 'Especifica NS_NosSerie5';
                    }
                    field(NS_NosSerie6; Rec.NS_NosSerie6)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie6';
                        ToolTip = 'Especifica NS_NosSerie6';
                    }
                    field(NS_NosSerie7; Rec.NS_NosSerie7)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie7';
                        ToolTip = 'Especifica NS_NosSerie7';
                    }
                    field(NS_NosSerie8; Rec.NS_NosSerie8)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie8';
                        ToolTip = 'Especifica NS_NosSerie8';
                    }
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(TipoRegistro, Rec.TipoRegistro::Configuración);
    end;
}