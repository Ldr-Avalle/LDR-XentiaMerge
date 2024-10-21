report 50098 RetenAlquilerProfesi
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/RetenAlquilerProfesi.rdl';
    Caption = 'Retenciones de alquileres y profesionales';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = WHERE("Document Type" = FILTER(Invoice | "Credit Memo"),
                                      "Source Type" = CONST(Vendor),
                                      "Source Code" = CONST(' COMPRAS'));
            RequestFilterFields = "Document Date";
            column(TituloCaption; TituloCaptionLbl)
            {
            }
            column(CuentaCaption; CuentaCaptionLbl)
            {
            }
            column(AcreedorCaption; AcreedorCaptionLbl)
            {
            }
            column(FechaEmisionCaption; FechaEmisionCaptionLbl)
            {
            }
            column(NumDocumentCaption; NumDocumentCaptionLbl)
            {
            }
            column(NumDocExternoCaption; NumDocExternoCaptionLbl)
            {
            }
            column(BaseCaption; BaseCaptionLbl)
            {
            }
            column(ImporteCuotaCaption; ImporteCuotaCaptionLbl)
            {
            }
            column(PaginaCaption; PaginaCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PorcRetencionCaption; PorcRetencionCaptionLbl)
            {
            }
            column(NumCuenta; "G/L Account No.")
            {
            }
            column(NombreCuenta; "G/L Account Name")
            {
            }
            column(CodProcedencia; "Source No.")
            {
            }
            column(FechaEmision; "Document Date")
            {
            }
            column(NombreEmpresa; COMPANYNAME)
            {
            }
            column(NombreProveedors; gblRegProveedor.Name)
            {
            }
            column(PorcentajeIRPF; gblRegProveedor.Retención)
            {
            }
            column(Importe; "G/L Entry".Amount)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
            {
                DataItemLink = "No." = FIELD("Document No."),
                               "Posting Date" = FIELD("Posting Date");
                DataItemTableView = SORTING("No.");
                column(ImporteBaseFactura; BaseFactura)
                {
                }
                column(FechaEmisionFactura; "Purch. Inv. Header"."Document Date")
                {
                }
                column(ImporteCuotaFactura; ImporteCuotaFactura)
                {
                }
                column(ContadorFilasFactura; COUNT)
                {
                }
                column(NumDocumentoFactura; "Purch. Inv. Header"."No.")
                {
                }
                column(NombreProveedorFactura; gblRegProveedor.Name)
                {
                }
                column(NumDocumentoExternoFactura; "Purch. Inv. Header"."Vendor Invoice No.")
                {
                }
                column(RetencionFactura; RetencionFactura)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    BaseFactura := 0;
                    ImporteCuotaFactura := 0;
                    RetencionFactura := 0;

                    LineasFacturaCompra2.RESET;
                    LineasFacturaCompra2.SETRANGE("Document No.", "Purch. Inv. Header"."No.");
                    LineasFacturaCompra2.SETRANGE(LineasFacturaCompra2.Retenible, TRUE);
                    IF LineasFacturaCompra2.FINDSET THEN BEGIN
                        BaseFactura := 0;
                        REPEAT
                            BaseFactura += LineasFacturaCompra2."Line Amount";
                        UNTIL LineasFacturaCompra2.NEXT = 0;
                    END;
                    //IF BaseFactura = 0 THEN CurrReport.SKIP;
                    LineasFacturaCompra.RESET;
                    LineasFacturaCompra.SETRANGE("Document No.", "Purch. Inv. Header"."No.");
                    LineasFacturaCompra.SETRANGE(LineasFacturaCompra.Type, LineasFacturaCompra.Type::"G/L Account");
                    LineasFacturaCompra.SETRANGE("No.", "G/L Entry"."G/L Account No.");
                    IF LineasFacturaCompra.FINDSET THEN BEGIN
                        ImporteCuotaFactura += LineasFacturaCompra."Line Amount";
                        RetencionFactura += LineasFacturaCompra.Quantity;
                    END;
                end;
            }
            dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
            {
                DataItemLink = "No." = FIELD("Document No."),
                               "Posting Date" = FIELD("Posting Date");
                DataItemTableView = SORTING("No.");
                column(ImporteBaseAbono; BaseAbono)
                {
                }
                column(FechaEmisionAbono; "Purch. Cr. Memo Hdr."."Document Date")
                {
                }
                column(ImporteCuotaAbono; ImporteCuotaAbono)
                {
                }
                column(NumDocumentoAbono; "Purch. Cr. Memo Hdr."."No.")
                {
                }
                column(NombreProveedorAbono; gblRegProveedor.Name)
                {
                }
                column(ContadorFilasAbono; COUNT)
                {
                }
                column(NumDocumentoExternoAbono; "G/L Entry"."External Document No.")
                {
                }
                column(RetencionAbono; RetencionAbono)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    BaseAbono := 0;
                    ImporteCuotaAbono := 0;
                    RetencionAbono := 0;

                    LineasAbonoCompra2.RESET;
                    LineasAbonoCompra2.SETRANGE("Document No.", "Purch. Cr. Memo Hdr."."No.");
                    LineasAbonoCompra2.SETRANGE(LineasAbonoCompra2.Retenible, TRUE);
                    IF LineasAbonoCompra2.FINDSET THEN BEGIN
                        BaseAbono := 0;
                        REPEAT
                            BaseAbono += LineasAbonoCompra2.Amount;
                        UNTIL LineasAbonoCompra2.NEXT = 0;
                    END;
                    //IF BaseAbono = 0 THEN CurrReport.SKIP;
                    LineasAbonoCompra.RESET;
                    LineasAbonoCompra.SETRANGE("Document No.", "Purch. Cr. Memo Hdr."."No.");
                    LineasAbonoCompra.SETRANGE(LineasAbonoCompra.Type, LineasAbonoCompra.Type::"G/L Account");
                    LineasAbonoCompra.SETRANGE("No.", "G/L Entry"."G/L Account No.");
                    IF LineasAbonoCompra.FINDSET THEN BEGIN
                        ImporteCuotaAbono += LineasAbonoCompra."Line Amount";
                        RetencionAbono += LineasAbonoCompra.Quantity;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF gblRegProveedor.GET("G/L Entry"."Source No.") THEN;

                //JRG 231017 EXCLUIMOS CUENTAS SIN MARCAR
                /*Cuenta.RESET;
                Cuenta.SETRANGE(Cuenta."No.","G/L Entry"."G/L Account No.");
                IF Cuenta.FINDFIRST THEN BEGIN
                    IF Cuenta."No."  THEN
                       CurrReport.SKIP;
                END;*/

            end;

            trigger OnPreDataItem()
            begin
                /*IF gblCuentasIRPF <> '' THEN
                    "G/L Entry".SETFILTER("G/L Account No.",gblCuentasIRPF);*/
                SETFILTER("G/L Account No.", '%1', '4751*');

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Filter")
                {
                    Caption = 'Filtros';
                    field(CuentasIRPF; gblCuentasIRPF)
                    {
                        Caption = 'N´Š¢ de cuenta';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            regCuentas: Record "15";
                            pagListCuentas: Page "18";
                        begin
                            //regCuentas.SETRANGE(CuentaRetencionIRPF,TRUE);
                            regCuentas.SETFILTER("No.", '%1', '4751*');

                            pagListCuentas.SETTABLEVIEW(regCuentas);
                            pagListCuentas.LOOKUPMODE(TRUE);
                            IF pagListCuentas.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                pagListCuentas.GETRECORD(regCuentas);
                                IF gblCuentasIRPF = '' THEN
                                    gblCuentasIRPF := regCuentas."No."
                                ELSE
                                    gblCuentasIRPF += '|' + regCuentas."No.";
                            END;
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        Retencion = '% Retencion';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.GET();
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        TituloCaptionLbl: Label 'INFORME DE RETENCIONES';
        CuentaCaptionLbl: Label 'Cuenta';
        AcreedorCaptionLbl: Label 'Acreedor';
        FechaEmisionCaptionLbl: Label 'Fecha emisi´Š¢n';
        NumDocumentCaptionLbl: Label 'N´Š¢ de documento';
        NumDocExternoCaptionLbl: Label 'N´Š¢ de doc. externo';
        BaseCaptionLbl: Label 'Base';
        ImporteCuotaCaptionLbl: Label 'Importe cuota';
        PaginaCaptionLbl: Label 'P´Š¢gina';
        gblRegProveedor: Record "23";
        TotalCaptionLbl: Label 'TOTAL';
        PorcRetencionCaptionLbl: Label '% Retenci´Š¢n';
        Cuenta: Record "15";
        MovCuenta: Record "17";
        BaseFactura: Decimal;
        ImporteCuotaFactura: Decimal;
        ImporteCuotaAbono: Decimal;
        Retencion: Decimal;
        LineasFacturaCompra: Record "123";
        LineasFacturaCompra2: Record "123";
        LineasAbonoCompra: Record "125";
        LineasAbonoCompra2: Record "125";
        BaseAbono: Decimal;
        RetencionFactura: Decimal;
        RetencionAbono: Decimal;
        gblCuentasIRPF: Code[1024];
        CompanyInfo: Record "79";
}

