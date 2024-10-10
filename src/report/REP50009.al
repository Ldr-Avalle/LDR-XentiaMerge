report 50009 "Factura venta Actin"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Factura venta Actin.rdlc';
    Permissions = TableData 7190 = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
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
            column(imgreports; CompanyInfo.imgReports)
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
            column(DocumentDate; "Sales Invoice Header"."Document Date")
            {
            }
            column(SalesInvoiceHeader_Amount; "Sales Invoice Header".Amount)
            {
            }
            column(SalesInvoiceHeader_AmountIncludingVAT; "Sales Invoice Header"."Amount Including VAT")
            {
            }
            column(SalesInvoiceHeader_PostingDate; "Sales Invoice Header"."Posting Date")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            column(CompanyInfo_County; CompanyInfo.County)
            {
            }
            column(CompanyInfo_Mercantilregister; CompanyInfo."Mercantil register")
            {
            }
            column(CompanyInfo_Hoja; CompanyInfo.Hoja)
            {
            }
            column(CompanyInfo_Folio; CompanyInfo.Folio)
            {
            }
            column(CompanyInfo_Section; CompanyInfo.Section)
            {
            }
            column(CompanyInfo_Tomo; CompanyInfo.Tomo)
            {
            }
            column(CompanyInfo_Libro; CompanyInfo.Book)
            {
            }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(LineAmt_SalesInvoiceLine; "Line Amount")
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
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
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                    AutoFormatType = 2;
                }
                column(LineDisc_SalesInvoiceLine; "Line Discount %")
                {
                }
                column(VATIdent_SalesInvLine; "VAT Identifier")
                {
                }
                column(PostedShipmentDate; FORMAT(PostedShipmentDate))
                {
                }
                column(Type_SalesInvoiceLine; FORMAT("Sales Invoice Line".Type))
                {
                }
                column(InvDiscountAmount; -"Inv. Discount Amount")
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(SalesInvoiceLineAmount; Amount)
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(AmountIncludingVATAmount; "Amount Including VAT" - Amount)
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(Amount_SalesInvoiceLineIncludingVAT; "Amount Including VAT")
                {
                    AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                    AutoFormatType = 1;
                }
                column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
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
                column(SalesInvoiceLine_VATBaseAmount; "Sales Invoice Line"."VAT Base Amount")
                {
                }
                column(BankData; BankData)
                {
                }
                column(SalesInvoiceLineVATPORC; "Sales Invoice Line"."VAT %")
                {
                }
                column(VerCampo; VerCampo)
                {
                }
                column(ImporteIva; VATAmountLine."VAT Amount")
                {
                }
                column(SalesInvoiceLine_Amount; "Sales Invoice Line".Amount)
                {
                }
                column(SalesInvoiceLine_AmountIncludingVAT; "Sales Invoice Line"."Amount Including VAT")
                {
                }
                column(SalesInvoiceLine_VATIdentifier; "Sales Invoice Line"."VAT Identifier")
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Item No." = FIELD("No."),
                                   "Document No." = FIELD("Document No."),
                                   "Document Line No." = FIELD("Line No.");
                    column(ItemLedgEntry_SerialNo; "Item Ledger Entry"."Serial No.")
                    {
                    }
                    column(MostrarSerie; MostrarSerie)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF "Item Ledger Entry"."Serial No." <> '' THEN
                            MostrarSerie := TRUE
                        ELSE
                            MostrarSerie := FALSE;
                    end;

                    trigger OnPreDataItem()
                    begin

                        IF "Sales Invoice Line"."Shipment No." <> '' THEN BEGIN
                            "Item Ledger Entry".SETRANGE("Document No.", "Sales Invoice Line"."Shipment No.");
                            "Item Ledger Entry".SETRANGE("Document Line No.", "Sales Invoice Line"."Shipment Line No.");
                        END ELSE BEGIN
                            IF "Sales Invoice Line"."Job No." = '' THEN BEGIN
                                "Item Ledger Entry".SETRANGE("Item No.", "Sales Invoice Line"."No.");
                                "Item Ledger Entry".SETRANGE("Posting Date", "Sales Invoice Line"."Shipment Date");
                                "Item Ledger Entry".SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
                            END ELSE BEGIN
                                "Item Ledger Entry".SETRANGE("Job No.", "Sales Invoice Line"."Job No.");
                                "Item Ledger Entry".SETRANGE("Job Task No.", "Sales Invoice Line"."Job Task No.");
                                "Item Ledger Entry".SETRANGE("Item No.", "Sales Invoice Line"."No.");
                            END;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::" " THEN
                        VerCampo := FALSE
                    ELSE
                        VerCampo := TRUE;
                end;
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

                IF PaymentMethod.GET("Payment Method Code") THEN;
                IF PaymentTerms.GET("Payment Terms Code") THEN;

                CALCFIELDS(Amount, "Amount Including VAT");

                recordC.GET("Bill-to Customer No.");

                PaymentMethod.GET("Payment Method Code");
                IF "Payment Method Code" = CompanyInfo."Bank Code" THEN BEGIN
                    BankData := CompanyInfo.CCC1 + ' / ' + CompanyInfo.CCC2 + ' / ' + CompanyInfo.CCC3
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ImpFactNoAbonadas; ImpFactNoAbonadas)
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
        CompanyInfo.CALCFIELDS(CompanyInfo.imgReports);
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
        BankData: Text[100];
        MostrarSerie: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        VerCampo: Boolean;
}

