report 50024 "Libro Facturas emitidas"
{
    // //"VAT Entry" representa las facturas y abonos intracomunitarios
    DefaultLayout = RDLC;
    RDLCLayout = './Libro Facturas emitidas.rdlc';


    dataset
    {
        dataitem(DataItem1000000000;Table112)
        {
            DataItemTableView = SORTING(Document Date)
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date","Document Date","Due Date";
            column(CompanyInfo_Picture;CompanyInfo.Picture)
            {
            }
            column(CuotaFacturas;("Sales Invoice Line"."VAT %" * "Sales Invoice Line"."VAT Base Amount")/100)
            {
            }
            column(SalesInvHeader_AmountIncludingVAT;SalesInvHeader."Amount Including VAT")
            {
            }
            column(totalBaseFacturas2;totalBaseFacturas2)
            {
            }
            column(totalIvaFacturas2;totalIvaFacturas2)
            {
            }
            column(TotalFacturas2;totalBaseFacturas2 +totalIvaFacturas2)
            {
            }
            column(totalBaseFacturas4;totalBaseFacturas4)
            {
            }
            column(totalIvaFacturas4;totalIvaFacturas4)
            {
            }
            column(TotalFacturas4;totalBaseFacturas4 +totalIvaFacturas4)
            {
            }
            column(totalBaseFacturas3;totalBaseFacturas3)
            {
            }
            column(totalIvaFacturas3;totalIvaFacturas3)
            {
            }
            column(totalBaseFacturas;totalBaseFacturas)
            {
            }
            column(totalIvaFacturas;totalIvaFacturas)
            {
            }
            dataitem(DataItem1000000001;Table113)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(VAT Prod. Posting Group)
                                    ORDER(Ascending)
                                    WHERE(Type=FILTER(<>' '));
                RequestFilterFields = "VAT Prod. Posting Group";
                column(SalesInvoiceLine_VATProdPostingGroup;"Sales Invoice Line"."VAT Prod. Posting Group")
                {
                }
                column(SalesInvoiceLine_VATBaseAmount;"Sales Invoice Line"."VAT Base Amount")
                {
                }
                column(SalesInvHeader_No;SalesInvHeader."No.")
                {
                }
                column(SalesInvHeader_DocumentDate;SalesInvHeader."Document Date")
                {
                }
                column(SalesInvHeader_SelltoCustomerName;SalesInvHeader."Sell-to Customer Name")
                {
                }

                trigger OnAfterGetRecord()
                var
                    tot: Decimal;
                    SalesLine: Record "113";
                    SalesLine2: Record "113";
                begin
                    //esto me sirve para mostrar los datos de la cabecera solo en la primera l´Š¢nea de cada grupo de iva (exento, iva16...)
                    IF ("Document No." <> numeroAnterior) THEN BEGIN
                       SalesInvHeader.GET("Sales Invoice Line"."Document No.");
                       SalesInvHeader.CALCFIELDS("Amount Including VAT");
                    END ELSE CLEAR(SalesInvHeader);
                    numeroAnterior := "Document No.";

                    totalBaseFacturas := totalBaseFacturas + "VAT Base Amount";
                    totalIvaFacturas := totalIvaFacturas + (("VAT %" * "VAT Base Amount")/100);
                end;

                trigger OnPostDataItem()
                begin
                    SalesLine.SETFILTER("Document No.",'%1', "Document No.");
                    SalesLine.SETFILTER("VAT Prod. Posting Group",'%1', 'IVA21');
                    IF SalesLine.FINDFIRST THEN
                    REPEAT
                    totalBaseFacturas2 := totalBaseFacturas2 +SalesLine."VAT Base Amount";
                    totalIvaFacturas2 := totalIvaFacturas2 + ((SalesLine."VAT %" * SalesLine."VAT Base Amount")/100);
                     UNTIL SalesLine.NEXT=0;


                    SalesLine2.SETFILTER("Document No.",'%1', "Document No.");
                    SalesLine2.SETFILTER("VAT Prod. Posting Group",'%1','EXENTO' );
                    //SalesLine2.SETFILTER("VAT Base Amount",'>%1',0 );
                    IF SalesLine2.FINDFIRST THEN
                    REPEAT
                    totalBaseFacturas3 := totalBaseFacturas3 +SalesLine2."VAT Base Amount";
                    totalIvaFacturas3 := totalIvaFacturas3 + ((SalesLine2."VAT %" * SalesLine."VAT Base Amount")/100);
                     UNTIL SalesLine2.NEXT=0;

                    SalesLine4.SETFILTER("Document No.",'%1', "Document No.");
                    SalesLine4.SETFILTER("VAT Prod. Posting Group",'%1', 'IVA18');
                    IF SalesLine4.FINDFIRST THEN
                    REPEAT
                    totalBaseFacturas4 := totalBaseFacturas4 +SalesLine4."VAT Base Amount";
                    totalIvaFacturas4 := totalIvaFacturas4 + ((SalesLine4."VAT %" * SalesLine4."VAT Base Amount")/100);
                     UNTIL SalesLine4.NEXT=0;
                end;
            }

            trigger OnPreDataItem()
            begin
                totalIvaFacturas  := 0;
                totalBaseFacturas := 0;
                totalIvaFacturas2  := 0;
                totalBaseFacturas2 := 0;
                totalIvaFacturas3  := 0;
                totalBaseFacturas3 := 0;
            end;
        }
        dataitem(DataItem1000000002;Table114)
        {
            DataItemTableView = SORTING(Document Date)
                                ORDER(Ascending);
            column(CuotaAbonos;("Sales Cr.Memo Line"."VAT %" * "Sales Cr.Memo Line"."VAT Base Amount")/100)
            {
            }
            column(SalesCrMemoHeader_AmountIncludingVAT;"Sales Cr.Memo Header"."Amount Including VAT")
            {
            }
            column(totalBaseAbonos2;totalBaseAbonos2)
            {
            }
            column(totalIvaAbonos2;totalIvaAbonos2)
            {
            }
            column(TotalAbonos2;totalBaseAbonos2+totalIvaAbonos2)
            {
            }
            column(totalBaseAbonos4;totalBaseAbonos4)
            {
            }
            column(totalIvaAbonos4;totalIvaAbonos4)
            {
            }
            column(TotalAbonos4;totalBaseAbonos4+totalIvaAbonos4)
            {
            }
            column(totalBaseAbonos3;totalBaseAbonos3)
            {
            }
            column(totalIvaAbonos3;totalIvaAbonos3)
            {
            }
            column(totalBaseAbonos;totalBaseAbonos)
            {
            }
            column(totalIvaAbonos;totalIvaAbonos)
            {
            }
            dataitem(DataItem1000000003;Table115)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(VAT Prod. Posting Group)
                                    ORDER(Ascending)
                                    WHERE(Type=FILTER(<>' '));
                column(SalesCrMemoLine_VATProdPostingGroup;"Sales Cr.Memo Line"."VAT Prod. Posting Group")
                {
                }
                column(SalesCrMemoLine_VATBaseAmount;"Sales Cr.Memo Line"."VAT Base Amount")
                {
                }
                column(SalesCrMemoHeader_No;SalesCrMemoHeader."No.")
                {
                }
                column(SalesCrMemoHeader_DocumentDate;SalesCrMemoHeader."Document Date")
                {
                }
                column(SalesCrMemoHeader_SelltoCustomerName;SalesCrMemoHeader."Sell-to Customer Name")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //esto me sirve para mostrar los datos de la cabecera solo en la primera l´Š¢nea de cada grupo de iva (exento, iva16...)
                    IF ("Document No." <> numeroAnterior) THEN BEGIN
                       SalesCrMemoHeader.GET("Sales Cr.Memo Line"."Document No.");
                       SalesCrMemoHeader.CALCFIELDS("Amount Including VAT");
                    END ELSE CLEAR(SalesInvHeader);
                    numeroAnterior := "Document No.";

                    totalBaseAbonos := totalBaseAbonos + "VAT Base Amount";
                    totalIvaAbonos := totalIvaAbonos + (("VAT %" * "VAT Base Amount")/100);
                end;

                trigger OnPostDataItem()
                begin
                    CRline.SETFILTER("Document No.",'%1', "Document No.");
                    CRline.SETFILTER("VAT Prod. Posting Group",'%1', 'IVA21');
                    IF CRline.FINDFIRST THEN
                    REPEAT
                    totalBaseAbonos2 := totalBaseAbonos2  +CRline."VAT Base Amount";
                    totalIvaAbonos2 := totalIvaAbonos2 + ((CRline."VAT %" * CRline."VAT Base Amount")/100);
                    UNTIL CRline.NEXT=0;


                    CRline2.SETFILTER("Document No.",'%1', "Document No.");
                    CRline2.SETFILTER("VAT Prod. Posting Group",'%1','EXENTO' );
                    //CRline2.SETFILTER("VAT Base Amount",'>%1',0 );
                    IF CRline2.FINDFIRST THEN
                    REPEAT
                    totalBaseAbonos3 := totalBaseAbonos3 +CRline2."VAT Base Amount";
                    UNTIL CRline2.NEXT=0;


                    CRline4.SETFILTER("Document No.",'%1', "Document No.");
                    CRline4.SETFILTER("VAT Prod. Posting Group",'%1', 'IVA18');
                    IF CRline4.FINDFIRST THEN
                    REPEAT
                    totalBaseAbonos4 := totalBaseAbonos4  +CRline4."VAT Base Amount";
                    totalIvaAbonos4 := totalIvaAbonos4 + ((CRline4."VAT %" * CRline4."VAT Base Amount")/100);
                    UNTIL CRline4.NEXT=0;
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGE;

                totalIvaAbonos  := 0;
                totalBaseAbonos := 0;

                "Sales Invoice Header".COPYFILTER("Posting Date", "Posting Date");
                "Sales Invoice Header".COPYFILTER("Document Date", "Document Date");
                "Sales Invoice Header".COPYFILTER("Due Date", "Due Date");
            end;
        }
        dataitem(DataItem1000000004;Table254)
        {
            DataItemTableView = SORTING(Document No.,VAT Prod. Posting Group)
                                ORDER(Ascending)
                                WHERE(Generated Autodocument=CONST(Yes));
            column(VATEntry_DocumentNo;"VAT Entry"."Document No.")
            {
            }
            column(VATEntry_DocumentDate;"VAT Entry"."Document Date")
            {
            }
            column(VATEntry_VATProdPostingGroup;"VAT Entry"."VAT Prod. Posting Group")
            {
            }
            column(VATEntry_Base;"VAT Entry".Base)
            {
            }
            column(CuotaAutofacturas;("VAT Entry"."VAT %" * Base)/100)
            {
            }
            column(VATEntry_Amount;"VAT Entry".Amount)
            {
            }

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGE;

                "Sales Invoice Header".COPYFILTER("Posting Date", "Posting Date");
                "Sales Invoice Header".COPYFILTER("Document Date", "Document Date");
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "79";
        totalIvaLinea: Decimal;
        totalIvaFacturas: Decimal;
        totalIvaAbonos: Decimal;
        totalBaseFacturas: Decimal;
        totalBaseAbonos: Decimal;
        numeroAnterior: Code[20];
        SalesInvHeader: Record "112";
        SalesCrMemoHeader: Record "114";
        totalIvaFacturas2: Decimal;
        totalBaseFacturas2: Decimal;
        totalIvaFacturas3: Decimal;
        totalBaseFacturas3: Decimal;
        SalesLine: Record "113";
        SalesLine2: Record "113";
        totalIvaAbonos2: Decimal;
        totalBaseAbonos2: Decimal;
        totalIvaAbonos3: Decimal;
        totalBaseAbonos3: Decimal;
        CRline: Record "115";
        CRline2: Record "115";
        totalIvaFacturas4: Decimal;
        totalBaseFacturas4: Decimal;
        SalesLine4: Record "113";
        totalIvaAbonos4: Decimal;
        totalBaseAbonos4: Decimal;
        CRline4: Record "115";
}

