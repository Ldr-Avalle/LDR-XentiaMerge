report 50021 "Abono Venta Actin"
{
    ApplicationArea = All;
    Caption = 'Abono Venta Actin';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Abono Venta Actin.rdl';
    Permissions = tabledata "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
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
            column(UserID; UserDims.ShopAddress("Sales Cr.Memo Header"."User ID"))
            {
            }
            column(CompanyInfo_PostCode; CompanyInfo."Post Code")
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
            column(SalesCrMemoHeader_DueDate; "Sales Cr.Memo Header"."Due Date")
            {
            }
            column(SalesCrMemoHeader_DocumentDate; Format("Sales Cr.Memo Header"."Document Date", 0, 4))
            {
            }
            column(recordC_PhoneNo; recordC."Phone No.")
            {
            }
            column(SalesCrMemoHeader_BilltoName; "Sales Cr.Memo Header"."Bill-to Name")
            {
            }
            column(SalesCrMemoHeader_BilltoAddress; "Sales Cr.Memo Header"."Bill-to Address")
            {
            }
            column(SalesCrMemoHeader_No; "Sales Cr.Memo Header"."No.")
            {
            }
            column(SalesCrMemHeaderAmount; "Sales Cr.Memo Header".Amount)
            {
            }
            column(SalesCrMemoHeaderAmountIncludingVAT; "Sales Cr.Memo Header"."Amount Including VAT")
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
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");
                column(VATAmtLineVATCalcType; VATAmountLine."VAT Calculation Type")
                {
                }
                column(PaymentMethod_Description; PaymentMethod.Description)
                {
                }
                column(PaymentTerms_Description; PaymentTerms.Description)
                {
                }
                column(subtotal; subtotal)
                {
                }
                column(totalIva; totalIva)
                {
                }
                column(total; total)
                {
                }
                column(SalesCrMemoLine_Quantity; "Sales Cr.Memo Line".Quantity)
                {
                }
                column(SalesCrMemoLine_Description; "Sales Cr.Memo Line".Description)
                {
                }
                column(SalesCrMemoLine_UnitPrice; "Sales Cr.Memo Line"."Unit Price")
                {
                }
                column(SalesCrMemoLine_LineAmount; "Sales Cr.Memo Line"."Line Amount")
                {
                }
                column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                {
                }
                column(SalesPurchPerson_PhoneNo; SalesPurchPerson."Phone No.")
                {
                }
                column(SalesCrMemoLine_VATporc; "Sales Cr.Memo Line"."VAT %")
                {
                }
                column(VerCampo; VerCampo)
                {
                }
                column(SalesCrMemoLine_Amount; "Sales Cr.Memo Line".Amount)
                {
                }
                column(SalesCrMemoLine_AmountIncludingVAT; "Sales Cr.Memo Line"."Amount Including VAT")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    subtotal := subtotal + "Line Amount";
                    totalIva := totalIva + ("Amount Including VAT" - "Line Amount");
                    total := subtotal + totalIva;

                    if "Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::" " then
                        VerCampo := false
                    else
                        VerCampo := true;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                recordC.Get("Sell-to Customer No.");
                if PaymentMethod.Get("Payment Method Code") then;
                if PaymentTerms.Get("Payment Terms Code") then;
                if SalesPurchPerson.Get("Salesperson Code") then;
            end;
        }
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        SalesSetup.Get();
        CompanyInfo.CalcFields(Picture, "Reports Image");

        subtotal := 0;
        totalIva := 0;
        total := 0;

        Userdimension := UserDims.ShopAddress("Sales Cr.Memo Header"."User ID");
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
        recordCI: Record "Company Information";
        recordC: Record Customer;
        recordSIH: Record "Sales Invoice Header";
        rec50000: Record "User Dimensions_LDR";
        subtotal: Decimal;
        totalIva: Decimal;
        total: Decimal;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        UserDims: Record "User Dimensions_LDR";
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
}