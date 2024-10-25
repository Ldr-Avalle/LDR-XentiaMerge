report 50028 Pagos
{
    ApplicationArea = All;
    Caption = 'Pagos';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Pagos.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Proveedor';

            column(Vendor_No; Vendor."No.")
            {
            }
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(importeDeudaVto; importeDeudaVto)
            {
            }
            column(fechaFacturaVto; fechaFacturaVto)
            {
            }
            column(nombreFormaPago; nombreFormaPago)
            {
            }
            column(importeDeudasVto; importeDeudasVto)
            {
            }
            column(recCI_Picture; recCI.Picture)
            {
            }
            column(fechaVtoDesde; fechaVtoDesde)
            {
            }
            column(fechaVtoHasta; fechaVtoHasta)
            {
            }

            trigger OnAfterGetRecord()
            var
                rec25: Record "Vendor Ledger Entry";
                rec122: Record "Purch. Inv. Header";
            begin
                importeDeudaVto := 0;
                rec25.SetRange("Vendor No.", "No.");
                rec25.SetFilter("Document Type", '%1|%2|%3', rec25."Document Type"::Invoice, rec25."Document Type"::Bill,
                      rec25."Document Type"::"Credit Memo");
                if ((fechaVtoDesde <> 0D) and (fechaVtoHasta <> 0D)) then
                    rec25.SetFilter("Due Date", '%1..%2', fechaVtoDesde, fechaVtoHasta)
                else
                    if (fechaVtoDesde <> 0D) then
                        rec25.SetFilter("Due Date", '>%1', fechaVtoDesde)
                    else
                        rec25.SetFilter("Due Date", '<%1', fechaVtoHasta);
                rec25.SetRange(Open, true);
                if rec25.FindFirst() then begin
                    fechaFacturaVto := rec25."Posting Date";
                    nombreFormaPago := '';
                    if rec122.Get(rec25."Document No.") then
                        if rec289.Get(rec122."Payment Method Code") then nombreFormaPago := rec289.Description;

                    repeat
                        rec25.CalcFields("Remaining Amt. (LCY)");
                        importeDeudaVto := importeDeudaVto + rec25."Remaining Amt. (LCY)";
                    until rec25.Next() = 0;
                end;

                if importeDeudaVto = 0 then
                    CurrReport.Skip()
                else
                    importeDeudasVto := importeDeudasVto + importeDeudaVto;
            end;

            trigger OnPreDataItem()
            begin
                importeDeudasVto := 0;
            end;
        }
        dataitem("Vendor Detalle"; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterHeading = '.';

            column(VendorDetalle_No; "Vendor Detalle"."No.")
            {
            }
            column(rec289_Description; rec289.Description)
            {
            }
            column(VendorDetalle_Name; "Vendor Detalle".Name)
            {
            }
            column(VendorDetalle_PhoneNo; "Vendor Detalle"."Phone No.")
            {
            }
            dataitem("Vendor Ledger Entry Detalle"; "Vendor Ledger Entry")
            {
                RequestFilterHeading = '.';

                column(VendorLedgerEntryDetalle_DocumentNo; "Vendor Ledger Entry Detalle"."Document No.")
                {
                }
                column(VendorLedgerEntryDetalle_DocumentDate; "Vendor Ledger Entry Detalle"."Document Date")
                {
                }
                column(nFacturaProveedor; nFacturaProveedor)
                {
                }
                column(VendorLedgerEntryDetalle_DueDate; "Vendor Ledger Entry Detalle"."Due Date")
                {
                }
                column(VendorLedgerEntryDetalle_AmountLCY; "Vendor Ledger Entry Detalle"."Amount (LCY)")
                {
                }
                column(totalProveedor; totalProveedor)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if rec122.Get("Document No.") then
                        nFacturaProveedor := rec122."Vendor Invoice No."
                    else
                        nFacturaProveedor := Description;
                    totalProveedor := totalProveedor + "Amount (LCY)";
                end;

                trigger OnPreDataItem()
                var
                    rec21: Record "Cust. Ledger Entry";
                begin
                    SetRange("Vendor No.", "Vendor Detalle"."No.");
                    SetFilter("Document Type", '%1|%2|%3', "Document Type"::Invoice, "Document Type"::Bill, "Document Type"::"Credit Memo");
                    if ((fechaVtoDesde <> 0D) and (fechaVtoHasta <> 0D)) then
                        SetFilter("Due Date", '%1..%2', fechaVtoDesde, fechaVtoHasta)
                    else
                        if (fechaVtoDesde <> 0D) then
                            SetFilter("Due Date", '>%1', fechaVtoDesde)
                        else
                            SetFilter("Due Date", '<%1', fechaVtoHasta);
                    SetRange(Open, true);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if rec289.Get("Payment Method Code") then;
                totalProveedor := 0;
            end;

            trigger OnPreDataItem()
            var
                rec21: Record "Cust. Ledger Entry";
                rec112: Record "Sales Invoice Header";
            begin
                CurrReport.NewPage();
                CopyFilters(Vendor);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(fechaVtoDesde; fechaVtoDesde)
                {
                    Caption = 'Vencido desde';
                }
                field(fechaVtoHasta; fechaVtoHasta)
                {
                    Caption = 'Vencido hasta';
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        recCI.CalcFields(Picture, "Reports Image");
    end;

    var
        recCI: Record "Company Information";
        Excel: Record "Exp. Excel_LDR" temporary;
        rec289: Record "Payment Method";
        rec122: Record "Purch. Inv. Header";
        fechaVtoDesde: Date;
        fechaVtoHasta: Date;
        expExcel: Boolean;
        excelRow: Integer;
        importeDeudaVto: Decimal;
        importeDeudasVto: Decimal;
        totalProveedor: Decimal;
        fechaFacturaVto: Date;
        nombreFormaPago: Text[30];
        nFacturaProveedor: Text[60];
        Text000: Label 'Not Due', Comment = 'ESP="No vencido"';
        Text001: Label 'Before', Comment = 'ESP="Antes"';
        Text002: Label 'days', Comment = 'ESP="días"';
        Text003: Label 'More than', Comment = 'ESP="Más de"';
        Text004: Label 'Aged by %1', Comment = 'ESP="Vencido por %1"';
        Text005: Label 'Total for %1', Comment = 'ESP="Total para %1"';
        Text006: Label 'Aged as of %1', Comment = 'ESP="Vencido desde %1"';
        Text007: Label 'Aged by %1', Comment = 'ESP="Vencido por %1"';
        Text008: Label 'All Amounts in LCY', Comment = 'ESP="Todos importes en DL"';
        Text009: Label 'Due Date,Posting Date,Document Date', Comment = 'ESP="Fecha vencimiento,Fecha registro,Fecha documento"';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.', Comment = 'ESP="La fórmula de fecha %1 no puede usarse. Intente redefinirla. Por ej. 1M+PM en lugar de PM+1M."';
        Text011: Label 'Data', Comment = 'ESP="Datos"';
        Text012: Label 'Aged Accounts Receivable', Comment = 'ESP="Antigüedad cobros"';
        Text013: Label 'Company Name', Comment = 'ESP="Nombre empresa"';
        Text014: Label 'Report No.', Comment = 'ESP="Nº informe"';
        Text015: Label 'Report Name', Comment = 'ESP="Nombre informe"';
        Text016: Label 'User ID', Comment = 'ESP="Id. usuario"';
        Text017: Label 'Date', Comment = 'ESP="Fecha"';
        Text018: Label 'Customer Filters', Comment = 'ESP="Filtros cliente"';
        Text019: Label 'Cust. Ledger Entry Filters', Comment = 'ESP="Filtros mov. cliente"';
}