report 50034 "Oferta venta proforma"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Oferta venta proforma.rdl';
    Caption = 'Sales - Quote';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Oferta venta';
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
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
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
            {
            }
            column(SalesHeader_SelltoCustomerName; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(SalesHeader_SelltoAddress; "Sales Header"."Sell-to Address")
            {
            }
            column(rec18_VATRegistrationNo; rec18."VAT Registration No.")
            {
            }
            column(rec5050_Name; rec5050.Name)
            {
            }
            column(rec5050_PhoneNo; rec5050."Phone No.")
            {
            }
            column(rec5050_FaxNo; rec5050."Fax No.")
            {
            }
            column(SalesHeader_No; "Sales Header"."No.")
            {
            }
            column(FechaOferta; FORMAT("Sales Header"."Order Date", 0, 4))
            {
            }
            column(SalesHeader_ExternalDocumentNo; "Sales Header"."External Document No.")
            {
            }
            column(CompanyInfo_City; CompanyInfo.City)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FIND('-') THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO(
                                      '%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL (DimSetEntry1.NEXT = 0);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(SalesLine_Quantity; "Sales Line".Quantity)
                        {
                        }
                        column(SalesLine_Description; "Sales Line".Description)
                        {
                        }
                        column(SalesLine_UnitPrice; "Sales Line"."Unit Price")
                        {
                        }
                        column(SalesLine_LineDiscountDisc; "Sales Line"."Line Discount %")
                        {
                        }
                        column(SalesLine_LineAmount; "Sales Line"."Line Amount")
                        {
                        }
                        column(SalesLine_VATBaseAmount; "Sales Line"."VAT Base Amount")
                        {
                        }
                        column(SalesLine_AmountIncludingVAT; "Sales Line"."Amount Including VAT")
                        {
                        }
                        column(PaymentMethod_Description; PaymentMethod.Description)
                        {
                        }
                        column(PaymentTerms_Description; PaymentTerms.Description)
                        {
                        }
                        column(DatosBancos; DatosBancos)
                        {
                        }
                        column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                        {
                        }
                        column(SalesPurchPerson_PhoneNo; SalesPurchPerson."Phone No.")
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FIND('-') THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO(
                                          '%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                         DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL (DimSetEntry2.NEXT = 0);
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;

                                //DimSetEntry2.SETRANGE("Table ID",DATABASE::"Sales Line"); --> comentado
                                //DimSetEntry2.SETRANGE("Document Type","Sales Line"."Document Type"); --> comentado
                                //DimSetEntry2.SETRANGE("Document No.","Sales Line"."Document No."); --> comentado
                                //DimSetEntry2.SETRANGE("Line No.","Sales Line"."Line No."); --> comentado
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                SalesLine.FIND('-')
                            ELSE
                                SalesLine.NEXT;
                            "Sales Line" := SalesLine;

                            IF NOT "Sales Header"."Prices Including VAT" AND
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                SalesLine."Line Amount" := 0;

                            IF (SalesLine.Type = SalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Sales Line"."No." := '';
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.FIND('+');
                            WHILE MoreLines AND (SalesLine.Description = '') AND (SalesLine."Description 2" = '') AND
                                  (SalesLine."No." = '') AND (SalesLine.Quantity = 0) AND
                                  (SalesLine.Amount = 0)
                            DO
                                MoreLines := SalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SalesLine.SETRANGE("Line No.", 0, SalesLine."Line No.");
                            SETRANGE(Number, 1, SalesLine.COUNT);
                            //TODO: cambio de variable
                            //CurrReport.CREATETOTALS(SalesLine."Line Amount",SalesLine."Inv. Discount Amount",SalesLine."Pmt. Disc. Given Amount");
                            CurrReport.CREATETOTALS(SalesLine."Line Amount", SalesLine."Inv. Discount Amount", SalesLine."Pmt. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (VATAmount = 0) AND (VATAmountLine."VAT %" + VATAmountLine."EC %" = 0) THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              //TODO: cambio de variable
                              //VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT+EC Base", VATAmountLine."VAT Amount",
                              //VATAmountLine."EC Amount", VATAmountLine."Pmt. Disc. Given Amount");
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Amount", VATAmountLine."EC Amount", VATAmountLine."VAT Amount",
                              VATAmountLine."EC Amount", VATAmountLine."Pmt. Discount Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               "Sales Header"."Order Date", "Sales Header"."Currency Code",
                                               //TODO: cambio de variable
                                               //VATAmountLine."VAT+EC Base", "Sales Header"."Currency Factor"));
                                               VATAmountLine."VAT Amount" + VATAmountLine."EC Amount", "Sales Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 "Sales Header"."Order Date", "Sales Header"."Currency Code",
                                                 VATAmountLine."VAT Amount", "Sales Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0) THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            CurrExchRate.FindCurrency("Sales Header"."Order Date", "Sales Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text010, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "80";
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    SalesLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, "Sales Header", SalesLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;
                    IF (VATAmountLine."VAT Calculation Type" = VATAmountLine."VAT Calculation Type"::"Reverse Charge VAT") AND
                        "Sales Header"."Prices Including VAT" THEN BEGIN
                        VATBaseAmount := VATAmountLine.GetTotalLineAmount(FALSE, "Sales Header"."Currency Code");
                        TotalAmountInclVAT := VATAmountLine.GetTotalLineAmount(FALSE, "Sales Header"."Currency Code");
                    END;

                    CurrReport.PAGENO := 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCountPrinted.RUN("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            var
                "Sell-to Country": Text[50];
            begin
                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END;

                //IF ("Payment Method Code" = '2') THEN DatosBancos := '20480096579704000008 / 01827351380101501082 / 00496735162416149352';

                IF rec5050.GET("Sales Header"."Sell-to Contact No.") THEN;
                IF rec18.GET("Sell-to Customer No.") THEN;

                //DimSetEntry1.SETRANGE("Table ID",DATABASE::"Sales Header"); --> comentado
                //DimSetEntry1.SETRANGE("Document Type","Sales Header"."Document Type"); --> comentado
                //DimSetEntry1.SETRANGE("Document No.","Sales Header"."No."); --> comentado

                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text1100000, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text1100001, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text1100000, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text1100001, "Currency Code");
                END;

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Payment Method Code" = '' THEN
                    PaymentMethod.INIT
                ELSE
                    PaymentMethod.GET("Payment Method Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")

                        ELSE
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");

                    END;
                END;
                "Sales Header".MARK(TRUE);
            end;

            trigger OnPostDataItem()
            var
                ToDo: Record "5080";
            begin
                "Sales Header".MARKEDONLY := TRUE;
                COMMIT;
                CurrReport.LANGUAGE := GLOBALLANGUAGE;
                IF "Sales Header".FIND('-') AND ToDo.WRITEPERMISSION THEN
                    IF NOT CurrReport.PREVIEW AND (NoOfRecords = 1) THEN
                        IF CONFIRM(Text007) THEN
                            "Sales Header".CreateTodo;
            end;

            trigger OnPreDataItem()
            begin
                NoOfRecords := COUNT;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(NoOfCopies; NoOfCopies)
                {
                    Caption = 'N´Š¢ copias';
                }
                field(ShowInternalInfo; ShowInternalInfo)
                {
                    Caption = 'Mostrar informaci´Š¢n interna';
                }
                field(ArchiveDocument; ArchiveDocument)
                {
                    Caption = 'Archivar documento';
                    Enabled = ArchiveDocumentEnabled;

                    trigger OnValidate()
                    begin
                        IF NOT ArchiveDocument THEN
                            LogInteraction := FALSE;
                    end;
                }
                field(LogInteraction; LogInteraction)
                {
                    Caption = 'Log interacci´Š¢n';
                    Enabled = LogInteractionEnabled;

                    trigger OnValidate()
                    begin
                        IF LogInteraction THEN
                            //ArchiveDocument := RequestOptionsPage.ArchiveDocument.ENABLED;
                            ArchiveDocumentEnabled := ArchiveDocument;
                    end;
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            ArchiveDocument := ArchiveManagement.SalesDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractTmplCode(1) <> '';

            /*RequestOptionsPage.ArchiveDocument.ENABLED(ArchiveDocument);
            RequestOptionsForm.LogInteraction.ENABLED(LogInteraction);*/

            ArchiveDocumentEnabled := ArchiveDocument;
            LogInteractionEnabled := LogInteraction;

        end;
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
        SalesSetup: Record "311";
        VATAmountLine: Record "290" temporary;
        SalesLine: Record "37" temporary;
        DimSetEntry1: Record "480";
        DimSetEntry2: Record "480";
        RespCenter: Record "5714";
        CurrExchRate: Record "330";
        SalesCountPrinted: Codeunit "313";
        FormatAddr: Codeunit "365";
        SegManagement: Codeunit "5051";
        ArchiveManagement: Codeunit "5063";
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
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        PorVat: Decimal;
        PorEC: Decimal;
        NoOfRecords: Integer;
        TexDesc: Text[30];
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        VATPostingSetup: Record "325";
        PaymentMethod: Record "289";
        rec5050: Record "5050";
        rec18: Record "18";
        DatosBancos: Text[150];
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text004: Label 'Sales - Quote %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        Text007: Label 'Do you want to create a follow-up to-do?';
        Text010: Label 'Exchange rate: %1/%2';
        Text1100000: Label 'Total %1 Incl. VAT+EC';
        Text1100001: Label 'Total %1 Excl. VAT+EC';
        [InDataSet]
        ArchiveDocumentEnabled: Boolean;
        [InDataSet]
        LogInteractionEnabled: Boolean;
}

