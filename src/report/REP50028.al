report 50028 Pagos
{
    // - Respecto del informe "Pagos vencidos banco" en este se tienen en cuenta facturas y abonos y en el otro solo facturas
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Pagos.rdl';


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
                rec25: Record "25";
                rec122: Record "122";
            begin
                importeDeudaVto := 0;
                rec25.SETRANGE("Vendor No.", "No.");
                rec25.SETFILTER("Document Type", '%1|%2|%3', rec25."Document Type"::Invoice, rec25."Document Type"::Bill,
                      rec25."Document Type"::"Credit Memo");
                IF ((fechaVtoDesde <> 0D) AND (fechaVtoHasta <> 0D)) THEN
                    rec25.SETFILTER("Due Date", '%1..%2', fechaVtoDesde, fechaVtoHasta)
                ELSE BEGIN
                    IF (fechaVtoDesde <> 0D) THEN
                        rec25.SETFILTER("Due Date", '>%1', fechaVtoDesde)
                    ELSE
                        rec25.SETFILTER("Due Date", '<%1', fechaVtoHasta);
                END;
                rec25.SETRANGE(Open, TRUE);
                IF rec25.FINDFIRST THEN BEGIN
                    //recupero los datos de la 1´Š¢ factura vencida
                    fechaFacturaVto := rec25."Posting Date";
                    nombreFormaPago := '';
                    IF rec122.GET(rec25."Document No.") THEN
                        IF rec289.GET(rec122."Payment Method Code") THEN nombreFormaPago := rec289.Description;

                    //recupero el importe de todas las facturas vencidas
                    REPEAT
                        rec25.CALCFIELDS("Remaining Amt. (LCY)");
                        importeDeudaVto := importeDeudaVto + rec25."Remaining Amt. (LCY)";
                    UNTIL rec25.NEXT = 0;
                END;

                IF importeDeudaVto = 0 THEN
                    CurrReport.SKIP
                ELSE BEGIN
                    importeDeudasVto := importeDeudasVto + importeDeudaVto;
                    /*IF expExcel THEN insertarLineaResumen;*/
                END;

            end;

            trigger OnPostDataItem()
            begin
                /*IF expExcel THEN insertarPieResumen;*/

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
                    IF rec122.GET("Document No.") THEN
                        nFacturaProveedor := rec122."Vendor Invoice No."
                    ELSE
                        nFacturaProveedor := Description;

                    totalProveedor := totalProveedor + "Amount (LCY)";

                    /*IF (expExcel AND (COUNT > 0)) THEN insertarLineaDetalle;*/

                end;

                trigger OnPostDataItem()
                begin
                    /*IF (expExcel AND (COUNT > 0)) THEN insertarPieDetalle;*/

                end;

                trigger OnPreDataItem()
                var
                    rec21: Record "21";
                begin
                    SETRANGE("Vendor No.", "Vendor Detalle"."No.");
                    SETFILTER("Document Type", '%1|%2|%3', "Document Type"::Invoice, "Document Type"::Bill, "Document Type"::"Credit Memo");
                    IF ((fechaVtoDesde <> 0D) AND (fechaVtoHasta <> 0D)) THEN
                        SETFILTER("Due Date", '%1..%2', fechaVtoDesde, fechaVtoHasta)
                    ELSE BEGIN
                        IF (fechaVtoDesde <> 0D) THEN
                            SETFILTER("Due Date", '>%1', fechaVtoDesde)
                        ELSE
                            SETFILTER("Due Date", '<%1', fechaVtoHasta);
                    END;
                    SETRANGE(Open, TRUE);

                    /*IF (expExcel AND (COUNT > 0)) THEN insertarCabeceraDetalle;*/

                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF rec289.GET("Payment Method Code") THEN;
                totalProveedor := 0;
            end;

            trigger OnPreDataItem()
            var
                rec21: Record "21";
                rec112: Record "112";
            begin
                CurrReport.NEWPAGE;
                COPYFILTERS(Vendor);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
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

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        recCI.CALCFIELDS(Picture, "Reports Image");
    end;

    trigger OnPostReport()
    begin
        //IF expExcel THEN mostrarExcel;
    end;

    trigger OnPreReport()
    begin
        /*IF expExcel THEN BEGIN
           Excel.crearExcel(FALSE);
           Excel.nuevoWorkbook('Detalle');
           Excel.nuevaSheet('Res´Š¢men');
        
           insertarCabeceraInforme;
           insertarCabeceraResumen;
        END;*/

    end;

    var
        recCI: Record "79";
        fechaVtoDesde: Date;
        fechaVtoHasta: Date;
        expExcel: Boolean;
        Excel: Record "50013" temporary;
        excelRow: Integer;
        importeDeudaVto: Decimal;
        importeDeudasVto: Decimal;
        totalProveedor: Decimal;
        fechaFacturaVto: Date;
        rec289: Record "289";
        nombreFormaPago: Text[30];
        rec122: Record "122";
        nFacturaProveedor: Text[60];
        Text000: Label 'Not Due';
        Text001: Label 'Before';
        Text002: Label 'days';
        Text003: Label 'More than';
        Text004: Label 'Aged by %1';
        Text005: Label 'Total for %1';
        Text006: Label 'Aged as of %1';
        Text007: Label 'Aged by %1';
        Text008: Label 'All Amounts in LCY';
        Text009: Label 'Due Date,Posting Date,Document Date';
        Text010: Label 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.';
        Text011: Label 'Data';
        Text012: Label 'Aged Accounts Receivable';
        Text013: Label 'Company Name';
        Text014: Label 'Report No.';
        Text015: Label 'Report Name';
        Text016: Label 'User ID';
        Text017: Label 'Date';
        Text018: Label 'Customer Filters';
        Text019: Label 'Cust. Ledger Entry Filters';

    procedure insertarCabeceraInforme()
    begin
        /*Excel.nuevoValor('Res´Š¢men','A1','Pagos vencimiento:',TRUE,FALSE,FALSE,12,2,1);
        Excel.nuevoValor('Res´Š¢men','B1',FORMAT(fechaVtoDesde)+' - '+FORMAT(fechaVtoHasta),TRUE,FALSE,FALSE,12,2,1);
        Excel.nuevoValor('Res´Š¢men','A2','Fecha informe:',TRUE,FALSE,FALSE,12,2,1);
        Excel.nuevoValor('Res´Š¢men','B2',TODAY,TRUE,FALSE,FALSE,12,2,1);*/

    end;

    procedure insertarCabeceraResumen()
    begin
        /*Excel.nuevoValor('Res´Š¢men','A4','N´Š¢',TRUE,FALSE,FALSE,12,2,1);
        Excel.nuevoValor('Res´Š¢men','B4','Nombre',TRUE,FALSE,FALSE,12,2,1);
        Excel.nuevoValor('Res´Š¢men','C4','Importe deuda vto.',TRUE,FALSE,FALSE,12,2,1);
        Excel.nuevoValor('Res´Š¢men','D4','Fecha 1´Š¢ factura vto.',TRUE,FALSE,FALSE,12,2,1);
        Excel.nuevoValor('Res´Š¢men','E4','Forma de pago',TRUE,FALSE,FALSE,12,2,1);
        
        excelRow := 5;*/

    end;

    procedure insertarLineaResumen()
    begin
        /*Excel.nuevoValor('Res´Š¢men','A' + FORMAT(excelRow),Vendor."No.",FALSE,FALSE,FALSE,9,1,0);
        Excel.nuevoValor('Res´Š¢men','B' + FORMAT(excelRow),Vendor.Name,FALSE,FALSE,FALSE,9,1,0);
        Excel.nuevoValor('Res´Š¢men','C' + FORMAT(excelRow),importeDeudaVto,FALSE,FALSE,FALSE,9,1,0);
        Excel.nuevoValor('Res´Š¢men','D' + FORMAT(excelRow),fechaFacturaVto,FALSE,FALSE,FALSE,9,1,0);
        Excel.nuevoValor('Res´Š¢men','E' + FORMAT(excelRow),rec289.Description,FALSE,FALSE,FALSE,9,1,0);
        
        excelRow := excelRow + 1;*/

    end;

    procedure insertarPieResumen()
    begin
        /*Excel.nuevoValor('Res´Š¢men','C' + FORMAT(excelRow),importeDeudasVto,TRUE,FALSE,FALSE,12,2,1);
        
        excelRow := 1;*/

    end;

    procedure insertarCabeceraDetalle()
    begin
        /*Excel.nuevoValor('Detalle','A' + FORMAT(excelRow),'No.: ' + "Vendor Detalle"."No.",TRUE,FALSE,FALSE,10,2,1);
        Excel.nuevoValor('Detalle','B' + FORMAT(excelRow),'Nombre:',TRUE,FALSE,FALSE,10,2,1);
        Excel.nuevoValor('Detalle','C' + FORMAT(excelRow),"Vendor Detalle".Name,TRUE,FALSE,FALSE,10,2,1);
        excelRow := excelRow + 1;
        
        Excel.nuevoValor('Detalle','A' + FORMAT(excelRow),'No.: ' + rec289.Description,TRUE,FALSE,FALSE,10,2,1);
        Excel.nuevoValor('Detalle','B' + FORMAT(excelRow),'N´Š¢ tel´Š¢fono: ',TRUE,FALSE,FALSE,10,2,1);
        Excel.nuevoValor('Detalle','C' + FORMAT(excelRow),"Vendor Detalle"."Phone No.",TRUE,FALSE,FALSE,10,2,1);
        excelRow := excelRow + 1;
        
        Excel.nuevoValor('Detalle','B' + FORMAT(excelRow),'Fecha fact.',TRUE,FALSE,FALSE,10,2,1);
        Excel.nuevoValor('Detalle','C' + FORMAT(excelRow),'N´Š¢ fact.',TRUE,FALSE,FALSE,10,2,1);
        Excel.nuevoValor('Detalle','D' + FORMAT(excelRow),'Factura prov.',TRUE,FALSE,FALSE,10,2,1);
        Excel.nuevoValor('Detalle','E' + FORMAT(excelRow),'Fecha venc.',TRUE,FALSE,FALSE,10,2,1);
        Excel.nuevoValor('Detalle','F' + FORMAT(excelRow),'Importe',TRUE,FALSE,FALSE,10,2,1);
        
        excelRow := excelRow + 1;*/

    end;

    procedure insertarLineaDetalle()
    begin
        /*Excel.nuevoValor('Detalle','B' + FORMAT(excelRow),"Vendor Ledger Entry Detalle"."Document Date",FALSE,FALSE,FALSE,9,1,0);
        Excel.nuevoValor('Detalle','C' + FORMAT(excelRow),"Vendor Ledger Entry Detalle"."Document No.",FALSE,FALSE,FALSE,9,1,0);
        Excel.nuevoValor('Detalle','D' + FORMAT(excelRow),nFacturaProveedor,FALSE,FALSE,FALSE,9,1,0);
        Excel.nuevoValor('Detalle','E' + FORMAT(excelRow),"Vendor Ledger Entry Detalle"."Due Date",FALSE,FALSE,FALSE,9,1,0);
        Excel.nuevoValor('Detalle','F' + FORMAT(excelRow),"Vendor Ledger Entry Detalle"."Amount (LCY)",FALSE,FALSE,FALSE,9,1,0);
        
        excelRow := excelRow + 1;*/

    end;

    procedure insertarPieDetalle()
    begin
        /*Excel.nuevoValor('Detalle','F' + FORMAT(excelRow),totalProveedor,TRUE,FALSE,FALSE,10,2,1);
        
        excelRow := excelRow + 3;*/

    end;

    procedure mostrarExcel()
    begin
        /*Excel.ajustarColumnas('Res´Š¢men',0,25);
        
        Excel.ajustarColumnas('Detalle',1,18);
        Excel.ajustarColumnas('Detalle',2,18);
        Excel.ajustarColumnas('Detalle',3,25);
        Excel.ajustarColumnas('Detalle',4,20);
        Excel.ajustarColumnas('Detalle',5,15);
        Excel.ajustarColumnas('Detalle',6,15);
        
        Excel.mostrarExcel(TRUE);*/

    end;
}

