report 50024 "Libro Facturas emitidas"
{
    ApplicationArea = All;
    Caption = 'Libro Facturas emitidas';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Libro Facturas emitidas.rdl';
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("Document Date") order(ascending);
            RequestFilterFields = "Posting Date", "Document Date", "Due Date";

            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CuotaFacturas; ("Sales Invoice Line"."VAT %" * "Sales Invoice Line"."VAT Base Amount") / 100)
            {
            }
            column(SalesInvHeader_AmountIncludingVAT; SalesInvHeader."Amount Including VAT")
            {
            }
            column(totalBaseFacturas2; totalBaseFacturas2)
            {
            }
            column(totalIvaFacturas2; totalIvaFacturas2)
            {
            }
            column(TotalFacturas2; totalBaseFacturas2 + totalIvaFacturas2)
            {
            }
            column(totalBaseFacturas4; totalBaseFacturas4)
            {
            }
            column(totalIvaFacturas4; totalIvaFacturas4)
            {
            }
            column(TotalFacturas4; totalBaseFacturas4 + totalIvaFacturas4)
            {
            }
            column(totalBaseFacturas3; totalBaseFacturas3)
            {
            }
            column(totalIvaFacturas3; totalIvaFacturas3)
            {
            }
            column(totalBaseFacturas; totalBaseFacturas)
            {
            }
            column(totalIvaFacturas; totalIvaFacturas)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("VAT Prod. Posting Group") order(ascending) where(Type = filter(<> ' '));
                RequestFilterFields = "VAT Prod. Posting Group";

                column(SalesInvoiceLine_VATProdPostingGroup; "Sales Invoice Line"."VAT Prod. Posting Group")
                {
                }
                column(SalesInvoiceLine_VATBaseAmount; "Sales Invoice Line"."VAT Base Amount")
                {
                }
                column(SalesInvHeader_No; SalesInvHeader."No.")
                {
                }
                column(SalesInvHeader_DocumentDate; SalesInvHeader."Document Date")
                {
                }
                column(SalesInvHeader_SelltoCustomerName; SalesInvHeader."Sell-to Customer Name")
                {
                }

                trigger OnAfterGetRecord()
                var
                    tot: Decimal;
                    SalesLine: Record "Sales Invoice Line";
                    SalesLine2: Record "Sales Invoice Line";
                begin
                    if ("Document No." <> numeroAnterior) then begin
                        SalesInvHeader.Get("Sales Invoice Line"."Document No.");
                        SalesInvHeader.CalcFields("Amount Including VAT");
                    end else
                        Clear(SalesInvHeader);
                    numeroAnterior := "Document No.";

                    totalBaseFacturas := totalBaseFacturas + "VAT Base Amount";
                    totalIvaFacturas := totalIvaFacturas + (("VAT %" * "VAT Base Amount") / 100);
                end;

                trigger OnPostDataItem()
                begin
                    SalesLine.SetFilter("Document No.", '%1', "Document No.");
                    SalesLine.SetFilter("VAT Prod. Posting Group", '%1', 'IVA21');
                    if SalesLine.FindFirst() then
                        repeat
                            totalBaseFacturas2 := totalBaseFacturas2 + SalesLine."VAT Base Amount";
                            totalIvaFacturas2 := totalIvaFacturas2 + ((SalesLine."VAT %" * SalesLine."VAT Base Amount") / 100);
                        until SalesLine.Next() = 0;

                    SalesLine2.SetFilter("Document No.", '%1', "Document No.");
                    SalesLine2.SetFilter("VAT Prod. Posting Group", '%1', 'EXENTO');
                    if SalesLine2.FindFirst() then
                        repeat
                            totalBaseFacturas3 := totalBaseFacturas3 + SalesLine2."VAT Base Amount";
                            totalIvaFacturas3 := totalIvaFacturas3 + ((SalesLine2."VAT %" * SalesLine."VAT Base Amount") / 100);
                        until SalesLine2.Next() = 0;

                    SalesLine4.SetFilter("Document No.", '%1', "Document No.");
                    SalesLine4.SetFilter("VAT Prod. Posting Group", '%1', 'IVA18');
                    if SalesLine4.FindFirst() then
                        repeat
                            totalBaseFacturas4 := totalBaseFacturas4 + SalesLine4."VAT Base Amount";
                            totalIvaFacturas4 := totalIvaFacturas4 + ((SalesLine4."VAT %" * SalesLine4."VAT Base Amount") / 100);
                        until SalesLine4.Next() = 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                totalIvaFacturas := 0;
                totalBaseFacturas := 0;
                totalIvaFacturas2 := 0;
                totalBaseFacturas2 := 0;
                totalIvaFacturas3 := 0;
                totalBaseFacturas3 := 0;
            end;
        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = sorting("Document Date") order(ascending);

            column(CuotaAbonos; ("Sales Cr.Memo Line"."VAT %" * "Sales Cr.Memo Line"."VAT Base Amount") / 100)
            {
            }
            column(SalesCrMemoHeader_AmountIncludingVAT; "Sales Cr.Memo Header"."Amount Including VAT")
            {
            }
            column(totalBaseAbonos2; totalBaseAbonos2)
            {
            }
            column(totalIvaAbonos2; totalIvaAbonos2)
            {
            }
            column(TotalAbonos2; totalBaseAbonos2 + totalIvaAbonos2)
            {
            }
            column(totalBaseAbonos4; totalBaseAbonos4)
            {
            }
            column(totalIvaAbonos4; totalIvaAbonos4)
            {
            }
            column(TotalAbonos4; totalBaseAbonos4 + totalIvaAbonos4)
            {
            }
            column(totalBaseAbonos3; totalBaseAbonos3)
            {
            }
            column(totalIvaAbonos3; totalIvaAbonos3)
            {
            }
            column(totalBaseAbonos; totalBaseAbonos)
            {
            }
            column(totalIvaAbonos; totalIvaAbonos)
            {
            }
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("VAT Prod. Posting Group") order(ascending) where(Type = filter(<> ' '));

                column(SalesCrMemoLine_VATProdPostingGroup; "Sales Cr.Memo Line"."VAT Prod. Posting Group")
                {
                }
                column(SalesCrMemoLine_VATBaseAmount; "Sales Cr.Memo Line"."VAT Base Amount")
                {
                }
                column(SalesCrMemoHeader_No; SalesCrMemoHeader."No.")
                {
                }
                column(SalesCrMemoHeader_DocumentDate; SalesCrMemoHeader."Document Date")
                {
                }
                column(SalesCrMemoHeader_SelltoCustomerName; SalesCrMemoHeader."Sell-to Customer Name")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if ("Document No." <> numeroAnterior) then begin
                        SalesCrMemoHeader.Get("Sales Cr.Memo Line"."Document No.");
                        SalesCrMemoHeader.CalcFields("Amount Including VAT");
                    end else
                        Clear(SalesInvHeader);
                    numeroAnterior := "Document No.";

                    totalBaseAbonos := totalBaseAbonos + "VAT Base Amount";
                    totalIvaAbonos := totalIvaAbonos + (("VAT %" * "VAT Base Amount") / 100);
                end;

                trigger OnPostDataItem()
                begin
                    CRline.SetFilter("Document No.", '%1', "Document No.");
                    CRline.SetFilter("VAT Prod. Posting Group", '%1', 'IVA21');
                    if CRline.FindFirst() then
                        repeat
                            totalBaseAbonos2 := totalBaseAbonos2 + CRline."VAT Base Amount";
                            totalIvaAbonos2 := totalIvaAbonos2 + ((CRline."VAT %" * CRline."VAT Base Amount") / 100);
                        until CRline.Next() = 0;

                    CRline2.SetFilter("Document No.", '%1', "Document No.");
                    CRline2.SetFilter("VAT Prod. Posting Group", '%1', 'EXENTO');
                    if CRline2.FindFirst() then
                        repeat
                            totalBaseAbonos3 := totalBaseAbonos3 + CRline2."VAT Base Amount";
                        until CRline2.Next() = 0;

                    CRline4.SetFilter("Document No.", '%1', "Document No.");
                    CRline4.SetFilter("VAT Prod. Posting Group", '%1', 'IVA18');
                    if CRline4.FindFirst() then
                        repeat
                            totalBaseAbonos4 := totalBaseAbonos4 + CRline4."VAT Base Amount";
                            totalIvaAbonos4 := totalIvaAbonos4 + ((CRline4."VAT %" * CRline4."VAT Base Amount") / 100);
                        until CRline4.Next() = 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.NewPage();

                totalIvaAbonos := 0;
                totalBaseAbonos := 0;

                "Sales Invoice Header".CopyFilter("Posting Date", "Posting Date");
                "Sales Invoice Header".CopyFilter("Document Date", "Document Date");
                "Sales Invoice Header".CopyFilter("Due Date", "Due Date");
            end;
        }
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = sorting("Document No.", "VAT Prod. Posting Group") order(ascending) where("Generated Autodocument" = const(true));

            column(VATEntry_DocumentNo; "VAT Entry"."Document No.")
            {
            }
            column(VATEntry_DocumentDate; "VAT Entry"."Document Date")
            {
            }
            column(VATEntry_VATProdPostingGroup; "VAT Entry"."VAT Prod. Posting Group")
            {
            }
            column(VATEntry_Base; "VAT Entry".Base)
            {
            }
            column(CuotaAutofacturas; ("VAT Entry"."VAT %" * Base) / 100)
            {
            }
            column(VATEntry_Amount; "VAT Entry".Amount)
            {
            }

            trigger OnPreDataItem()
            begin
                CurrReport.NewPage();

                "Sales Invoice Header".CopyFilter("Posting Date", "Posting Date");
                "Sales Invoice Header".CopyFilter("Document Date", "Document Date");
            end;
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        SalesLine: Record "Sales Invoice Line";
        SalesLine2: Record "Sales Invoice Line";
        CRline: Record "Sales Cr.Memo Line";
        CRline2: Record "Sales Cr.Memo Line";
        SalesLine4: Record "Sales Invoice Line";
        CRline4: Record "Sales Cr.Memo Line";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        totalIvaLinea: Decimal;
        totalIvaFacturas: Decimal;
        totalIvaAbonos: Decimal;
        totalBaseFacturas: Decimal;
        totalBaseAbonos: Decimal;
        numeroAnterior: Code[20];
        totalIvaFacturas2: Decimal;
        totalBaseFacturas2: Decimal;
        totalIvaFacturas3: Decimal;
        totalBaseFacturas3: Decimal;
        totalIvaAbonos2: Decimal;
        totalBaseAbonos2: Decimal;
        totalIvaAbonos3: Decimal;
        totalBaseAbonos3: Decimal;
        totalIvaFacturas4: Decimal;
        totalBaseFacturas4: Decimal;
        totalIvaAbonos4: Decimal;
        totalBaseAbonos4: Decimal;
}