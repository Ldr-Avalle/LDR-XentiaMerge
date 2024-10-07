page 50033 "Ticket BAI Respuestas"
{
    ApplicationArea = All;
    Caption = 'Ticket BAI Respuestas', Comment = 'ESP=""';
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "TBAI Alava2_LDR";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Correcto; Rec.Correcto)
                {
                    ApplicationArea = All;
                    Caption = 'Correcto', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(No_Factura; Rec.No_Factura)
                {
                    ApplicationArea = All;
                    Caption = 'No_Factura', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(No_Factura_tbai; Rec.No_Factura_tbai)
                {
                    ApplicationArea = All;
                    Caption = 'No_Factura_tbai', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(R_Codigo; Rec.R_Codigo)
                {
                    ApplicationArea = All;
                    Caption = 'R_Codigo', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(R_Descripcion; Rec.R_Descripcion)
                {
                    ApplicationArea = All;
                    Caption = 'R_Descripcion', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(R_Descripcion_detallada; Rec.R_Descripcion_detallada)
                {
                    ApplicationArea = All;
                    Caption = 'R_Descripcion_detallada', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(R_FechaRecepcion; Rec.R_FechaRecepcion)
                {
                    ApplicationArea = All;
                    Caption = 'R_FechaRecepcion', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(R_Identificador_TBAI; Rec.R_Identificador_TBAI)
                {
                    ApplicationArea = All;
                    Caption = 'R_Identificador_TBAI', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(R_Estado; Rec.R_Estado)
                {
                    ApplicationArea = All;
                    Caption = 'R_Estado', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(R_SignatureValue; Rec.R_SignatureValue)
                {
                    ApplicationArea = All;
                    Caption = 'R_SignatureValue', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(QR_CodeString; Rec.QR_CodeString)
                {
                    ApplicationArea = All;
                    Caption = 'QR_CodeString', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(PreviousDocNo; Rec.PreviousDocNo)
                {
                    ApplicationArea = All;
                    Caption = 'PreviousDocNo', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(R_DocNoTBAI; Rec.R_DocNoTBAI)
                {
                    ApplicationArea = All;
                    Caption = 'R_DocNoTBAI', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(R_DocNoNAV; Rec.R_DocNoNAV)
                {
                    ApplicationArea = All;
                    Caption = 'R_DocNoNAV', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(SignedXMLDocname; Rec.SignedXMLDocname)
                {
                    ApplicationArea = All;
                    Caption = 'SignedXMLDocname', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(NavXMLDocName; Rec.NavXMLDocName)
                {
                    ApplicationArea = All;
                    Caption = 'NavXMLDocName', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(TipoRegistro, Rec.TipoRegistro::Respuesta);
    end;
}