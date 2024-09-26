table 50007 "TBAI Alava2_LDR"
{
    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; Envios; Option)
        {
            Caption = 'Envíos';
            DataClassification = ToBeClassified;
            OptionCaption = ', Envío Factura , Envío Factura Simplificada, Envío Factura Rectificativa, Zuzendu Subsanar, Zuzendu Modificación';
            OptionMembers = ," Envío Factura "," Envío Factura Simplificada"," Envío Factura Rectificativa"," Zuzendu Subsanar"," Zuzendu Modificación";
        }
        field(3; Respuestas; Option)
        {
            Caption = 'Respuestas';
            DataClassification = ToBeClassified;
            OptionCaption = ',Respuesta Envío Tbai, Respues Envío Zuzendu';
            OptionMembers = ,"Respuesta Envío Tbai"," Respues Envío Zuzendu";
        }
        field(5; Correcto; Boolean)
        {
            Caption = 'Correcto';
            DataClassification = ToBeClassified;
        }
        field(6; Configuracion; Boolean)
        {
            Caption = 'Configuración';
            DataClassification = ToBeClassified;
        }
        field(7; R_Codigo; Text[30])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
        }
        field(8; R_Descripcion; Text[30])
        {
            Caption = 'Descripción';
            DataClassification = ToBeClassified;
        }
        field(9; R_Descripcion_detallada; Text[250])
        {
            Caption = 'Descripción detallada';
            DataClassification = ToBeClassified;
        }
        field(10; R_FechaRecepcion; DateTime)
        {
            Caption = 'Fecha Recepción';
            DataClassification = ToBeClassified;
        }
        field(11; R_Identificador_TBAI; Text[100])
        {
            Caption = 'Identificador TBAI';
            DataClassification = ToBeClassified;
        }
        field(12; No_Factura; Code[35])
        {
            Caption = 'Nº Documento Dynamics Nav';
            DataClassification = ToBeClassified;
            TableRelation = "Sales Invoice Header"."No." where("No." = field(No_Factura));
        }
        field(13; C_ID_Empresa; Text[100])
        {
            Caption = 'Id. Empresa';
            TableRelation = "Company Information".Name;
#pragma warning disable AL0667
            TestTableRelation = false;
#pragma warning restore AL0667
            ValidateTableRelation = false;
        }
        field(14; C_Admin_user; Text[100])
        {
            Caption = 'Admin. user';
            DataClassification = ToBeClassified;
        }
        field(15; C_DEnvioFactura; Text[150])
        {
            Caption = 'Envío factura';
            DataClassification = ToBeClassified;
        }
        field(16; C_DEnvioFacturaRectificativa; Text[150])
        {
            Caption = 'Envio factura rectificativa';
            DataClassification = ToBeClassified;
        }
        field(17; C_DEnvioFacturaSimple; Text[150])
        {
            Caption = 'Envio factura simple';
            DataClassification = ToBeClassified;
        }
        field(18; C_DRespuestaEnvioFactura; Text[150])
        {
            Caption = 'Respuesta envío factura';
        }
        field(19; C_DRespuestaEnvioIncorrecto; Text[150])
        {
            Caption = 'Respuesta envío incorrecto';
            DataClassification = ToBeClassified;
        }
        field(20; C_DRespuestaEnvioFacturaRectf; Text[150])
        {
            Caption = 'Respuesta envío factura rectificativa';
            DataClassification = ToBeClassified;
        }
        field(21; C_DRespuestaEnvioFacturaSimple; Text[150])
        {
            Caption = 'Respuesta envío factura simple';
            DataClassification = ToBeClassified;
        }
        field(22; C_DZuzenduEnvioModificacion; Text[150])
        {
            Caption = 'Zuzendu envío modificacion';
            DataClassification = ToBeClassified;
        }
        field(23; C_DZuzenduEnvioSubsanar; Text[100])
        {
            Caption = 'Zuzendu envío subsanar';
            DataClassification = ToBeClassified;
        }
        field(24; C_DZuzenduRespuestaEnvioIncorr; Text[100])
        {
            Caption = 'Zuzendu respuesta envío incorrecto';
            DataClassification = ToBeClassified;
        }
        field(25; C_DZuzenduRespuestaEnvioCorrec; Text[100])
        {
            Caption = 'Zuzendu respuesta envío correcto';
            DataClassification = ToBeClassified;
        }
        field(26; C_Activar; Boolean)
        {
            Caption = 'Activar';
            DataClassification = ToBeClassified;
        }
        field(27; C_CertSubject; Text[100])
        {
            Caption = 'Certificado de persona empresa';
            DataClassification = ToBeClassified;
        }
        field(28; C_URLTBAIAlava_envio; Text[200])
        {
            Caption = 'Dirección Servicio REST TBAI Álava envío';
            DataClassification = ToBeClassified;
        }
        field(29; C_I_URLValidaciones; Text[100])
        {
            Caption = 'Dirección WEB Validaciones envío';
            DataClassification = ToBeClassified;
        }
        field(30; C_I_URLFormularioTBAIAlava; Text[100])
        {
            Caption = 'Dirección WEB formulario facturaraba';
            DataClassification = ToBeClassified;
        }
        field(31; C_DirectorioFicherosNAV; Text[100])
        {
            Caption = 'Ficheros generados por NAV';
            DataClassification = ToBeClassified;
        }
        field(32; TipoRegistro; Option)
        {
            Caption = 'Tipo Registro';
            OptionCaption = ',Configuración, Envío, Respuesta, Anulación';
            OptionMembers = ,"Configuración","Envío",Respuesta,"Anulación";
        }
        field(33; C_NoSeriesTBAI; Code[10])
        {
            Caption = 'Nº Serie TBAI';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34; C_IDVersionTBAI; Code[10])
        {
            Caption = 'Id. Version TBAI';
            DataClassification = ToBeClassified;
        }
        field(35; C_LicenciaTBAI; Code[20])
        {
            Caption = 'Licencia TBAI';
            DataClassification = ToBeClassified;
        }
        field(36; C_Nombre; Code[50])
        {
            Caption = 'Nombre';
            DataClassification = ToBeClassified;
        }
        field(37; C_Version; Code[5])
        {
            Caption = 'Versión';
            DataClassification = ToBeClassified;
        }
        field(38; C_NIF; Code[20])
        {
            Caption = 'NIF';
            DataClassification = ToBeClassified;
        }
        field(39; C_NumSerieDispositivo; Code[10])
        {
            Caption = 'Num serie dispositivo';
            DataClassification = ToBeClassified;
        }
        field(40; C_URLTBAIAlavaQR; Text[150])
        {
            Caption = 'Dirección Servicio TBAI Álava QR';
            DataClassification = ToBeClassified;
        }
        field(41; R_Estado; Text[30])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
        }
        field(42; SignedXMLDocname; Text[100])
        {
            Caption = 'Nombre fichero XML firmado';
            DataClassification = ToBeClassified;
        }
        field(43; No_Factura_tbai; Code[35])
        {
            Caption = 'Nº documento TBAI';
            DataClassification = ToBeClassified;
        }
        field(44; R_DocNoTBAI; Text[20])
        {
            Caption = 'Valor documento TBAI';
            DataClassification = ToBeClassified;
        }
        field(45; R_DocNoNAV; Text[20])
        {
            Caption = 'Valor documento NAV';
            DataClassification = ToBeClassified;
        }
        field(46; R_SignatureValue; Text[100])
        {
            Caption = 'Valor firma';
            DataClassification = ToBeClassified;
        }
        field(47; QR_CodeString; Text[200])
        {
            Caption = 'Cadena QR';
            DataClassification = ToBeClassified;
        }
        field(48; PreviousDocNo; Code[20])
        {
            Caption = 'Nº documento anterior';
            DataClassification = ToBeClassified;
        }
        field(49; NavXMLDocName; Text[100])
        {
            Caption = 'Nombre fichero XML generado por NAV';
            DataClassification = ToBeClassified;
        }
        field(50; C_URLTBAIAlava_anulacion; Text[100])
        {
            Caption = 'Dirección Servicio REST TBAI Álava anulación';
            DataClassification = ToBeClassified;
        }
        field(51; RegistroEstado; Option)
        {
            Caption = 'Estado del Documento';
            DataClassification = ToBeClassified;
            OptionCaption = ',Enviado, Anulado, Rectificado, Modificado';
            OptionMembers = ,Enviado,Anulado,Rectificado,Modificado;
        }
        field(52; NS_NosSerie1; Code[10])
        {
            Caption = 'Nos. series 1';
            DataClassification = ToBeClassified;
            Description = 'FVR_REC';
            TableRelation = "No. Series";
        }
        field(53; NS_NosSerie2; Code[10])
        {
            Caption = 'Nos. series 2';
            DataClassification = ToBeClassified;
            Description = 'AB_RVRREC';
            TableRelation = "No. Series";
        }
        field(54; NS_NosSerie3; Code[10])
        {
            Caption = 'Nos. series 3';
            DataClassification = ToBeClassified;
            Description = 'AB_RVRREC';
            TableRelation = "No. Series";
        }
        field(55; C_FechaInicioEnvioTbai; Date)
        {
            Caption = 'Fecha inicio envío a TBAI Álava';
            DataClassification = ToBeClassified;
        }
        field(56; NS_NosSerie4; Code[10])
        {
            Caption = 'Nos. series 4';
            DataClassification = ToBeClassified;
            Description = 'FVR';
            TableRelation = "No. Series";
        }
        field(57; NS_NosSerie5; Code[10])
        {
            Caption = 'Nos. series 5';
            DataClassification = ToBeClassified;
            Description = '3.V-AB+';
            TableRelation = "No. Series";
        }
        field(58; NS_NosSerie6; Code[10])
        {
            Caption = 'Nos. series 6';
            DataClassification = ToBeClassified;
            Description = '4.TPV';
            TableRelation = "No. Series";
        }
        field(59; NS_NosSerie7; Code[10])
        {
            Caption = 'Nos. Series 7';
            DataClassification = ToBeClassified;
            Description = 'FVRT';
            TableRelation = "No. Series";
        }
        field(60; NS_NosSerie8; Code[10])
        {
            Caption = 'Nos. series 8';
            DataClassification = ToBeClassified;
            Description = 'AB-FVRT';
            TableRelation = "No. Series";
        }
        field(69; AnulacionPorAbonoNo; Code[20])
        {
            Caption = 'Anulación por Nº. abono';
            DataClassification = ToBeClassified;
        }
        field(70; C_Role_TBAI; Code[20])
        {
            Caption = 'Rol Administradores/as';
            DataClassification = ToBeClassified;
            TableRelation = "Access Control"."Role ID";
        }
        field(71; C_AutomaticSend; Boolean)
        {
            Caption = 'Activar envíos automáticos';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No_Factura_tbai, No_Factura, TipoRegistro, RegistroEstado)
        {
        }
    }
}

