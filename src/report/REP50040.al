report 50040 "Informe de retenciones"
{
    // //Informe de retenciones agrupado por Cuenta y Proveedor
    DefaultLayout = RDLC;
    RDLCLayout = './Informe de retenciones.rdlc';


    dataset
    {
        dataitem(DataItem1000000000;Table17)
        {
            DataItemTableView = SORTING(G/L Account No.,Source No.)
                                ORDER(Ascending);
            RequestFilterFields = "Document Date","Document Type","Source Type","Source No.";
            column(CompanyInfo_Picture;CompanyInfo.Picture)
            {
            }
            column(GlEntry_GLAccountNo;GlEntry."G/L Account No.")
            {
            }
            column(GlEntry_SourceNo;GlEntry."Source No.")
            {
            }
            column(ObtenerAcreedor;getAcreedor("Source No."))
            {
            }
            column(GlEntry_DocumentDate;GlEntry."Document Date")
            {
            }
            column(GlEntry_DocumentNo;GlEntry."Document No.")
            {
            }
            column(ObtenerDocExterno;getDocExterno())
            {
            }
            column(RetentionBase;RetentionBase)
            {
            }
            column(CreditMenosDebit;"Credit Amount"-"Debit Amount")
            {
            }
            column(VendorAmount;VendorAmount)
            {
            }
            column(VendorC;VendorC)
            {
            }
            column(AccAmount;AccAmount)
            {
            }
            column(AccC;AccC)
            {
            }
            column(BaseAmount;BaseAmount)
            {
            }
            column(BaseC;BaseC)
            {
            }
            column(C;C)
            {
            }
            column(NumPagina;NumPagina)
            {
            }
            column(GlEntry_CreditAmount;GlEntry."Credit Amount")
            {
            }
            column(GlEntry_DebitAmount;GlEntry."Debit Amount")
            {
            }

            trigger OnAfterGetRecord()
            var
                PrevVendor: Code[20];
            begin
                //inicializo amounts cuando cambian las agrupaciones
                IF ("Source No." <> GlEntry."Source No.") THEN VendorAmount := 0;
                IF ("Source No." <> GlEntry."Source No.") THEN VendorC:= 0;
                IF ("G/L Account No." <> GlEntry."G/L Account No.") THEN AccAmount := 0;
                IF ("G/L Account No." <> GlEntry."G/L Account No.") THEN AccC := 0;
                GlEntry.GET("Entry No.");

                //calculo retenci´Š¢n y actualizo amounts
                RetentionBase := GetRetentionBase();
                C:="Credit Amount"-"Debit Amount";
                BaseC+= C ;
                AccC += C ;
                VendorC +=C ;
                BaseAmount += RetentionBase;
                //AccAmount += RetentionBase;
                AccAmount := AccAmount + RetentionBase;
                VendorAmount += RetentionBase;

                NumPagina := NumPagina+1;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Document Date");
                
                /*BaseAmount := 0;
                AccAmount := 0;
                VendorAmount := 0;
                BaseC := 0;
                AccC := 0;
                VendorC := 0;*/
                
                
                
                
                //SETFILTER("G/L Account No.", '%1|%2|%3|%4|%5, '475100000', '475100001', '475100002');
                SETFILTER("G/L Account No.", '%1', '4751*');

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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        CompanyInfo: Record "79";
        ChipbipAdmin: Record "50000";
        BaseAmount: Decimal;
        AccAmount: Decimal;
        VendorAmount: Decimal;
        RetentionBase: Decimal;
        GlEntry: Record "17";
        VendorC: Decimal;
        AccC: Decimal;
        BaseC: Decimal;
        C: Decimal;
        NumPagina: Integer;

    procedure getAcreedor(VendorNo: Code[20]) nombre: Text[80]
    var
        Vendor: Record "23";
        PurchInvHead: Record "122";
        PurchCrMemoHeader: Record "124";
    begin
        //IF PurchInvHead.GET("G/L Entry"."Document No.") THEN
        //   IF Vendor.GET(PurchInvHead."Buy-from Vendor No.") THEN EXIT(Vendor.Name);

        //IF PurchCrMemoHeader.GET("G/L Entry"."Document No.") THEN
        //   IF Vendor.GET(PurchCrMemoHeader."Buy-from Vendor No.") THEN EXIT(Vendor.Name);

        //EXIT('');

        IF Vendor.GET(VendorNo) THEN
        EXIT(Vendor.Name);
    end;

    procedure getDocExterno() "no.": Code[20]
    var
        PurchInvHead: Record "122";
        PurchCrMemoHeader: Record "124";
    begin
        IF PurchInvHead.GET("G/L Entry"."Document No.") THEN EXIT(PurchInvHead."Vendor Invoice No.");
        IF PurchCrMemoHeader.GET("G/L Entry"."Document No.") THEN EXIT(PurchCrMemoHeader."Vendor Cr. Memo No.");

        EXIT('');
    end;
}

