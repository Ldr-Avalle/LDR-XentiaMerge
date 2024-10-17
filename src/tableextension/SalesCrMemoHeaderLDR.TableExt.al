tableextension 50043 "SalesCrMemoHeader_LDR" extends "Sales Cr.Memo Header"
{
    DataCaptionFields = "Customer type";

    fields
    {
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Grupo contable negocio';
        }
        modify("Area")
        {
            Caption = 'Cód. provincia';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Grupo registro IVA neg.';
        }
        field(50000; "Descuento en factura"; Decimal)
        {
            CalcFormula = sum("Sales Cr.Memo Line"."Inv. Discount Amount" where("Document No." = field("No.")));
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
        field(50001; "Descuento en factura %"; Decimal)
        {
            CalcFormula = lookup("Cust. Invoice Disc."."Discount %" where(Code = field("Bill-to Customer No.")));
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
        field(50002; "Pmt. Disc. Given Amount"; Decimal)
        {
            CalcFormula = sum("Sales Cr.Memo Line"."Pmt. Discount Amount" where("Document No." = field("No.")));
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
        field(50004; InvoiceType; Option)
        {
            Caption = 'Tipo de factura';
            Description = 'SERCABLE';
            OptionMembers = "OR",CR;
        }
        field(50005; "Correction Method"; Option)
        {
            Description = 'SERCABLE';
            OptionMembers = "01","02","03","04";
        }
        field(50006; "Correction Method Description"; Option)
        {
            Description = 'SERCABLE';
            OptionMembers = "Rectificación íntegra","  Rectificación por diferencias ","  Rectificación por descuento por volumen de operaciones durante el periodo "," 04 Autorizadas por la Agencia Tributaria ";
        }
        field(50007; "Reason Description"; Text[100])
        {
            CalcFormula = lookup("Reason Code".Description where(Code = field("Reason Code")));
            Description = 'SERCABLE';
            FieldClass = FlowField;
        }
        field(50008; "Customer type"; Option)
        {
            Description = 'SERCABLE';
            OptionMembers = " ","Física","Jurídica";
        }
        field(50019; DocNoTBAI; Code[20])
        {
            Caption = 'No. Documento TBAI';
            Description = 'TBAI_AL_01 No. Documento TBAI';
            Editable = false;
        }
        field(50020; "No. SeriesTBAI"; Code[10])
        {
            CalcFormula = lookup("Sales Invoice Header"."No. SeriesTBAI" where(DocNoTBAI = field(DocNoTBAI))); //TODO:Quitar tmp de Sales Invoice Header
            Caption = 'No. Series TBAI';
            Description = 'TBAI_AL_01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50021; TBAIQRBlob; Blob)
        {
            Description = 'TBAI_AL_01 QRBLOB';
        }
        field(50022; R_Identificador_TBAI; Text[100])
        {
            CalcFormula = lookup("Sales Invoice Header".R_Identificador_TBAI where(DocNoTBAI = field(DocNoTBAI)));
            Caption = 'Identificador TBAI';
            Description = 'TBAI_AL_01 identificador tbai';
            FieldClass = FlowField;
        }
        field(50023; TBAI_Sended; Boolean)
        {
            Caption = 'Enviada a TBAI';
            Description = 'TBAI_AL_01 identificador tbai';
        }
        field(50024; TipoRegistro; Option)
        {
            Caption = 'Tipo Registro TBAI';
            Description = 'TBAI_AL_01';
            Editable = false;
            OptionCaption = ' ,Envío, Anulación';
            OptionMembers = " ","Envío","Anulación";
        }
        field(50025; QR_CodeString; Text[200])
        {
            CalcFormula = lookup("Sales Invoice Header".QR_CodeString where(DocNoTBAI = field(DocNoTBAI)));
            Description = 'TBAI_AL_01';
            FieldClass = FlowField;
        }
        field(50099; FacturaFin; Code[20])
        {
        }
        field(50100; SendToTicketBAI; Boolean)
        {
            Caption = 'Enviar Factura a Ticket BAI';
            Description = 'TBAI_AL_01';
        }
        field(50101; "Posting Hour"; Time)
        {
            Description = 'TBAI_AL_01';
        }
    }

    trigger OnAfterInsert()
    begin
        rec."Posting Hour" := Time;
    end;

    /*
    procedure SendRecords()
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        TempDocumentSendingProfile: Record "Document Sending Profile" temporary;
        ReportDistributionManagement: Codeunit "Report Distribution Management";
    begin
        DocumentSendingProfile.GetDefaultForCustomer("Bill-to Customer No.", DocumentSendingProfile);
        Commit();
        TempDocumentSendingProfile.Init();
        TempDocumentSendingProfile.Code := DocumentSendingProfile.Code;
        TempDocumentSendingProfile.VALIDATE("One Related Party Selected", IsSingleCustomerSelected);
        TempDocumentSendingProfile.SetDocumentUsage(Rec);
        TempDocumentSendingProfile.Insert();
        if Page.RunModal(Page::"Select Sending Options", TempDocumentSendingProfile) = Action::LookupOK then
            ReportDistributionManagement.SendDocumentReport(TempDocumentSendingProfile, Rec); //TODO:Añadir Procedure
    end;

    procedure PrintRecords(ShowRequestForm: Boolean)
    var
        TempDocumentSendingProfile: Record "Document Sending Profile" temporary;
        ReportDistributionManagement: Codeunit "Report Distribution Management";
    begin
        TempDocumentSendingProfile.Init();
        if ShowRequestForm then
            TempDocumentSendingProfile.Printer := TempDocumentSendingProfile.Printer::"Yes (Prompt for Settings)"
        else
            TempDocumentSendingProfile.Printer := TempDocumentSendingProfile.Printer::"Yes (Use Default Settings)";
        TempDocumentSendingProfile.Insert();
        ReportDistributionManagement.SendDocumentReport(TempDocumentSendingProfile, Rec);
    end;

    procedure EmailRecords(ShowRequestForm: Boolean)
    var
        TempDocumentSendingProfile: Record "Document Sending Profile" temporary;
        ReportDistributionManagement: Codeunit "Report Distribution Management";
    begin
        TempDocumentSendingProfile.Init();
        if ShowRequestForm then
            TempDocumentSendingProfile."E-Mail" := TempDocumentSendingProfile."E-Mail"::"Yes (Prompt for Settings)"
        else
            TempDocumentSendingProfile."E-Mail" := TempDocumentSendingProfile."E-Mail"::"Yes (Use Default Settings)";
        TempDocumentSendingProfile."E-Mail Attachment" := TempDocumentSendingProfile."E-Mail Attachment"::PDF;
        TempDocumentSendingProfile.Insert();
        ReportDistributionManagement.SendDocumentReport(TempDocumentSendingProfile, Rec);
    end;

    procedure CreateFacturae(Sign: Boolean; Send: Boolean)
    var
        ExportFile: File;
        OStream: OutStream;
        InvoicePath: Text[200];
        SignedInvPath: Text[200];
        CompanyInfo: Record "Company Information";
        err: Integer;
        Mail: Codeunit Mail;
        Customer: Record Customer;
        SignedInvName: Text[200];
        Text0001: Label 'Invoice %1 already signed. Path: %2';
        Text0002: Label 'Invoice %1 has not an original invoice signed.';
        Text0003: Label 'An error has ocurred.\Ask your administrator (Shell %1)';
        Text0004: Label 'Facturae not allowed for customer %1';
        Text0005: Label 'An error has ocurred.\Ask your administrator (Shell %1)';
    begin
        CompanyInfo.Get();
        SetFilter("No.", '%1', "No.");
        Customer.Get("Bill-to Customer No.");
        CompanyInfo.TestField("XML Files path");
        InvoiceNo := DelChr("No.", '=', '/');
        InvoicePath := CompanyInfo."XML Files path" + InvoiceNo + '.xml';
        if Customer."Facturae Type" = Customer."Facturae Type"::fe31 then begin
            ExportFile.CREATE(InvoicePath);
            ExportFile.CREATEOUTSTREAM(OStream);
            Xmlport.Export(50060, OStream, Rec);
            ExportFile.CLOSE
        end else if Customer."Facturae Type" = Customer."Facturae Type"::fe32 then begin
            ExportFile.CREATE(InvoicePath);
            ExportFile.CREATEOUTSTREAM(OStream);
            Xmlport.Export(50020, OStream, Rec);
            ExportFile.CLOSE;
        end;
        err := SHELL(CompanyInfo."Facturae Chipbip path", '"' + CompanyInfo."Digital Cert. Name" + '"',
                   InvoicePath, InvoicePath, Format(Customer."Facturae Type"), 'nosign');
        if err <> 0 then Error(Text0005, err);
        if Sign then begin
            if not Customer."Facturae allowed" then Error(Text0004, Customer."No." + ' ' + Customer.Name);
            CompanyInfo.TestField("OO Files Path");
            CompanyInfo.TestField("CO Files Path");
            CompanyInfo.TestField("Facturae Chipbip path");
            CompanyInfo.TestField("Digital Cert. Name");
            if InvoiceType in [InvoiceType::CR] then
                SignedInvPath := CompanyInfo."OO Files Path" + InvoiceNo + 'Copy.xml'
            else
                SignedInvPath := CompanyInfo."CO Files Path" + InvoiceNo + 'Signed.xml';
            if File.EXISTS(SignedInvPath) = false then begin
                err := SHELL(CompanyInfo."Facturae Chipbip path", '"' + CompanyInfo."Digital Cert. Name" + '"',
                       InvoicePath, SignedInvPath, Format(Customer."Facturae Type"), 'sign');
                if err <> 0 then Error(Text0003, err);
            end;
            if CompanyInfo."Delete XML file" then File.ERASE(InvoicePath); //TODO:OnPrem
        end;
        if Send then
            if Sign then
                Mail.NewMessage(Customer."E-Mail", '', 'Factura: ' + "No.", 'Documento adjunto ' + "No." + 'Signed.xml', SignedInvPath, '', true)
            else
                Mail.NewMessage(Customer."E-Mail", '', 'Factura: ' + "No.", 'Documento adjunto ' + "No." + '.xml', InvoicePath, '', true);
    end;

    var
        CompanyInfo: Record "Company Information";
        Customer: Record Customer;
        PostSalesLinesDelete: Codeunit "PostSales-Delete";
        InvoiceNo: Text[30];
    */
}