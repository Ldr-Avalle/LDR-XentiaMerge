page 50031 "Ticket BAI Configuración"
{
    ApplicationArea = All;
    Caption = 'Ticket BAI Configuración', Comment = 'ESP=""';
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
                    Caption = 'C_Activar', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_ID_Empresa; Rec.C_ID_Empresa)
                {
                    ApplicationArea = All;
                    Caption = 'C_ID_Empresa', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_Role_TBAI; Rec.C_Role_TBAI)
                {
                    ApplicationArea = All;
                    Caption = 'C_Role_TBAI', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_Admin_user; Rec.C_Admin_user)
                {
                    ApplicationArea = All;
                    Caption = 'C_Admin_user', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_CertSubject; Rec.C_CertSubject)
                {
                    ApplicationArea = All;
                    Caption = 'C_CertSubject', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_URLTBAIAlava_envio; Rec.C_URLTBAIAlava_envio)
                {
                    ApplicationArea = All;
                    Caption = 'C_URLTBAIAlava_envio', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_URLTBAIAlava_anulacion; Rec.C_URLTBAIAlava_anulacion)
                {
                    ApplicationArea = All;
                    Caption = 'C_URLTBAIAlava_anulacion', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_URLTBAIAlavaQR; Rec.C_URLTBAIAlavaQR)
                {
                    ApplicationArea = All;
                    Caption = 'C_URLTBAIAlavaQR', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_I_URLValidaciones; Rec.C_I_URLValidaciones)
                {
                    ApplicationArea = All;
                    Caption = 'C_I_URLValidaciones', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_NoSeriesTBAI; Rec.C_NoSeriesTBAI)
                {
                    ApplicationArea = All;
                    Caption = 'C_NoSeriesTBAI', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_I_URLFormularioTBAIAlava; Rec.C_I_URLFormularioTBAIAlava)
                {
                    ApplicationArea = All;
                    Caption = 'C_I_URLFormularioTBAIAlava', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                group("Carpetas TBAI")
                {
                    Caption = 'Carpetas TBAI';
                    field(C_DirectorioFicherosNAV; Rec.C_DirectorioFicherosNAV)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DirectorioFicherosNAV', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(C_DEnvioFactura; Rec.C_DEnvioFactura)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DEnvioFactura', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(C_DEnvioFacturaRectificativa; Rec.C_DEnvioFacturaRectificativa)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DEnvioFacturaRectificativa', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                        Visible = false;
                    }
                    field(C_DEnvioFacturaSimple; Rec.C_DEnvioFacturaSimple)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DEnvioFacturaSimple', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(C_DRespuestaEnvioFactura; Rec.C_DRespuestaEnvioFactura)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DRespuestaEnvioFactura', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(C_DRespuestaEnvioIncorrecto; Rec.C_DRespuestaEnvioIncorrecto)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DRespuestaEnvioIncorrecto', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(C_DRespuestaEnvioFacturaRectf; Rec.C_DRespuestaEnvioFacturaRectf)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DRespuestaEnvioFacturaRectf', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                        Visible = false;
                    }
                    field(C_DRespuestaEnvioFacturaSimple; Rec.C_DRespuestaEnvioFacturaSimple)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DRespuestaEnvioFacturaSimple', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(C_DZuzenduEnvioModificacion; Rec.C_DZuzenduEnvioModificacion)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DZuzenduEnvioModificacion', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                        Visible = false;
                    }
                    field(C_DZuzenduEnvioSubsanar; Rec.C_DZuzenduEnvioSubsanar)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DZuzenduEnvioSubsanar', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                        Visible = false;
                    }
                    field(C_DZuzenduRespuestaEnvioIncorr; Rec.C_DZuzenduRespuestaEnvioIncorr)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DZuzenduRespuestaEnvioIncorr', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                        Visible = false;
                    }
                    field(C_DZuzenduRespuestaEnvioCorrec; Rec.C_DZuzenduRespuestaEnvioCorrec)
                    {
                        ApplicationArea = All;
                        Caption = 'C_DZuzenduRespuestaEnvioCorrec', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                        Visible = false;
                    }
                }
                group("Datos Empresa desarrolladora")
                {
                    Caption = 'Datos Empresa desarrolladora';
                    field(C_IDVersionTBAI; Rec.C_IDVersionTBAI)
                    {
                        ApplicationArea = All;
                        Caption = 'C_IDVersionTBAI', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(C_LicenciaTBAI; Rec.C_LicenciaTBAI)
                    {
                        ApplicationArea = All;
                        Caption = 'C_LicenciaTBAI', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(C_Nombre; Rec.C_Nombre)
                    {
                        ApplicationArea = All;
                        Caption = 'C_Nombre', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(C_Version; Rec.C_Version)
                    {
                        ApplicationArea = All;
                        Caption = 'C_Version', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(C_NIF; Rec.C_NIF)
                    {
                        ApplicationArea = All;
                        Caption = 'C_NIF', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(C_NumSerieDispositivo; Rec.C_NumSerieDispositivo)
                    {
                        ApplicationArea = All;
                        Caption = 'C_NumSerieDispositivo', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                }
            }
            group("Envíos automáticos a Ticket BAI")
            {
                field(C_AutomaticSend; Rec.C_AutomaticSend)
                {
                    ApplicationArea = All;
                    Caption = 'C_AutomaticSend', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(C_FechaInicioEnvioTbai; Rec.C_FechaInicioEnvioTbai)
                {
                    ApplicationArea = All;
                    Caption = 'C_FechaInicioEnvioTbai', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                group("Nos. Serie configurados para el env´Š¢o autom´Š¢tico a Ticket BAI")
                {
                    Caption = 'Nos. Serie configurados para el envío automático a Ticket BAI';
                    field(NS_NosSerie1; Rec.NS_NosSerie1)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie1', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(NS_NosSerie2; Rec.NS_NosSerie2)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie2', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(NS_NosSerie3; Rec.NS_NosSerie3)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie3', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(NS_NosSerie4; Rec.NS_NosSerie4)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie4', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(NS_NosSerie5; Rec.NS_NosSerie5)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie5', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(NS_NosSerie6; Rec.NS_NosSerie6)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie6', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(NS_NosSerie7; Rec.NS_NosSerie7)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie7', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
                    }
                    field(NS_NosSerie8; Rec.NS_NosSerie8)
                    {
                        ApplicationArea = All;
                        Caption = 'NS_NosSerie8', Comment = 'ESP=""';
                        ToolTip = 'Especifica';
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