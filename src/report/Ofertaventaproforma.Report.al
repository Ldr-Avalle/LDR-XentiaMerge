report 50034 "Oferta venta proforma"
{
    ApplicationArea = All;
    Caption = 'Sales - Quote', Comment = 'ESP="Oferta venta proforma"';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Oferta venta proforma.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Quote));
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
            column(FechaOferta; Format("Sales Header"."Order Date", 0, 4))
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
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));

                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.Find('-') then
                                    CurrReport.Break();
                            end else
                                if not Continue then
                                    CurrReport.Break();

                            Clear(DimText);
                            Continue := false;
                            repeat
                                OldDimText := DimText;
                                if DimText = '' then
                                    DimText := StrSubstNo(
                                      '%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      StrSubstNo(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until (DimSetEntry1.Next() = 0);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = sorting(Number);
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
                            DataItemTableView = sorting(Number) where(Number = filter(1 ..));

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.Find('-') then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := StrSubstNo(
                                          '%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          StrSubstNo(
                                            '%1, %2 %3', DimText,
                                         DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until (DimSetEntry2.Next() = 0);
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.Break();
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                SalesLine.Find('-')
                            else
                                SalesLine.Next();
                            "Sales Line" := SalesLine;

                            if not "Sales Header"."Prices Including VAT" and
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            then
                                SalesLine."Line Amount" := 0;

                            if (SalesLine.Type = SalesLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Sales Line"."No." := '';
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DeleteAll();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.Find('+');
                            while MoreLines and (SalesLine.Description = '') and (SalesLine."Description 2" = '') and
                                  (SalesLine."No." = '') and (SalesLine.Quantity = 0) and
                                  (SalesLine.Amount = 0)
                            do
                                MoreLines := SalesLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            SalesLine.SetRange("Line No.", 0, SalesLine."Line No.");
                            SetRange(Number, 1, SalesLine.Count);
                            //TODO: cambio de variable
                            //CurrReport.CREATETOTALS(SalesLine."Line Amount",SalesLine."Inv. Discount Amount",SalesLine."Pmt. Disc. Given Amount");
                            CurrReport.CreateTotals(SalesLine."Line Amount", SalesLine."Inv. Discount Amount", SalesLine."Pmt. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = sorting(Number);

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (VATAmount = 0) and (VATAmountLine."VAT %" + VATAmountLine."EC %" = 0) then
                                CurrReport.Break();
                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              //TODO: cambio de variable
                              //VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT+EC Base", VATAmountLine."VAT Amount",
                              //VATAmountLine."EC Amount", VATAmountLine."Pmt. Disc. Given Amount");
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount",
                              VATAmountLine."EC Amount", VATAmountLine."Pmt. Discount Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = sorting(Number);

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(
                                               "Sales Header"."Order Date", "Sales Header"."Currency Code",
                                               //TODO: cambio de variable
                                               //VATAmountLine."VAT+EC Base", "Sales Header"."Currency Factor"));
                                               VATAmountLine."VAT Base", "Sales Header"."Currency Factor"));
                            VALVATAmountLCY := Round(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 "Sales Header"."Order Date", "Sales Header"."Currency Code",
                                                 VATAmountLine."VAT Amount", "Sales Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Header"."Currency Code" = '') or
                               (VATAmountLine.GetTotalVATAmount() = 0) then
                                CurrReport.Break();

                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(VALVATBaseLCY, VALVATAmountLCY);

                            CurrExchRate.FindCurrency("Sales Header"."Order Date", "Sales Header"."Currency Code", 1);
                            VALExchRate := StrSubstNo(Text010, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    Clear(SalesLine);
                    Clear(SalesPost);
                    SalesLine.DeleteAll();
                    VATAmountLine.DeleteAll();
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, "Sales Header", SalesLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := VATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT();
                    if (VATAmountLine."VAT Calculation Type" = VATAmountLine."VAT Calculation Type"::"Reverse Charge VAT") and
                        "Sales Header"."Prices Including VAT" then begin
                        VATBaseAmount := VATAmountLine.GetTotalLineAmount(false, "Sales Header"."Currency Code");
                        TotalAmountInclVAT := VATAmountLine.GetTotalLineAmount(false, "Sales Header"."Currency Code");
                    end;

                    CurrReport.PageNo := 1;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then
                        SalesCountPrinted.Run("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            var
                "Sell-to Country": Text[50];
            begin
                if RespCenter.Get("Responsibility Center") then begin
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end;

                if rec5050.Get("Sales Header"."Sell-to Contact No.") then;
                if rec18.Get("Sell-to Customer No.") then;

                if "Salesperson Code" = '' then begin
                    SalesPurchPerson.Init();
                    SalesPersonText := '';
                end else
                    SalesPurchPerson.Get("Salesperson Code");
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FieldCaption("Your Reference");
                if "VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := FieldCaption("VAT Registration No.");
                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text001, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(Text1100000, GLSetup."LCY Code");
                    TotalExclVATText := StrSubstNo(Text1100001, GLSetup."LCY Code");
                end else begin
                    TotalText := StrSubstNo(Text001, "Currency Code");
                    TotalInclVATText := StrSubstNo(Text1100000, "Currency Code");
                    TotalExclVATText := StrSubstNo(Text1100001, "Currency Code");
                end;

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init()
                else
                    PaymentTerms.Get("Payment Terms Code");
                if "Payment Method Code" = '' then
                    PaymentMethod.Init()
                else
                    PaymentMethod.Get("Payment Method Code");
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init()
                else
                    ShipmentMethod.Get("Shipment Method Code");

                if not CurrReport.Preview then begin
                    if ArchiveDocument then
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", Database::Contact, "Bill-to Contact No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")

                        else
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", Database::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");

                    end;
                end;
                "Sales Header".Mark(true);
            end;

            trigger OnPostDataItem()
            var
                ToDo: Record "To-do";
            begin
                "Sales Header".MarkedOnly := true;
                Commit();
                CurrReport.Language := GlobalLanguage;
                if "Sales Header".Find('-') and ToDo.WritePermission then
                    if not CurrReport.Preview and (NoOfRecords = 1) then
                        if Confirm(Text007) then
                            "Sales Header".CreateTask();
            end;

            trigger OnPreDataItem()
            begin
                NoOfRecords := Count;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(NoOfCopies; NoOfCopies)
                {
                    Caption = 'Nº copias', Comment = 'ESP="Nº copias"';
                }
                field(ShowInternalInfo; ShowInternalInfo)
                {
                    Caption = 'Mostrar información interna';
                }
                field(ArchiveDocument; ArchiveDocument)
                {
                    Caption = 'Archivar documento';
                    Enabled = ArchiveDocumentEnabled;

                    trigger OnValidate()
                    begin
                        if not ArchiveDocument then
                            LogInteraction := false;
                    end;
                }
                field(LogInteraction; LogInteraction)
                {
                    Caption = 'Log interacción';
                    Enabled = LogInteractionEnabled;

                    trigger OnValidate()
                    begin
                        if LogInteraction then
                            ArchiveDocumentEnabled := ArchiveDocument;
                    end;
                }
            }
        }

        trigger OnOpenPage()
        begin
            ArchiveDocument := ArchiveManagement.SalesDocArchiveGranule();
            LogInteraction := SegManagement.FindInteractTmplCode(1) <> '';

            ArchiveDocumentEnabled := ArchiveDocument;
            LogInteractionEnabled := LogInteraction;
        end;
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
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        VATPostingSetup: Record "VAT Posting Setup";
        PaymentMethod: Record "Payment Method";
        rec5050: Record Contact;
        rec18: Record Customer;
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
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
        DatosBancos: Text[150];
        Text001: Label 'Total %1', Comment = 'ESP="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'ESP="Total %1 IVA incl."';
        Text004: Label 'Sales - Quote %1', Comment = 'ESP="Ventas - Oferta %1"';
        Text005: Label 'Page %1', Comment = 'ESP="Pág. %1"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'ESP="Total %1 IVA excl."';
        Text007: Label 'Do you want to create a follow-up to-do?', Comment = 'ESP="¿Desea crear una tarea de seguimiento?"';
        Text010: Label 'Exchange rate: %1/%2', Comment = 'ESP="Tipo cambio: %1/%2"';
        Text1100000: Label 'Total %1 Incl. VAT', Comment = 'ESP="Total %1 IVA+RE incl."';
        Text1100001: Label 'Total %1 Excl. VAT', Comment = 'ESP="Total %1 IVA+RE excl."';
        ArchiveDocumentEnabled: Boolean;
        LogInteractionEnabled: Boolean;
}