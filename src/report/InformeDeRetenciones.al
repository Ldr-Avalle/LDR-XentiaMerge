report 50040 "Informe de retenciones"
{
    // //Informe de retenciones agrupado por Cuenta y Proveedor
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Informe de retenciones.rdl';


    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("G/L Account No.", "Source No.")
                                order(ascending);
            RequestFilterFields = "Document Date", "Document Type", "Source Type", "Source No.";
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(GlEntry_GLAccountNo; GlEntry."G/L Account No.")
            {
            }
            column(GlEntry_SourceNo; GlEntry."Source No.")
            {
            }
            column(ObtenerAcreedor; getAcreedor("Source No."))
            {
            }
            column(GlEntry_DocumentDate; GlEntry."Document Date")
            {
            }
            column(GlEntry_DocumentNo; GlEntry."Document No.")
            {
            }
            column(ObtenerDocExterno; getDocExterno())
            {
            }
            column(RetentionBase; RetentionBase)
            {
            }
            column(CreditMenosDebit; "Credit Amount" - "Debit Amount")
            {
            }
            column(VendorAmount; VendorAmount)
            {
            }
            column(VendorC; VendorC)
            {
            }
            column(AccAmount; AccAmount)
            {
            }
            column(AccC; AccC)
            {
            }
            column(BaseAmount; BaseAmount)
            {
            }
            column(BaseC; BaseC)
            {
            }
            column(C; C)
            {
            }
            column(NumPagina; NumPagina)
            {
            }
            column(GlEntry_CreditAmount; GlEntry."Credit Amount")
            {
            }
            column(GlEntry_DebitAmount; GlEntry."Debit Amount")
            {
            }

            trigger OnAfterGetRecord()
            var
                PrevVendor: Code[20];
            begin
                //inicializo amounts cuando cambian las agrupaciones
                if ("Source No." <> GlEntry."Source No.") then VendorAmount := 0;
                if ("Source No." <> GlEntry."Source No.") then VendorC := 0;
                if ("G/L Account No." <> GlEntry."G/L Account No.") then AccAmount := 0;
                if ("G/L Account No." <> GlEntry."G/L Account No.") then AccC := 0;
                GlEntry.Get("Entry No.");

                //calculo retención y actualizo amounts
                RetentionBase := GetRetentionBase();
                C := "Credit Amount" - "Debit Amount";
                BaseC += C;
                AccC += C;
                VendorC += C;
                BaseAmount += RetentionBase;
                AccAmount := AccAmount + RetentionBase;
                VendorAmount += RetentionBase;

                NumPagina := NumPagina + 1;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Document Date");
                SetFilter("G/L Account No.", '%1', '4751*');
            end;
        }
    }

    trigger OnInitReport()
    begin
        CompanyInfo.CalcFields(Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        CompanyInfo: Record "Company Information";
        ChipbipAdmin: Record "User Dimensions_LDR";
        BaseAmount: Decimal;
        AccAmount: Decimal;
        VendorAmount: Decimal;
        RetentionBase: Decimal;
        GlEntry: Record "G/L Entry";
        VendorC: Decimal;
        AccC: Decimal;
        BaseC: Decimal;
        C: Decimal;
        NumPagina: Integer;

    procedure getAcreedor(VendorNo: Code[20]) nombre: Text[80]
    var
        Vendor: Record Vendor;
        PurchInvHead: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
    begin
        if Vendor.Get(VendorNo) then
            exit(Vendor.Name);
    end;

    procedure getDocExterno() "no.": Code[20]
    var
        PurchInvHead: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
    begin
        if PurchInvHead.Get("G/L Entry"."Document No.") then exit(PurchInvHead."Vendor Invoice No.");
        if PurchCrMemoHeader.Get("G/L Entry"."Document No.") then exit(PurchCrMemoHeader."Vendor Cr. Memo No.");

        exit('');
    end;
}

