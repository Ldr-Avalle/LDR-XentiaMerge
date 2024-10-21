xmlport 50000 "Factura TBAI"
{
    Encoding = UTF8;

    schema
    {
        textelement(ticketbai)
        {
            XmlName = 'TicketBai';
            textelement(Cabecera)
            {
                textelement(IDVersionTBAI)
                {
                    trigger OnBeforePassVariable()
                    begin
                        IDVersionTBAI := TBAIAlava.C_IDVersionTBAI;
                    end;
                }
            }
            textelement(Sujetos)
            {
                textelement(Emisor)
                {
                    textelement(NIF)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            NIF := CompanyInformation."VAT Registration No.";
                        end;
                    }
                    textelement(ApellidosNombreRazonSocial)
                    {
                        trigger OnBeforePassVariable()
                        begin
                            ApellidosNombreRazonSocial := CompanyInformation.Name;
                        end;
                    }

                    trigger OnBeforePassVariable()
                    begin
                    end;
                }
                textelement(Destinatarios)
                {
                    textelement(IDDestinatario)
                    {
                        textelement(nifdest)
                        {
                            MinOccurs = Zero;
                            XmlName = 'NIF';

                            trigger OnBeforePassVariable()
                            begin
                                if salesinvheader."Factura Simplificada" = salesinvheader."Factura Simplificada"::S then currXMLport.Skip();

                                if Customer."Country/Region Code" = 'ES' then
                                    nifdest := salesinvheader."VAT Registration No.";
                            end;
                        }
                        textelement(IDOTRO)
                        {
                            MinOccurs = Zero;
                            textelement(codigopais)
                            {
                                MinOccurs = Zero;
                                XmlName = 'CodigoPais';

                                trigger OnBeforePassVariable()
                                begin
                                    if Customer."Country/Region Code" <> 'ES' then
                                        codigopais := Customer."Country/Region Code";
                                end;
                            }
                            textelement(idtype)
                            {
                                MinOccurs = Zero;
                                XmlName = 'IDType';

                                trigger OnBeforePassVariable()
                                begin
                                    if Customer."Country/Region Code" <> 'ES' then
                                        idtype := Format(Customer.IDType);
                                end;
                            }
                            textelement(id)
                            {
                                MinOccurs = Zero;
                                XmlName = 'ID';

                                trigger OnBeforePassVariable()
                                begin
                                    if Customer."Country/Region Code" <> 'ES' then
                                        id := Format(Customer.ID_LDR);
                                end;
                            }

                            trigger OnBeforePassVariable()
                            begin
                                if Customer."Country/Region Code" = 'ES' then
                                    currXMLport.Skip();
                            end;
                        }
                        textelement(apellidosnombrerazonsocial2)
                        {
                            XmlName = 'ApellidosNombreRazonSocial';

                            trigger OnBeforePassVariable()
                            begin
                                if salesinvheader."Factura Simplificada" = salesinvheader."Factura Simplificada"::S then currXMLport.Skip();
                                apellidosnombrerazonsocial2 := Customer.Name;
                            end;
                        }
                        textelement(CodigoPostal)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                if salesinvheader."Factura Simplificada" = salesinvheader."Factura Simplificada"::S then currXMLport.Skip();
                                CodigoPostal := Customer."Post Code";
                            end;
                        }
                        textelement(Direccion)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                if salesinvheader."Factura Simplificada" = salesinvheader."Factura Simplificada"::S then currXMLport.Skip();
                                Direccion := Customer.Address;
                            end;
                        }
                    }

                    trigger OnBeforePassVariable()
                    begin
                        if salesinvheader."Factura Simplificada" = salesinvheader."Factura Simplificada"::S then currXMLport.Skip();
                    end;
                }
                textelement(VariosDestinatarios)
                {

                    trigger OnBeforePassVariable()
                    begin
                        VariosDestinatarios := CopyStr(Format(salesinvheader."varios destinatarios"), 1, 1);
                    end;
                }
                textelement(EmitidaPorTercerosODestinatario)
                {

                    trigger OnBeforePassVariable()
                    begin
                        EmitidaPorTercerosODestinatario := CopyStr(Format(salesinvheader."Factura 3 o dest"), 1, 1);
                    end;
                }
            }
            textelement(Factura)
            {
                tableelement(salesinvheader; "Sales Invoice Header")
                {
                    MinOccurs = Once;
                    XmlName = 'CabeceraFactura';
                    SourceTableView = sorting("No.");
                    textelement(SerieFactura)
                    {
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            SerieFactura := Format(TBAIAlava.C_NoSeriesTBAI);
                        end;
                    }
                    textelement(numfactura)
                    {
                        XmlName = 'NumFactura';

                        trigger OnBeforePassVariable()
                        begin
                            numfactura := Format(salesinvheader.DocNoTBAI);
                        end;
                    }
                    textelement(fechaexpedicionfactura)
                    {
                        XmlName = 'FechaExpedicionFactura';

                        trigger OnBeforePassVariable()
                        begin
                            fechaexpedicionfactura := FormatDate(salesinvheader."Posting Date");
                        end;
                    }
                    textelement(horaexpedicionfactura)
                    {
                        XmlName = 'HoraExpedicionFactura';

                        trigger OnBeforePassVariable()
                        begin
                            if salesinvheader."Posting Hour" <> 0T then
                                horaexpedicionfactura := FormatHour(salesinvheader."Posting Hour")
                            else
                                horaexpedicionfactura := FormatHour(Time);
                        end;
                    }
                    textelement(facturasimplificada)
                    {
                        MinOccurs = Zero;
                        XmlName = 'FacturaSimplificada';

                        trigger OnBeforePassVariable()
                        begin
                            facturasimplificada := CopyStr(Format(salesinvheader."Factura Simplificada"), 1, 1);
                        end;
                    }
                    textelement(facesustitucionsimplificada)
                    {
                        MinOccurs = Zero;
                        XmlName = 'FacturaEmitidaSustitucionSimplificada';

                        trigger OnBeforePassVariable()
                        begin
                            facesustitucionsimplificada := CopyStr(Format(salesinvheader."Factura Simplificada Sustituci"), 1, 1);
                        end;
                    }
                    textelement(facturarectificativa)
                    {
                        MinOccurs = Zero;
                        XmlName = 'FacturaRectificativa';
                        textelement(codigo)
                        {
                            XmlName = 'Codigo';

                            trigger OnBeforePassVariable()
                            begin
                                codigo := Format(salesinvheader."factura rectificativa");
                            end;
                        }
                        textelement(tipo)
                        {
                            XmlName = 'Tipo';

                            trigger OnBeforePassVariable()
                            begin
                                tipo := Format(salesinvheader."factura rectificativa tipo");
                            end;
                        }
                        textelement(importerectsustitutiva)
                        {
                            MinOccurs = Zero;
                            XmlName = 'ImporteRectificacionSustitutiva';
                            textelement(baserectificada)
                            {
                                XmlName = 'BaseRectificada';

                                trigger OnBeforePassVariable()
                                begin
                                    baserectificada := SetDecimalPlaces(salesinvheader.BaseRectificada, 2);
                                end;
                            }
                            textelement(cuotarectificada)
                            {
                                XmlName = 'CuotaRectificada';

                                trigger OnBeforePassVariable()
                                begin
                                    baserectificada := SetDecimalPlaces(salesinvheader.CuotaRectificada, 2);
                                end;
                            }
                            textelement(cuotarecargorectificada)
                            {
                                MinOccurs = Zero;
                                XmlName = 'CuotaRecargoRectificada';

                                trigger OnBeforePassVariable()
                                begin
                                    baserectificada := SetDecimalPlaces(salesinvheader.CuotaRecargoRectificada, 2);
                                end;
                            }

                            trigger OnAfterAssignVariable()
                            begin
                            end;
                        }

                        trigger OnBeforePassVariable()
                        begin
                            if GetFacturaRectificativa() = false then currXMLport.Skip();
                        end;
                    }
                    textelement(factrectificadassustituidas)
                    {
                        MinOccurs = Zero;
                        XmlName = 'FacturasRectificadasSustituidas';
                        textelement(idfacrectificadasustituida1)
                        {
                            MinOccurs = Zero;
                            XmlName = 'IDFacturaRectificadaSustituida';
                            textelement(seriefactura1)
                            {
                                MinOccurs = Zero;
                                XmlName = 'SerieFactura';
                            }
                            textelement(numfactura1)
                            {
                                XmlName = 'NumFactura';
                            }
                            textelement(fechaexpedicionfactura1)
                            {
                                XmlName = 'FechaExpedicionFactura';
                            }
                        }

                        trigger OnBeforePassVariable()
                        begin
                            if GetFacturasRectificadasSustituidas() = false then currXMLport.Skip();
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        salesinvheader.CalcFields(Amount, "Amount Including VAT", "Descuento en factura", "Descuento en factura %", "Pmt. Disc. Given Amount")
                    end;

                    trigger OnPreXmlItem()
                    begin
                        salesinvheader.SetRange("No.", gblNoDoc);
                    end;
                }
                textelement(DatosFactura)
                {
                    textelement(DescripcionFactura)
                    {

                        trigger OnBeforePassVariable()
                        begin

                            DescripcionFactura := 'Factura Navision ' + salesinvheader."No.";
                        end;
                    }
                    textelement(DetallesFactura)
                    {
                        tableelement(salesinvline; "Sales Invoice Line")
                        {
                            LinkFields = "Document No." = field("No.");
                            LinkTable = salesinvheader;
                            XmlName = 'IDDetalleFactura';
                            textelement(descripciondetalle)
                            {
                                XmlName = 'DescripcionDetalle';

                                trigger OnBeforePassVariable()
                                begin
                                    descripciondetalle := Format(salesinvline.Description);
                                end;
                            }
                            textelement(cantidad)
                            {
                                XmlName = 'Cantidad';

                                trigger OnBeforePassVariable()
                                begin
                                    cantidad := SetDecimalPlaces(salesinvline.Quantity, 8);
                                end;
                            }
                            textelement(importeunitario)
                            {
                                XmlName = 'ImporteUnitario';

                                trigger OnBeforePassVariable()
                                begin
                                    importeunitario := SetDecimalPlaces(salesinvline.Amount, 8);
                                end;
                            }
                            textelement(descuento)
                            {
                                MinOccurs = Zero;
                                XmlName = 'Descuento';

                                trigger OnBeforePassVariable()
                                begin
                                    if salesinvline."Line Discount Amount" = 0 then
                                        currXMLport.Skip();
                                    currXMLport.Skip();
                                end;
                            }
                            textelement(importetotal)
                            {
                                XmlName = 'ImporteTotal';

                                trigger OnBeforePassVariable()
                                begin
                                    importetotal := SetDecimalPlaces(salesinvline."Amount Including VAT", 8);
                                end;
                            }
                        }
                    }
                    textelement(ImporteTotalFactura)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            ImporteTotalFactura := SetDecimalPlaces(salesinvheader."Amount Including VAT", 2);
                        end;
                    }
                    textelement(Claves)
                    {
                        textelement(IDClave)
                        {
                            textelement(ClaveRegimenIvaOpTrascendencia)
                            {
                                trigger OnBeforePassVariable()
                                begin
                                    ClaveRegimenIvaOpTrascendencia := CopyStr(Format(salesinvheader.ClaveRegimenIvaOpTrascendencia), 1, 2);
                                end;
                            }
                        }
                    }
                }
                textelement(TipoDesglose)
                {
                    textelement(DesgloseFactura)
                    {
                        textelement(Sujeta)
                        {
                            textelement(NoExenta)
                            {
                                textelement(DetalleNoExenta)
                                {
                                    textelement(tiponoexenta)
                                    {
                                        XmlName = 'TipoNoExenta';

                                        trigger OnBeforePassVariable()
                                        begin
                                            tiponoexenta := CopyStr(Format(salesinvline.TipoNoExenta), 1, 2);
                                        end;
                                    }
                                    textelement(DesgloseIVA)
                                    {
                                        textelement(DetalleIVA)
                                        {
                                            textelement(baseimponible)
                                            {
                                                XmlName = 'BaseImponible';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    baseimponible := SetDecimalPlaces(salesinvheader.Amount, 2);
                                                end;
                                            }
                                            textelement(tipoimpositivo)
                                            {
                                                XmlName = 'TipoImpositivo';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    tipoimpositivo := SetDecimalPlaces(21, 0);
                                                end;
                                            }
                                            textelement(cuotaimpuesto)
                                            {
                                                XmlName = 'CuotaImpuesto';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    cuotaimpuesto := SetDecimalPlaces(salesinvheader.Amount * ((21) / 100), 2);
                                                end;
                                            }
                                            textelement(openrecdequivaloregisimpl)
                                            {
                                                MinOccurs = Zero;
                                                XmlName = 'OperacionEnRecargoDeEquivalenciaORegimenSimplificado';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    currXMLport.Skip();
                                                end;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            textelement(HuellaTBAI)
            {
                textelement(EncadenamientoFacturaAnterior)
                {
                    MinOccurs = Zero;
                    textelement(SerieFacturaAnterior)
                    {
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            SerieFacturaAnterior := SerieFacturaAnterior_;
                        end;
                    }
                    textelement(NumFacturaAnterior)
                    {
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            NumFacturaAnterior := NumFacturaAnterior_;
                        end;
                    }
                    textelement(FechaExpedicionFacturaAnterior)
                    {
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            FechaExpedicionFacturaAnterior := Format(FechaExpedicionFacturaAnterior_);
                        end;
                    }
                    textelement(SignatureValueFirmaFacturaAnterior)
                    {
                        MinOccurs = Zero;

                        trigger OnBeforePassVariable()
                        begin
                            SignatureValueFirmaFacturaAnterior := SignatureValueFirmaFacturaAnterior_;
                        end;
                    }

                    trigger OnBeforePassVariable()
                    begin
                        if GetEncadenamientoFacturaAnterior() = false then currXMLport.Skip();
                    end;
                }
                textelement(Software)
                {
                    textelement(licenciatbai)
                    {
                        XmlName = 'LicenciaTBAI';

                        trigger OnBeforePassVariable()
                        begin
                            licenciatbai := TBAIAlava.C_LicenciaTBAI;
                        end;
                    }
                    textelement(entidaddesarrolladora)
                    {
                        XmlName = 'EntidadDesarrolladora';
                        textelement(nifdeventity)
                        {
                            XmlName = 'NIF';

                            trigger OnBeforePassVariable()
                            begin
                                nifdeventity := TBAIAlava.C_NIF;
                            end;
                        }
                    }
                    textelement(nombre)
                    {
                        XmlName = 'Nombre';

                        trigger OnBeforePassVariable()
                        begin
                            nombre := TBAIAlava.C_Nombre;
                        end;
                    }
                    textelement(version)
                    {
                        XmlName = 'Version';

                        trigger OnBeforePassVariable()
                        begin
                            version := TBAIAlava.C_Version;
                        end;
                    }
                }
            }
        }
    }

    var
        CompanyCountryReg: Record "Country/Region";
        CustomerCountryReg: Record "Country/Region";
        CustomerLanguage: Record Language;
        VatBusPostGroup: Record "VAT Business Posting Group";
        TBAIAlava: Record "TBAI Alava2_LDR";
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        SalesInvoiceHeader2: Record "Sales Invoice Header";
        "fe:Facturae2": Text[250];
        fe: Text[250];
        "xmlns:fe": Text[250];
        "xmlns:ds": Text[250];
        Coments: Text[250];
        DefxmlnsT2: Text[50];
        DefxmlnsXsi2: Text[50];
        DefXsischemaLocation2: Text[1];
        DefModality: Text[5];
        DefInvoiceIssuerType: Text[5];
        DefInvoicesCount: Text[5];
        DefInvoiceCurrencyCode: Text[10];
        DefResidendeTypeCode: Text[5];
        DefInvoiceDocumentType: Text[5];
        DefTaxTypeCode: Text[5];
        DefTaxRate: array[3] of Text[10];
        DefTaxRateFilter: array[3] of Decimal;
        DefDiscountReason: Text[20];
        DefDiscountRate: Text[10];
        DefDiscountAmount: Text[10];
        DefTotalGeneralSurcharges: Text[10];
        DefTotalTaxesWithheld: Text[10];
        DefLineDiscountReason: Text[30];
        DefUnitOfMeasure: Text[5];
        DefCustomerType: Text[30];
        Def6Dec32: Text[30];
        EmitidaPorTercerosODestinatarios_: Code[1];
        FacturaEmitidaSustitucionSimplificada_: Code[1];
        FacturaSimplificada_: Code[1];
        gblNoDoc: Code[35];
        "--tbai- Encadenamiento anterior": Integer;
        SerieFacturaAnterior_: Text;
        NumFacturaAnterior_: Code[20];
        FechaExpedicionFacturaAnterior_: Text;
        SignatureValueFirmaFacturaAnterior_: Text;
        ErroEncademientoAnterior: Label 'Error en encadenamiento anterior: Campo "%1" valor "%2"';

    procedure SetDecimalPlaces(num: Decimal; numDec: Integer) textResult: Text[30]
    var
        startDec: Integer;
    begin
        if numDec > 8 then Error('La función no admite míos de 8 decimales');
        case (numDec) of
            0:
                textResult := Format(Round(num, 1));
            1:
                textResult := Format(Round(num, 0.1));
            2:
                textResult := Format(Round(num, 0.01));
            3:
                textResult := Format(Round(num, 0.001));
            4:
                textResult := Format(Round(num, 0.0001));
            5:
                textResult := Format(Round(num, 0.00001));
            6:
                textResult := Format(Round(num, 0.000001));
            7:
                textResult := Format(Round(num, 0.0000001));
            8:
                textResult := Format(Round(num, 0.00000001));
        end;

        textResult := DelChr(textResult, '=', '.');
        textResult := ConvertStr(textResult, ',', '.');

        startDec := StrPos(textResult, '.');
        if startDec = 0 then
            textResult += '.';

        while (StrLen(textResult) <> (StrPos(textResult, '.') + numDec)) do
            textResult += '0';
        if numDec = 0 then
            textResult := DelChr(textResult, '=', '.');
        exit(textResult);
    end;

    procedure FormatDate(date: Date) result: Text[30]
    var
        D: Text[30];
        M: Text[30];
    begin
        D := Format(Date2DMY(date, 1));
        M := Format(Date2DMY(date, 2));

        if StrLen(D) = 1 then D := '0' + D;
        if StrLen(M) = 1 then M := '0' + M;

        exit(D + '-' + M + '-' + Format(Date2DMY(date, 3)));
    end;

    procedure FormatHour(time_: Time) result: Text[30]
    var
        hourTxt: Text[30];
        HourInt: Integer;
    begin
        hourTxt := CopyStr(Format(time_), 1, StrPos(Format(time_), ':') - 1);
        Evaluate(HourInt, hourTxt);
        if StrLen(Format(HourInt)) = 1 then
            exit('0' + CopyStr(Format(time_), 2))
        else
            exit(Format(time_));
    end;

    procedure GetInvLinesVatAmount(PercentTax: Decimal) VatAmount: Text[20]
    begin
    end;

    procedure GetInvLinesGrossAmount() GrossAmount: Text[20]
    begin
    end;

    procedure GetInvLinesAmount(PercentTax: Decimal) Amount: Text[30]
    begin
    end;

    procedure FiltrarNumDocument(NoDoc: Code[35])
    begin
        gblNoDoc := NoDoc;

        TBAIAlava.SetRange(TipoRegistro, TBAIAlava.TipoRegistro::Configuración);
        if TBAIAlava.FindSet(true, true) then;
        salesinvheader.SetRange("No.", gblNoDoc);
        salesinvheader.FindSet(true, true);
        Customer.Get(salesinvheader."VAT Registration No.");
        if salesinvheader."Factura Simplificada" = salesinvheader."Factura Simplificada"::N then begin
            Customer.TestField("Post Code");
            Customer.TestField(Address);
        end;
        Customer.TestField(Name);
        salesinvheader.TestField("No. SeriesTBAI");
        salesinvheader.TestField(DocNoTBAI);
        CompanyInformation.Get();
        CompanyInformation.TestField("VAT Registration No.");
        CompanyInformation.TestField(Name);
    end;

    local procedure GetEncadenamientoFacturaAnterior(): Boolean
    var
        TBAIAlavaInvoice: Record "TBAI Alava2_LDR";
    begin
        Clear(TBAIAlavaInvoice);
        TBAIAlavaInvoice.Reset();
        SelectLatestVersion();
        TBAIAlavaInvoice.SetRange(TipoRegistro, TBAIAlavaInvoice.TipoRegistro::Envío);
        TBAIAlavaInvoice.SetRange(Correcto, true);
        TBAIAlavaInvoice.SetCurrentKey(ID);
        TBAIAlavaInvoice.SetAscending(ID, false);
        if TBAIAlavaInvoice.FindSet() then begin
            SerieFacturaAnterior_ := TBAIAlava.C_NoSeriesTBAI;
            if SerieFacturaAnterior_ = '' then
                Error(StrSubstNo(ErroEncademientoAnterior, TBAIAlavaInvoice.FieldCaption(C_NoSeriesTBAI), TBAIAlavaInvoice.C_NoSeriesTBAI));
            NumFacturaAnterior_ := TBAIAlavaInvoice.No_Factura_tbai;
            if NumFacturaAnterior_ = '' then
                Error(StrSubstNo(ErroEncademientoAnterior, TBAIAlavaInvoice.FieldCaption(No_Factura_tbai), TBAIAlavaInvoice.No_Factura_tbai));
            FechaExpedicionFacturaAnterior_ := FormatDate(GetFechaExpedicionFacturaAnterior(TBAIAlavaInvoice.No_Factura));
            if FechaExpedicionFacturaAnterior_ = '0D' then
                Error(StrSubstNo(ErroEncademientoAnterior, salesinvheader.FieldCaption("Posting Date"), FechaExpedicionFacturaAnterior_));
            SignatureValueFirmaFacturaAnterior_ := TBAIAlavaInvoice.R_SignatureValue;
            if SignatureValueFirmaFacturaAnterior_ = '' then
                Error(StrSubstNo(ErroEncademientoAnterior, TBAIAlavaInvoice.FieldCaption(R_SignatureValue), TBAIAlavaInvoice.R_SignatureValue));
            exit(true)
        end else
            exit(false);
    end;

    local procedure GetFacturaRectificativa(): Boolean
    begin
        exit(false);
    end;

    local procedure GetFacturasRectificadasSustituidas(): Boolean
    begin
        exit(false);
    end;

    local procedure GetFechaExpedicionFacturaAnterior(DocNo: Code[20]): Date
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin

        SalesInvoiceHeader.SetRange("No.", DocNo);
        if SalesInvoiceHeader.FindSet(true, true) then
            exit(SalesInvoiceHeader."Posting Date")
        else
            exit(0D);
    end;
}