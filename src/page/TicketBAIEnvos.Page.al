page 50032 "Ticket BAI Envíos"
{
    ApplicationArea = All;
    Caption = 'Ticket BAI Envíos';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
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
                    ToolTip = 'Especifica el No_Factura_tbai';
                }
                field(R_Codigo; Rec.R_Codigo)
                {
                    ApplicationArea = All;
                    Caption = 'R_Codigo';
                    ToolTip = 'Especifica  el R_Codigo';
                }
                field(R_Descripcion; Rec.R_Descripcion)
                {
                    ApplicationArea = All;
                    Caption = 'R_Descripcion';
                    ToolTip = 'Especifica la R_Descripcion';
                }
                field(R_Descripcion_detallada; Rec.R_Descripcion_detallada)
                {
                    ApplicationArea = All;
                    Caption = 'R_Descripcion_detallada';
                    ToolTip = 'Especifica la R_Descripcion_detallada';
                }
                field(R_FechaRecepcion; Rec.R_FechaRecepcion)
                {
                    ApplicationArea = All;
                    Caption = 'R_FechaRecepcion';
                    ToolTip = 'Especifica la R_FechaRecepcion';
                }
                field(R_Identificador_TBAI; Rec.R_Identificador_TBAI)
                {
                    ApplicationArea = All;
                    Caption = 'R_Identificador_TBAI';
                    ToolTip = 'Especifica el R_Identificador_TBAI';
                }
                field(R_Estado; Rec.R_Estado)
                {
                    ApplicationArea = All;
                    Caption = 'R_Estado';
                    ToolTip = 'Especifica el R_Estado';
                }
                field(R_SignatureValue; Rec.R_SignatureValue)
                {
                    ApplicationArea = All;
                    Caption = 'R_SignatureValue';
                    ToolTip = 'Especifica el R_SignatureValue';
                }
                field(QR_CodeString; Rec.QR_CodeString)
                {
                    ApplicationArea = All;
                    Caption = 'QR_CodeString';
                    ToolTip = 'Especifica el QR_CodeString';
                }
                field(PreviousDocNo; Rec.PreviousDocNo)
                {
                    ApplicationArea = All;
                    Caption = 'PreviousDocNo';
                    ToolTip = 'Especifica';
                }
                field(R_DocNoTBAI; Rec.R_DocNoTBAI)
                {
                    ApplicationArea = All;
                    Caption = 'R_DocNoTBAI';
                    ToolTip = 'Especifica';
                }
                field(R_DocNoNAV; Rec.R_DocNoNAV)
                {
                    ApplicationArea = All;
                    Caption = 'R_DocNoNAV';
                    ToolTip = 'Especifica';
                }
                field(SignedXMLDocname; Rec.SignedXMLDocname)
                {
                    ApplicationArea = All;
                    Caption = 'SignedXMLDocname';
                    ToolTip = 'Especifica';
                }
                field(NavXMLDocName; Rec.NavXMLDocName)
                {
                    ApplicationArea = All;
                    Caption = 'NavXMLDocName';
                    ToolTip = 'Especifica';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(TipoRegistro, Rec.TipoRegistro::Envío);
    end;
}