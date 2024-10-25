report 50098 RetenAlquilerProfesi
{
    ApplicationArea = All;
    Caption = 'Retenciones de alquileres y profesionales';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/RetenAlquilerProfesi.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = where("Document Type" = filter(Invoice | "Credit Memo"), "Source Type" = const(Vendor), "Source Code" = const(' COMPRAS'));
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
            column(NombreEmpresa; CompanyName)
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
                DataItemLink = "No." = field("Document No."), "Posting Date" = field("Posting Date");
                DataItemTableView = sorting("No.");

                column(ImporteBaseFactura; BaseFactura)
                {
                }
                column(FechaEmisionFactura; "Purch. Inv. Header"."Document Date")
                {
                }
                column(ImporteCuotaFactura; ImporteCuotaFactura)
                {
                }
                column(ContadorFilasFactura; Count)
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

                    LineasFacturaCompra2.Reset();
                    LineasFacturaCompra2.SetRange("Document No.", "Purch. Inv. Header"."No.");
                    LineasFacturaCompra2.SetRange(LineasFacturaCompra2.Retenible, true);
                    if LineasFacturaCompra2.FindSet() then begin
                        BaseFactura := 0;
                        repeat
                            BaseFactura += LineasFacturaCompra2."Line Amount";
                        until LineasFacturaCompra2.Next() = 0;
                    end;
                    LineasFacturaCompra.Reset();
                    LineasFacturaCompra.SetRange("Document No.", "Purch. Inv. Header"."No.");
                    LineasFacturaCompra.SetRange(LineasFacturaCompra.Type, LineasFacturaCompra.Type::"G/L Account");
                    LineasFacturaCompra.SetRange("No.", "G/L Entry"."G/L Account No.");
                    if LineasFacturaCompra.FindSet() then begin
                        ImporteCuotaFactura += LineasFacturaCompra."Line Amount";
                        RetencionFactura += LineasFacturaCompra.Quantity;
                    end;
                end;
            }
            dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
            {
                DataItemLink = "No." = field("Document No."), "Posting Date" = field("Posting Date");
                DataItemTableView = sorting("No.");

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
                column(ContadorFilasAbono; Count)
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

                    LineasAbonoCompra2.Reset();
                    LineasAbonoCompra2.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
                    LineasAbonoCompra2.SetRange(LineasAbonoCompra2.Retenible, true);
                    if LineasAbonoCompra2.FindSet() then begin
                        BaseAbono := 0;
                        repeat
                            BaseAbono += LineasAbonoCompra2.Amount;
                        until LineasAbonoCompra2.Next() = 0;
                    end;
                    LineasAbonoCompra.Reset();
                    LineasAbonoCompra.SetRange("Document No.", "Purch. Cr. Memo Hdr."."No.");
                    LineasAbonoCompra.SetRange(LineasAbonoCompra.Type, LineasAbonoCompra.Type::"G/L Account");
                    LineasAbonoCompra.SetRange("No.", "G/L Entry"."G/L Account No.");
                    if LineasAbonoCompra.FindSet() then begin
                        ImporteCuotaAbono += LineasAbonoCompra."Line Amount";
                        RetencionAbono += LineasAbonoCompra.Quantity;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if gblRegProveedor.Get("G/L Entry"."Source No.") then;
            end;

            trigger OnPreDataItem()
            begin
                SetFilter("G/L Account No.", '%1', '4751*');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Filter")
                {
                    Caption = 'Filtros';
                    field(CuentasIRPF; gblCuentasIRPF)
                    {
                        Caption = 'Nº de cuenta';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            regCuentas: Record "G/L Account";
                            pagListCuentas: Page "G/L Account List";
                        begin
                            regCuentas.SetFilter("No.", '%1', '4751*');

                            pagListCuentas.SetTableView(regCuentas);
                            pagListCuentas.LookupMode(true);
                            if pagListCuentas.RunModal() = Action::LookupOK then begin
                                pagListCuentas.GetRecord(regCuentas);
                                if gblCuentasIRPF = '' then
                                    gblCuentasIRPF := regCuentas."No."
                                else
                                    gblCuentasIRPF += '|' + regCuentas."No.";
                            end;
                        end;
                    }
                }
            }
        }
    }

    labels
    {
        Retencion = '% Retencion';
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        gblRegProveedor: Record Vendor;
        Cuenta: Record "G/L Account";
        MovCuenta: Record "G/L Entry";
        LineasFacturaCompra: Record "Purch. Inv. Line";
        LineasFacturaCompra2: Record "Purch. Inv. Line";
        LineasAbonoCompra: Record "Purch. Cr. Memo Line";
        LineasAbonoCompra2: Record "Purch. Cr. Memo Line";
        CompanyInfo: Record "Company Information";
        TituloCaptionLbl: Label 'INFORME DE RETENCIONES';
        CuentaCaptionLbl: Label 'Cuenta';
        AcreedorCaptionLbl: Label 'Acreedor';
        FechaEmisionCaptionLbl: Label 'Fecha emisión';
        NumDocumentCaptionLbl: Label 'Nº de documento';
        NumDocExternoCaptionLbl: Label 'Nº de doc. externo';
        BaseCaptionLbl: Label 'Base';
        ImporteCuotaCaptionLbl: Label 'Importe cuota';
        PaginaCaptionLbl: Label 'Página';
        TotalCaptionLbl: Label 'TOTAL';
        PorcRetencionCaptionLbl: Label '% Retención';
        Retencion: Decimal;
        BaseFactura: Decimal;
        ImporteCuotaFactura: Decimal;
        ImporteCuotaAbono: Decimal;
        BaseAbono: Decimal;
        RetencionFactura: Decimal;
        RetencionAbono: Decimal;
        gblCuentasIRPF: Code[1024];
}