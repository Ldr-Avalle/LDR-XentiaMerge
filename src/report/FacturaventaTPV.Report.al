report 50001 "Factura venta TPV"
{
    ApplicationArea = All;
    Caption = 'Factura venta TPV';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Factura venta TPV.rdl';
    Permissions = tabledata "Sales Shipment Buffer" = rimd;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';

            column(No_SalesInvHdr; "No.")
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_VATRegistrationNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(UserID; UserDims.ShopAddress("Sales Invoice Header"."User ID"))
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(SalesInvoiceHeader_BilltoName; "Sales Invoice Header"."Bill-to Name")
            {
            }
            column(SalesInvoiceHeader_BilltoAddress; "Sales Invoice Header"."Bill-to Address")
            {
            }
            column(recordC_PostCode; recordC."Post Code")
            {
            }
            column(recordC_City; recordC.City)
            {
            }
            column(recordC_VATRegistrationNo; recordC."VAT Registration No.")
            {
            }
            column(SalesInvoiceHeader_DueDate; "Sales Invoice Header"."Due Date")
            {
            }
            column(SalesInvoiceHeader_Amount; "Sales Invoice Header".Amount)
            {
            }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(LineAmt_SalesInvoiceLine; "Line Amount")
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(Description_SalesInvLine; Description)
                {
                }
                column(No_SalesInvoiceLine; "No.")
                {
                }
                column(Quantity_SalesInvoiceLine; Quantity)
                {
                }
                column(UOM_SalesInvoiceLine; "Unit of Measure")
                {
                }
                column(UnitPrice_SalesInvLine; "Unit Price")
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                    AutoFormatType = 2;
                }
                column(LineDisc_SalesInvoiceLine; "Line Discount %")
                {
                }
                column(VATIdent_SalesInvLine; "VAT Identifier")
                {
                }
                column(PostedShipmentDate; Format(PostedShipmentDate))
                {
                }
                column(Type_SalesInvoiceLine; Format("Sales Invoice Line".Type))
                {
                }
                column(InvDiscountAmount; -"Inv. Discount Amount")
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(SalesInvoiceLineAmount; Amount)
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(AmountIncludingVATAmount; "Amount Including VAT" - Amount)
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(Amount_SalesInvoiceLineIncludingVAT; "Amount Including VAT")
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                    AutoFormatType = 1;
                }
                column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText())
                {
                }
                column(TotalExclVATText; TotalExclVATText)
                {
                }
                column(TotalInclVATText; TotalInclVATText)
                {
                }
                column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
                {
                    AutoFormatType = 1;
                }
                column(VATAmtLineVATCalcType; VATAmountLine."VAT Calculation Type")
                {
                }
                column(LineNo_SalesInvoiceLine; "Line No.")
                {
                }
                column(PaymentMethod_Description; PaymentMethod.Description)
                {
                }
                column(PaymentTerms_Description; PaymentTerms.Description)
                {
                }

                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Item No." = field("No.");
                    DataItemTableView = sorting("Item No.", "Posting Date");

                    column(ItemLedgEntry_SerialNo; ItemLedgEntry."Serial No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        encontrado: Boolean;
                    begin
                        if "Serial No." = '' then CurrReport.Skip();
                    end;

                    trigger OnPreDataItem()
                    begin
                        if "Sales Invoice Line"."Shipment No." <> '' then begin
                            "Item Ledger Entry".SetRange("Document No.", "Sales Invoice Line"."Shipment No.");
                            "Item Ledger Entry".SetRange("Document Line No.", "Sales Invoice Line"."Shipment Line No.");
                        end else begin
                            "Item Ledger Entry".SetRange("External Document No.", "Sales Invoice Header"."External Document No.");
                            "Item Ledger Entry".SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
                        end;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            var
                rec21: Record "Cust. Ledger Entry";
                SalesCrMemoHeader: Record "Sales Cr.Memo Header";
            begin
                if ImpFactNoAbonadas then begin
                    SalesCrMemoHeader.SetFilter("Corrected Invoice No.", '%1', "No.");
                    if SalesCrMemoHeader.Count > 0 then CurrReport.Skip();
                end;

                if PaymentMethod.Get("Payment Method Code") then;
                if PaymentTerms.Get("Payment Terms Code") then;

                CalcFields(Amount, "Amount Including VAT");
                recordC.Get("Bill-to Customer No.");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(ImpFactNoAbonadas; ImpFactNoAbonadas)
                {
                    Caption = 'Solo imprimir Facturas no Abonadas';
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        SalesSetup.Get();

        CompanyInfo.CalcFields(Picture, "Reports Image");
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        Language: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[30];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        PorVat: Decimal;
        ShowInternalInfo: Boolean;
        PorEC: Decimal;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        CalculatedExchRate: Decimal;
        VATPostingSetup: Record "VAT Posting Setup";
        PaymentMethod: Record "Payment Method";
        recordC: Record Customer;
        recordSIH: Record "Sales Invoice Header";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        ItemLedgEntry: Record "Item Ledger Entry" temporary;
        ImpFactNoAbonadas: Boolean;
        UserDims: Record "User Dimensions_LDR";
        Text000: Label 'Salesperson', Comment = 'ESP="Vendedor"';
        Text001: Label 'Total %1', Comment = 'ESP="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'ESP="Total %1 IVA incl."';
        Text003: Label 'COPY', Comment = 'ESP="COPIA"';
        Text004: Label 'Sales - Invoice %1', Comment = 'ESP="Ventas - Factura %1"';
        Text005: Label 'Page %1', Comment = 'ESP="Pág. %1"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'ESP="Total %1 IVA excl."';
        Text007: Label 'VAT Amount Specification in ', Comment = 'ESP="Especificar importe IVA en"';
        Text008: Label 'Local Currency', Comment = 'ESP="Divisa local"';
        Text009: Label 'Exchange rate: %1/%2', Comment = 'ESP="Tipo cambio: %1/%2"';
        Text1100000: Label 'Total %1 Incl. VAT+EC', Comment = 'ESP="Total %1 IVA+RE incl."';
        Text1100001: Label 'Total %1 Excl. VAT+EC', Comment = 'ESP="Total %1 IVA+RE excl."';
}