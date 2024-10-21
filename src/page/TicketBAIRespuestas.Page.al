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
                    Caption = 'Correcto';
                    ToolTip = 'Especifica el correcto';
                }
                field(No_Factura; Rec.No_Factura)
                {
                    ApplicationArea = All;
                    Caption = 'No_Factura';
                    ToolTip = 'Especifica el No_Factura';
                }
                field(No_Factura_tbai; Rec.No_Factura_tbai)
                {
                    ApplicationArea = All;
                    Caption = 'No_Factura_tbai';
                    ToolTip = 'Especifica wl No_Factura_tbai';
                }
                field(R_Codigo; Rec.R_Codigo)
                {
                    ApplicationArea = All;
                    Caption = 'R_Codigo';
                    ToolTip = 'Especifica el R_Codigo';
                }
                field(R_Descripcion; Rec.R_Descripcion)
                {
                    ApplicationArea = All;
                    Caption = 'R_Descripcion';
                    ToolTip = 'Especifica R_Descripcion';
                }
                field(R_Descripcion_detallada; Rec.R_Descripcion_detallada)
                {
                    ApplicationArea = All;
                    Caption = 'R_Descripcion_detallada';
                    ToolTip = 'Especifica';
                }
                field(R_FechaRecepcion; Rec.R_FechaRecepcion)
                {
                    ApplicationArea = All;
                    Caption = 'R_FechaRecepcion';
                    ToolTip = 'Especifica R_FechaRecepcion';
                }
                field(R_Identificador_TBAI; Rec.R_Identificador_TBAI)
                {
                    ApplicationArea = All;
                    Caption = 'R_Identificador_TBAI';
                    ToolTip = 'Especifica R_Identificador_TBAI';
                }
                field(R_Estado; Rec.R_Estado)
                {
                    ApplicationArea = All;
                    Caption = 'R_Estado';
                    ToolTip = 'Especifica R_Estado';
                }
                field(R_SignatureValue; Rec.R_SignatureValue)
                {
                    ApplicationArea = All;
                    Caption = 'R_SignatureValue';
                    ToolTip = 'Especifica R_SignatureValue';
                }
                field(QR_CodeString; Rec.QR_CodeString)
                {
                    ApplicationArea = All;
                    Caption = 'QR_CodeString';
                    ToolTip = 'Especifica QR_CodeString';
                }
                field(PreviousDocNo; Rec.PreviousDocNo)
                {
                    ApplicationArea = All;
                    Caption = 'PreviousDocNo';
                    ToolTip = 'Especifica PreviousDocNo';
                }
                field(R_DocNoTBAI; Rec.R_DocNoTBAI)
                {
                    ApplicationArea = All;
                    Caption = 'R_DocNoTBAI';
                    ToolTip = 'Especifica R_DocNoTBAI';
                }
                field(R_DocNoNAV; Rec.R_DocNoNAV)
                {
                    ApplicationArea = All;
                    Caption = 'R_DocNoNAV';
                    ToolTip = 'Especifica R_DocNoNAV';
                }
                field(SignedXMLDocname; Rec.SignedXMLDocname)
                {
                    ApplicationArea = All;
                    Caption = 'SignedXMLDocname';
                    ToolTip = 'Especifica SignedXMLDocname';
                }
                field(NavXMLDocName; Rec.NavXMLDocName)
                {
                    ApplicationArea = All;
                    Caption = 'NavXMLDocName';
                    ToolTip = 'Especifica NavXMLDocName';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(TipoRegistro, Rec.TipoRegistro::Respuesta);
    end;
}