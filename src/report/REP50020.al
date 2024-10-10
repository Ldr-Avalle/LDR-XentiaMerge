report 50020 "Abono Venta"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Abono Venta.rdlc';
    Permissions = TableData 7190=rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem1000000000;Table114)
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
            column(TBAI_activated;TBAI_activated)
            {
            }
            column(TBAIQR_IMAGE;"Sales Cr.Memo Header".TBAIQRBlob)
            {
            }
            column(TBAIQR_StringValue;"Sales Cr.Memo Header".R_Identificador_TBAI)
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
            column(UserID;UserDims.ShopAddress("Sales Cr.Memo Header"."User ID"))
            {
            }
            column(CompanyInfo_PostCode;CompanyInfo."Post Code")
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
            column(SalesCrMemoHeader_DueDate;"Sales Cr.Memo Header"."Due Date")
            {
            }
            column(SalesCrMemoHeader_DocumentDate;FORMAT("Sales Cr.Memo Header"."Document Date",0,4))
            {
            }
            column(recordC_PhoneNo;recordC."Phone No.")
            {
            }
            column(SalesCrMemoHeader_BilltoName;"Sales Cr.Memo Header"."Bill-to Name")
            {
            }
            column(SalesCrMemoHeader_BilltoAddress;"Sales Cr.Memo Header"."Bill-to Address")
            {
            }
            column(SalesCrMemoHeader_No;"Sales Cr.Memo Header"."No.")
            {
            }
            column(SalesCrMemHeaderAmount;"Sales Cr.Memo Header".Amount)
            {
            }
            column(SalesCrMemoHeaderAmountIncludingVAT;"Sales Cr.Memo Header"."Amount Including VAT")
            {
            }
            column(CompanyInfo_City;CompanyInfo.City)
            {
            }
            column(CompanyInfo_County;CompanyInfo.County)
            {
            }
            column(CompanyInfo_Mercantilregister;CompanyInfo."Mercantil register")
            {
            }
            column(CompanyInfo_Hoja;CompanyInfo.Hoja)
            {
            }
            column(CompanyInfo_Folio;CompanyInfo.Folio)
            {
            }
            column(CompanyInfo_Section;CompanyInfo.Section)
            {
            }
            column(CompanyInfo_Tomo;CompanyInfo.Tomo)
            {
            }
            column(CompanyInfo_Libro;CompanyInfo.Book)
            {
            }
            dataitem(DataItem1000000001;Table115)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(Document No.,Line No.);
                column(VATAmtLineVATCalcType;VATAmountLine."VAT Calculation Type")
                {
                }
                column(PaymentMethod_Description;PaymentMethod.Description)
                {
                }
                column(PaymentTerms_Description;PaymentTerms.Description)
                {
                }
                column(subtotal;subtotal)
                {
                }
                column(totalIva;totalIva)
                {
                }
                column(total;total)
                {
                }
                column(SalesCrMemoLine_Quantity;"Sales Cr.Memo Line".Quantity)
                {
                }
                column(SalesCrMemoLine_Description;"Sales Cr.Memo Line".Description)
                {
                }
                column(SalesCrMemoLine_UnitPrice;"Sales Cr.Memo Line"."Unit Price")
                {
                }
                column(SalesCrMemoLine_LineAmount;"Sales Cr.Memo Line"."Line Amount")
                {
                }
                column(SalesPurchPerson_Name;SalesPurchPerson.Name)
                {
                }
                column(SalesPurchPerson_PhoneNo;SalesPurchPerson."Phone No.")
                {
                }
                column(SalesCrMemoLine_VATporc;"Sales Cr.Memo Line"."VAT %")
                {
                }
                column(VerCampo;VerCampo)
                {
                }
                column(SalesCrMemoLine_Amount;"Sales Cr.Memo Line".Amount)
                {
                }
                column(SalesCrMemoLine_AmountIncludingVAT;"Sales Cr.Memo Line"."Amount Including VAT")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    subtotal := subtotal + "Line Amount";
                    totalIva := totalIva + ("Amount Including VAT" - "Line Amount");
                    total := subtotal + totalIva;

                    IF "Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::" " THEN
                      VerCampo := FALSE
                    ELSE
                      VerCampo:= TRUE;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                recordC.GET("Sell-to Customer No.");
                IF PaymentMethod.GET("Payment Method Code") THEN;
                IF PaymentTerms.GET("Payment Terms Code") THEN;
                IF SalesPurchPerson.GET("Salesperson Code") THEN;
                //<TBAI_AL_01
                "Sales Cr.Memo Header".CALCFIELDS(TBAIQRBlob);
                "Sales Cr.Memo Header".CALCFIELDS(R_Identificador_TBAI);//<TBAI_AL_01
                IF TBAIManagement.TBAIActivated THEN
                TBAI_activated := FALSE
                ELSE
                  TBAI_activated := TRUE;
                //TBAI_AL_01/>
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
        GLSetup.GET;
        CompanyInfo.GET;
        SalesSetup.GET;
        CompanyInfo.CALCFIELDS(Picture, "Reports Image");

        subtotal := 0;
        totalIva := 0;
        total := 0;

        Userdimension:= UserDims.ShopAddress("Sales Cr.Memo Header"."User ID");
        "Sales Cr.Memo Header".CALCFIELDS(TBAIQRBlob);//<TBAI_AL_01
        "Sales Cr.Memo Header".CALCFIELDS(R_Identificador_TBAI);//<TBAI_AL_01
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
        recordCI: Record "79";
        recordC: Record "18";
        recordSIH: Record "112";
        rec50000: Record "50000";
        subtotal: Decimal;
        totalIva: Decimal;
        total: Decimal;
        ItemTrackingMgt: Codeunit "6500";
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
        Userdimension: Code[30];
        VerCampo: Boolean;
        TBAI_activated: Boolean;
        TBAIManagement: Codeunit "10700";
}

