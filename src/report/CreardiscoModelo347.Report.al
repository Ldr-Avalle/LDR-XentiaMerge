report 50070 "Crear disco Modelo 347"
{
    ApplicationArea = All;
    Caption = 'Crear disco Modelo 347';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number) order(ascending) where(Number = const(1));

            trigger OnPreDataItem()
            begin
                NotIn347Amt := 0;
                if (ContactNameCompany = '') or (ContactSurName1Company = '') or (ContactSurName2Company = '') then
                    Error(Text001);

                //OutFile.WRITE(PADSTR('', 250, ' ')); //TODO:OnPrem
            end;
        }
        dataitem(Customer; Customer)
        {
            CalcFields = "Inv. Amounts (LCY)", "Cr. Memo Amounts (LCY)";
            DataItemTableView = sorting("VAT Registration No.");
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Document Type", "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code");
                dataitem(GLEntry1; "G/L Entry")
                {
                    DataItemLink = "Document No." = field("Document No."), "Posting Date" = field("Posting Date");
                    DataItemTableView = sorting("Document No.", "Posting Date") where("Gen. Posting Type" = const(Sale));

                    trigger OnAfterGetRecord()
                    begin
                        GLAccount.Get(GLEntry1."G/L Account No.");
                        if GLAccount."Ignore in 347 Report" then
                            NotIn347Amt := NotIn347Amt + Amount + "VAT Amount";
                    end;

                    trigger OnPostDataItem()
                    begin
                        if (Customer."VAT Registration No." <> PrevVATRegNo) then begin
                            NewGroupStarted := true;
                            Cust.SetRange("Date Filter");
                            Cust.SetRange("Country/Region Code");
                            Cust.SetRange("Date Filter", FromDate, ToDate);
                            Cust.SetRange("VAT Registration No.", Customer."VAT Registration No.");
                            if Cust.Find('-') then
                                repeat
                                    Cust.CalcFields("Inv. Amounts (LCY)", "Cr. Memo Amounts (LCY)");
                                    SalesAmt := SalesAmt + (Cust."Inv. Amounts (LCY)" - Cust."Cr. Memo Amounts (LCY)");
                                until Cust.Next() = 0;

                            TotalNotIn347Amt := Abs(TotalNotIn347Amt + NotIn347Amt);

                            SalesAmt := SalesAmt + NotIn347Amt;
                            if SalesAmt >= MinAmount then begin
                                if PostCode347 = '     ' then
                                    Error(Text1100006, Customer."No.");
                                if VATRegNo347 = '         ' then
                                    Error(Text1100007, Customer."No.");
                                Clear(OutText);
                                if LocalCurrencyCode = LocalCurrencyCode::EUR then
                                    AmountText := AmtEuro(SalesAmt)
                                else
                                    AmountText := Format(SalesAmt, 15, Text1100004);

                                OutText := '2347' + Format(Date2DMY(FromDate, 3)) + VATRegNo + VATRegNo347 + PadStr('', 9, ' ') +
                                  UpperCase(Name347) + Text1100002 + CopyStr(PostCode347, 1, 2) + PadStr('', 3, ' ') + Text1100008 +
                                  ConvertStr(AmountText, ' ', '0') + '  ' + PadStr('', 151, ' ');
                                //OutFile.WRITE(OutText); //TODO:OnPrem

                                TotalAmount += SalesAmt;
                                Acum += 1;

                            end;
                            NotIn347Amt := 0;

                            PrevVATRegNo := Customer."VAT Registration No.";
                        end;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    "Cust. Ledger Entry".SetRange("Document Type", "Cust. Ledger Entry"."Document Type"::Invoice, "Document Type"::"Credit Memo");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if (PrevVATRegNo = '') then
                    PrevVATRegNo := "VAT Registration No.";

                VATRegNo347 := PadStr(CopyStr(DelChr("VAT Registration No.", '=', '.-/'), 1, 9), 9, ' ');
                Name347 := PadStr(Name, 40, ' ');
                Name347 := ConvertStr(UpperCase(Name347), '´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢ÙÑÜ()"&´Š¢', Text1100003);
                PostCode347 := PadStr(StatementNo("Post Code"), 5, ' ');
                CountryCity := CopyStr(PostCode347, 1, 2) + '   ';
                if Customer."Country/Region Code" <> '' then begin
                    Country.Get(Customer."Country/Region Code");
                    if StatementNo(Country."EU Country/Region Code") <> '' then
                        CountryCity := '99' + CopyStr(StatementNo(Country."EU Country/Region Code"), 1, 3);
                end;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals(SalesAmt);
                SetRange("Date Filter", FromDate, ToDate);
                SetFilter("VAT Registration No.", '<> %1', '');
                SetFilter("Country/Region Code", '= %1', CountryCode);
                PrevVATRegNo := Customer."VAT Registration No.";
            end;
        }
        dataitem(Vendor; Vendor)
        {
            CalcFields = "Inv. Amounts (LCY)", "Cr. Memo Amounts (LCY)";
            DataItemTableView = sorting("VAT Registration No.");
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = field("No."), "Posting Date" = field("Date Filter");
                DataItemTableView = sorting("Document Type", "Vendor No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code");
                dataitem(GLEntry2; "G/L Entry")
                {
                    DataItemLink = "Document No." = field("Document No."), "Posting Date" = field("Posting Date");
                    DataItemTableView = sorting("Document No.", "Posting Date") where("Gen. Posting Type" = const(Purchase));
                    PrintOnlyIfDetail = true;

                    trigger OnAfterGetRecord()
                    begin
                        GLAccount.Get(GLEntry2."G/L Account No.");
                        if GLAccount."Ignore in 347 Report" then
                            NotIn347Amt := NotIn347Amt + Amount + "VAT Amount";
                    end;

                    trigger OnPostDataItem()
                    begin
                        if (Vendor."VAT Registration No." <> PrevVATRegNo) then begin
                            NewGroupStarted := true;
                            Vend.SetRange("Date Filter");
                            Vend.SetRange("Country/Region Code");
                            Vend.SetRange("Date Filter", FromDate, ToDate);
                            Vend.SetRange("VAT Registration No.", Vendor."VAT Registration No.");
                            if Vend.Find('-') then
                                repeat
                                    Vend.CalcFields("Inv. Amounts (LCY)", "Cr. Memo Amounts (LCY)");
                                    PurchasesAmt := PurchasesAmt + (Vend."Inv. Amounts (LCY)" - Vend."Cr. Memo Amounts (LCY)");
                                until Vend.Next() = 0;

                            TotalNotIn347Amt := TotalNotIn347Amt + NotIn347Amt;

                            PurchasesAmt := PurchasesAmt - NotIn347Amt;
                            if PurchasesAmt >= MinAmount then begin
                                if PostCode347 = '     ' then
                                    Error(Text1100009, Vendor."No.");
                                if VATRegNo347 = '         ' then
                                    Error(Text1100010, Vendor."No.");
                                Clear(OutText);
                                if LocalCurrencyCode = LocalCurrencyCode::EUR then
                                    AmountText := AmtEuro(PurchasesAmt)
                                else
                                    AmountText := Format(PurchasesAmt, 15, Text1100004);

                                OutText := '2347' + Format(Date2DMY(FromDate, 3)) + VATRegNo + VATRegNo347 + PadStr('', 9, ' ') +
                                  UpperCase(Name347) + Text1100002 + CopyStr(PostCode347, 1, 2) + PadStr('', 3, ' ') + Text1100011 +
                                  ConvertStr(AmountText, ' ', '0') + '  ' + PadStr('', 151, ' ');
                                // OutFile.WRITE(OutText); //TODO:OnPrem

                                TotalAmount += PurchasesAmt;
                                Acum += 1;
                            end;
                            NotIn347Amt := 0;

                            PrevVATRegNo := Vendor."VAT Registration No.";
                        end;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    "Vendor Ledger Entry".SetRange("Document Type", "Vendor Ledger Entry"."Document Type"::Invoice, "Document Type"::"Credit Memo");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if (PrevVATRegNo = '') then
                    PrevVATRegNo := "VAT Registration No.";

                VATRegNo347 := PadStr(CopyStr(DelChr("VAT Registration No.", '=', '.-/'), 1, 9), 9, ' ');
                Name347 := PadStr(Name, 40, ' ');
                Name347 := ConvertStr(UpperCase(Name347), '´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢ÙÑÜ()"&´Š¢', Text1100003);
                PostCode347 := PadStr(StatementNo("Post Code"), 5, ' ');
                CountryCity := CopyStr(PostCode347, 1, 2) + '   ';
                if Vendor."Country/Region Code" <> '' then begin
                    Country.Get(Vendor."Country/Region Code");
                    if StatementNo(Country."EU Country/Region Code") <> '' then
                        CountryCity := '99' + CopyStr(StatementNo(Country."EU Country/Region Code"), 1, 3);
                end;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals(PurchasesAmt);
                SetRange("Date Filter", FromDate, ToDate);
                SetFilter("VAT Registration No.", '<> %1', '');
                SetFilter("Country/Region Code", '= %1', CountryCode);
                PrevVATRegNo := Vendor."VAT Registration No."
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(FromDate; FromDate)
                {
                    Caption = 'Desde fecha';
                }
                field(ToDate; ToDate)
                {
                    Caption = 'Hasta fecha';
                }
                field(MinAmount; MinAmount)
                {
                    Caption = 'Importe mín.';
                }
                field(ContactNameCompany; ContactNameCompany)
                {
                    Caption = 'Nombre contacto E´Š¢';
                }
                field(ContactSurName1Company; ContactSurName1Company)
                {
                    Caption = 'Primer apellido contacto';
                }
                field(ContactSurName2Company; ContactSurName2Company)
                {
                    Caption = 'Segundo apellido contacto';
                }
                field(ContactTelephone; ContactTelephone)
                {
                    Caption = 'Núm. teléfono cantacto';
                }
                field(LocalCurrencyCode; LocalCurrencyCode)
                {
                    Caption = 'Cód. divisa local';
                }
                field(CountryCode; CountryCode)
                {
                    Caption = 'Cód. país/región';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        if Page.RunModal(Page::"Countries/Regions", Country) = Action::LookupOK then
                            CountryCode := Country.Code;
                    end;
                }
                field(FileName; FileName)
                {
                    Caption = 'Nombre archivo';
                }
            }
        }

        trigger OnOpenPage()
        begin
            if MinAmount = 0 then
                MinAmount := 3000;
            if DelegationCode = '' then
                DelegationCode := '00';
            if AdminCode = '' then
                AdminCode := '000';
            if FileName = '' then
                FileName := Text1100012;
            CountryCode := Text1100013;
        end;
    }

    var
        CompanyInfo: Record "Company Information";
        Country: Record "Country/Region";
        GLAccount: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        RBMgt: Codeunit "File Management";
        OutFile: File;
        CountryCity: Text[5];
        OutText: Text[250];
        CountryCode: Code[10];
        MinAmount: Decimal;
        SalesAmt: Decimal;
        DelegationCode: Code[2];
        AdminCode: Code[3];
        Character: Text[1];
        Position: Integer;
        Found: Boolean;
        i: Integer;
        PurchasesAmt: Decimal;
        VATRegNo: Text[9];
        Name347: Text[40];
        VATRegNo347: Text[9];
        PostCode347: Text[5];
        FromDate: Date;
        ToDate: Date;
        FileName: Text[1024];
        IsDigit: Boolean;
        NotIn347Amt: Decimal;
        TotalNotIn347Amt: Decimal;
        TotalAmount: Decimal;
        AmountText: Text[15];
        Acum: Integer;
        ContactNameCompany: Text[30];
        ContactSurName1Company: Text[30];
        ContactSurName2Company: Text[30];
        ContactTelephone: Text[9];
        LocalCurrencyCode: Option EUR,ESP;
        TempString: Text[30];
        ToFile: Text[1024];
        PrevVATRegNo: Text[30];
        NewGroupStarted: Boolean;
        FileNameControlVisible: Boolean;
        Text1100000: Label 'Please enter start date and end date.', Comment = 'ESP="Especifique un rango de fechas"';
        Text1100001: Label 'AAEEIIOOUUÐU    ', Comment = 'ESP="AAEEIIOOUUÐU    "';
        Text1100002: Label 'D';
        Text1100003: Label 'AAEEIIOOUUÐU    ', Comment = 'ESP="AAEEIIOOUUÐU    "';
        Text1100004: Label '<Integer>', Comment = 'ESP="<Integer>"';
        Text1100005: Label 'AAEEIIOOUUÑU    ', Comment = 'ESP="AAEEIIOOUUÑU    "';
        Text1100006: Label 'Postal Code is missing in customer''s card %1', Comment = 'ESP="Falta el código postal en la ficha del cliente %1"';
        Text1100007: Label 'The VAT Registration Number is missing in the Customer %1', Comment = 'ESP="Falta especificar CIF/NIF en la ficha del cliente %1"';
        Text1100008: Label 'B';
        Text1100009: Label 'Postal Code is missing in vendor''s card %1', Comment = 'ESP="Falta el código postal en la ficha del proveedor %1"';
        Text1100010: Label 'The VAT Registration Number is missing in the Vendor %1', Comment = 'ESP="Falta especificar CIF/NIF en la ficha del proveedor %1"';
        Text1100011: Label 'A';
        Text1100012: Label 'C:\347\MOD347.TXT', Comment = 'ESP="C:\347\MOD347.TXT"';
        Text001: Label 'Contact details are mandatory', Comment = 'ESP="La información de contacto es obligatoria"';
        Text1100013: Label 'ES';

    procedure StatementNo(FullText: Text[30]) NumberR: Text[5]
    begin
        Character := '';
        Position := 0;
        Found := false;
        NumberR := '';

        repeat
            Position := Position + 1;
            Character := CopyStr(FullText, Position, 1);
            Found := Character in ['0' .. '9'];
        until Found or (Position >= StrLen(FullText));

        if not Found then
            exit(NumberR);

        i := 1;
        IsDigit := false;
        repeat
            IsDigit := CopyStr(FullText, Position, 1) in ['0' .. '9'];
            if IsDigit then begin
                NumberR := NumberR + CopyStr(FullText, Position, 1);
                FullText := DelStr(FullText, Position, 1);
                i := i + 1;
            end;
        until (i > 5) or not IsDigit;

        exit(NumberR);
    end;

    procedure AmtEuro(Amount: Decimal): Text[15]
    var
        AmtText: Text[15];
    begin
        AmtText := ConvertStr(Format(Amount), ' ', '0');
        if StrPos(AmtText, ',') = 0 then
            AmtText := AmtText + '00'
        else begin
            if StrLen(CopyStr(AmtText, StrPos(AmtText, ','), StrLen(AmtText))) = 2 then
                AmtText := AmtText + '0';
            AmtText := DelChr(AmtText, '=', ',');
        end;
        if StrPos(AmtText, '.') = 0 then
            AmtText := AmtText
        else
            AmtText := DelChr(AmtText, '=', '.');
        while StrLen(AmtText) < 15 do
            AmtText := '0' + AmtText;
        exit(AmtText);
    end;

    procedure CreateFileHeader()
    begin
        Clear(OutText);
        Clear(TempString);

        CompanyInfo.Name := ConvertStr(UpperCase(CompanyInfo.Name), '´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢ÙÑÜ()"&', Text1100001);

        OutText := '1347' + Format(Date2DMY(FromDate, 3)) + VATRegNo + UpperCase(PadStr(CompanyInfo.Name, 40, ' ')) + Text1100002;

        if ContactTelephone <> '' then
            OutText := OutText + UpperCase(PadStr(ContactTelephone, 9, '0'))
        else
            OutText := OutText + PadStr('', 9, '0');
        if ContactNameCompany <> '' then begin
            TempString := CopyStr(
              ConvertStr(UpperCase(ContactSurName1Company), '´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢ÙÑÜ()"&´Š¢', Text1100003) + ' ' +
              ConvertStr(UpperCase(ContactSurName2Company), '´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢ÙÑÜ()"&´Š¢', Text1100003) + ' ' +
              ConvertStr(UpperCase(ContactNameCompany), '´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢ÙÑÜ()"&´Š¢', Text1100003), 1, 30);
            OutText := OutText + UpperCase(PadStr(TempString, 40, ' '));
        end

        else
            OutText := OutText + PadStr('', 40, ' ');

        if LocalCurrencyCode = LocalCurrencyCode::EUR then
            OutText := OutText + '348' + PadStr('', 10, '0') + PadStr('', 2, ' ') + PadStr('', 13, '0')
        else
            OutText := OutText + '347' + PadStr('', 10, '0') + PadStr('', 2, ' ') + PadStr('', 13, '0');

        if LocalCurrencyCode = LocalCurrencyCode::EUR then
            AmountText := AmtEuro(TotalAmount)
        else
            AmountText := Format(TotalAmount, 15, Text1100004);

        OutText := OutText + ConvertStr(Format(Acum, 9, Text1100004), ' ', '0') +
          ConvertStr(AmountText, ' ', '0') + PadStr('', 9, '0') + PadStr('', 15, '0') +
          PadStr('', 54, ' ') + PadStr('', 13, ' ');
        //OutFile.WRITE(OutText); //TODO:OnPrem
    end;
}