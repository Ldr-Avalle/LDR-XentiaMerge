report 50001 "Factura venta TPV"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Factura venta TPV.rdlc';
    Permissions = TableData 7190=rimd;

    dataset
    {
        dataitem(DataItem1000000000;Table112)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.","Sell-to Customer No.","No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(No_SalesInvHdr;"No.")
            {
            }
            column(PaymentTermsDescription;PaymentTerms.Description)
            {
            }
            column(ShipmentMethodDescription;ShipmentMethod.Description)
            {
            }
            column(PaymentMethodDescription;PaymentMethod.Description)
            {
            }
            column(CompanyInfo_Picture;CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Name;CompanyInfo.Name)
            {
            }
            column(CompanyInfo_VATRegistrationNo;CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfo_Address;CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2;CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_PhoneNo;CompanyInfo."Phone No.")
            {
            }
            column(UserID;UserDims.ShopAddress("Sales Invoice Header"."User ID"))
            {
            }
            column(CompanyInfo_PostCode;CompanyInfo."Post Code")
            {
            }
            column(SalesInvoiceHeader_BilltoName;"Sales Invoice Header"."Bill-to Name")
            {
            }
            column(SalesInvoiceHeader_BilltoAddress;"Sales Invoice Header"."Bill-to Address")
            {
            }
            column(recordC_PostCode;recordC."Post Code")
            {
            }
            column(recordC_City;recordC.City)
            {
            }
            column(recordC_VATRegistrationNo;recordC."VAT Registration No.")
            {
            }
            column(SalesInvoiceHeader_DueDate;"Sales Invoice Header"."Due Date")
            {
            }
            column(SalesInvoiceHeader_Amount;"Sales Invoice Header".Amount)
            {
            }
            dataitem(DataItem1000000001;Table113)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(Document No.,Line No.);
                column(LineAmt_SalesInvoiceLine;"Line Amount")
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(Description_SalesInvLine;Description)
                {
                }
                column(No_SalesInvoiceLine;"No.")
                {
                }
                column(Quantity_SalesInvoiceLine;Quantity)
                {
                }
                column(UOM_SalesInvoiceLine;"Unit of Measure")
                {
                }
                column(UnitPrice_SalesInvLine;"Unit Price")
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                    AutoFormatType = 2;
                }
                column(LineDisc_SalesInvoiceLine;"Line Discount %")
                {
                }
                column(VATIdent_SalesInvLine;"VAT Identifier")
                {
                }
                column(PostedShipmentDate;FORMAT(PostedShipmentDate))
                {
                }
                column(Type_SalesInvoiceLine;FORMAT("Sales Invoice Line".Type))
                {
                }
                column(InvDiscountAmount;-"Inv. Discount Amount")
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(SalesInvoiceLineAmount;Amount)
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(AmountIncludingVATAmount;"Amount Including VAT" - Amount)
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(Amount_SalesInvoiceLineIncludingVAT;"Amount Including VAT")
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VATAmtLineVATAmtText;VATAmountLine.VATAmountText)
                {
                }
                column(TotalExclVATText;TotalExclVATText)
                {
                }
                column(TotalInclVATText;TotalInclVATText)
                {
                }
                column(VATBaseDisc_SalesInvHdr;"Sales Invoice Header"."VAT Base Discount %")
                {
                    AutoFormatType = 1;
                }
                column(VATAmtLineVATCalcType;VATAmountLine."VAT Calculation Type")
                {
                }
                column(LineNo_SalesInvoiceLine;"Line No.")
                {
                }
                column(PaymentMethod_Description;PaymentMethod.Description)
                {
                }
                column(PaymentTerms_Description;PaymentTerms.Description)
                {
                }
                dataitem("N´Š¢meros de serie";Table32)
                {
                    DataItemLink = Item No.=FIELD(No.);
                    DataItemTableView = SORTING(Item No.,Posting Date);
                    column(ItemLedgEntry_SerialNo;ItemLedgEntry."Serial No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        encontrado: Boolean;
                    begin
                        IF "Serial No." = '' THEN CurrReport.SKIP;
                    end;

                    trigger OnPreDataItem()
                    begin

                        IF "Sales Invoice Line"."Shipment No." <> '' THEN BEGIN
                           "N´Š¢meros de serie".SETRANGE("Document No.", "Sales Invoice Line"."Shipment No.");
                           "N´Š¢meros de serie".SETRANGE("Document Line No.", "Sales Invoice Line"."Shipment Line No.");
                        END ELSE BEGIN
                           "N´Š¢meros de serie".SETRANGE("External Document No.", "Sales Invoice Header"."External Document No.");
                           "N´Š¢meros de serie".SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
                        END;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            var
                rec21: Record "21";
                SalesCrMemoHeader: Record "114";
            begin

                IF ImpFactNoAbonadas THEN BEGIN
                   SalesCrMemoHeader.SETFILTER("Corrected Invoice No.", '%1', "No.");
                   IF SalesCrMemoHeader.COUNT > 0 THEN CurrReport.SKIP;
                END;

                IF PaymentMethod.GET("Payment Method Code") THEN ;
                IF PaymentTerms.GET("Payment Terms Code") THEN ;

                CALCFIELDS(Amount, "Amount Including VAT");

                recordC.GET("Bill-to Customer No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ImpFactNoAbonadas;ImpFactNoAbonadas)
                {
                    Caption = 'Solo imprimir Facturas no Abonadas';
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
        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;

        CompanyInfo.CALCFIELDS(Picture, "Reports Image");
    end;

    var
        GLSetup: Record "98";
        ShipmentMethod: Record "10";
        PaymentTerms: Record "3";
        SalesPurchPerson: Record "13";
        CompanyInfo: Record "79";
        CompanyInfo1: Record "79";
        CompanyInfo2: Record "79";
        SalesSetup: Record "311";
        Cust: Record "18";
        VATAmountLine: Record "290" temporary;
        DimSetEntry1: Record "480";
        DimSetEntry2: Record "480";
        Language: Record "8";
        CurrExchRate: Record "330";
        SalesInvCountPrinted: Codeunit "315";
        FormatAddr: Codeunit "365";
        SegManagement: Codeunit "5051";
        SalesShipmentBuffer: Record "7190" temporary;
        PostedShipmentDate: Date;
        CustAddr: array [8] of Text[50];
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
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
        VATPostingSetup: Record "325";
        PaymentMethod: Record "289";
        recordC: Record "18";
        recordSIH: Record "112";
        ItemTrackingMgt: Codeunit "6500";
        ItemLedgEntry: Record "32" temporary;
        ImpFactNoAbonadas: Boolean;
        UserDims: Record "50000";
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Sales - Invoice %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        Text1100000: Label 'Total %1 Incl. VAT+EC';
        Text1100001: Label 'Total %1 Excl. VAT+EC';
}

