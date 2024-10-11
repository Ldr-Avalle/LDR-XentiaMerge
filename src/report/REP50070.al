report 50070 "Crear disco Modelo 347"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = CONST(1));

            trigger OnPreDataItem()
            begin
                NotIn347Amt := 0;
                IF (ContactNameCompany = '') OR (ContactSurName1Company = '') OR (ContactSurName2Company = '') THEN
                    ERROR(Text001);

                OutFile.WRITE(PADSTR('', 250, ' '));
            end;
        }
        dataitem(Customer; Customer)
        {
            CalcFields = "Inv. Amounts (LCY)", "Cr. Memo Amounts (LCY)";
            DataItemTableView = SORTING("VAT Registration No.");
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Document Type", "Customer No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code");
                dataitem(GLEntry1; "G/L Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No."),
                                   "Posting Date" = FIELD("Posting Date");
                    DataItemTableView = SORTING("Document No.", "Posting Date")
                                        WHERE("Gen. Posting Type" = CONST(Sale));

                    trigger OnAfterGetRecord()
                    begin
                        GLAccount.GET(GLEntry1."G/L Account No.");
                        IF GLAccount."Ignore in 347 Report" THEN
                            NotIn347Amt := NotIn347Amt + Amount + "VAT Amount";
                    end;

                    trigger OnPostDataItem()
                    begin
                        IF (Customer."VAT Registration No." <> PrevVATRegNo) THEN BEGIN
                            NewGroupStarted := TRUE;
                            Cust.SETRANGE("Date Filter");
                            Cust.SETRANGE("Country/Region Code");
                            Cust.SETRANGE("Date Filter", FromDate, ToDate);
                            Cust.SETRANGE("VAT Registration No.", Customer."VAT Registration No.");
                            IF Cust.FIND('-') THEN
                                REPEAT
                                    Cust.CALCFIELDS("Inv. Amounts (LCY)", "Cr. Memo Amounts (LCY)");
                                    SalesAmt := SalesAmt + (Cust."Inv. Amounts (LCY)" - Cust."Cr. Memo Amounts (LCY)");
                                UNTIL Cust.NEXT = 0;

                            TotalNotIn347Amt := ABS(TotalNotIn347Amt + NotIn347Amt);

                            SalesAmt := SalesAmt + NotIn347Amt;
                            IF SalesAmt >= MinAmount THEN BEGIN
                                IF PostCode347 = '     ' THEN
                                    ERROR(Text1100006, Customer."No.");
                                IF VATRegNo347 = '         ' THEN
                                    ERROR(Text1100007, Customer."No.");
                                CLEAR(OutText);
                                IF LocalCurrencyCode = LocalCurrencyCode::EUR THEN
                                    AmountText := AmtEuro(SalesAmt)
                                ELSE
                                    AmountText := FORMAT(SalesAmt, 15, Text1100004);

                                OutText := '2347' + FORMAT(DATE2DMY(FromDate, 3)) + VATRegNo + VATRegNo347 + PADSTR('', 9, ' ') +
                                  UPPERCASE(Name347) + Text1100002 + COPYSTR(PostCode347, 1, 2) + PADSTR('', 3, ' ') + Text1100008 +
                                  CONVERTSTR(AmountText, ' ', '0') + '  ' + PADSTR('', 151, ' ');
                                OutFile.WRITE(OutText);

                                TotalAmount += SalesAmt;
                                Acum += 1;

                            END;
                            NotIn347Amt := 0;

                            PrevVATRegNo := Customer."VAT Registration No.";
                        END;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    "Cust. Ledger Entry".SETRANGE("Document Type", "Cust. Ledger Entry"."Document Type"::Invoice, "Document Type"::"Credit Memo");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF (PrevVATRegNo = '') THEN
                    PrevVATRegNo := "VAT Registration No.";

                VATRegNo347 := PADSTR(COPYSTR(DELCHR("VAT Registration No.", '=', '.-/'), 1, 9), 9, ' ');
                Name347 := PADSTR(Name, 40, ' ');
                Name347 := CONVERTSTR(UPPERCASE(Name347), '´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢ÙÑÜ()"&´Š¢', Text1100003);
                PostCode347 := PADSTR(StatementNo("Post Code"), 5, ' ');
                CountryCity := COPYSTR(PostCode347, 1, 2) + '   ';
                IF Customer."Country/Region Code" <> '' THEN BEGIN
                    Country.GET(Customer."Country/Region Code");
                    IF StatementNo(Country."EU Country/Region Code") <> '' THEN
                        CountryCity := '99' + COPYSTR(StatementNo(Country."EU Country/Region Code"), 1, 3);
                END;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(SalesAmt);
                SETRANGE("Date Filter", FromDate, ToDate);
                SETFILTER("VAT Registration No.", '<> %1', '');
                SETFILTER("Country/Region Code", '= %1', CountryCode);
                PrevVATRegNo := Customer."VAT Registration No.";
            end;
        }
        dataitem(Vendor; Vendor)
        {
            CalcFields = "Inv. Amounts (LCY)", "Cr. Memo Amounts (LCY)";
            DataItemTableView = SORTING("VAT Registration No.");
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No."),
                               "Posting Date" = FIELD("Date Filter");
                DataItemTableView = SORTING("Document Type", "Vendor No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date", "Currency Code");
                dataitem(GLEntry2; "G/L Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No."),
                                   "Posting Date" = FIELD("Posting Date");
                    DataItemTableView = SORTING("Document No.", "Posting Date")
                                        WHERE("Gen. Posting Type" = CONST(Purchase));
                    PrintOnlyIfDetail = true;

                    trigger OnAfterGetRecord()
                    begin
                        GLAccount.GET(GLEntry2."G/L Account No.");
                        IF GLAccount."Ignore in 347 Report" THEN
                            NotIn347Amt := NotIn347Amt + Amount + "VAT Amount";
                    end;

                    trigger OnPostDataItem()
                    begin
                        IF (Vendor."VAT Registration No." <> PrevVATRegNo) THEN BEGIN
                            NewGroupStarted := TRUE;
                            Vend.SETRANGE("Date Filter");
                            Vend.SETRANGE("Country/Region Code");
                            Vend.SETRANGE("Date Filter", FromDate, ToDate);
                            Vend.SETRANGE("VAT Registration No.", Vendor."VAT Registration No.");
                            IF Vend.FIND('-') THEN
                                REPEAT
                                    Vend.CALCFIELDS("Inv. Amounts (LCY)", "Cr. Memo Amounts (LCY)");
                                    PurchasesAmt := PurchasesAmt + (Vend."Inv. Amounts (LCY)" - Vend."Cr. Memo Amounts (LCY)");
                                UNTIL Vend.NEXT = 0;

                            TotalNotIn347Amt := TotalNotIn347Amt + NotIn347Amt;

                            PurchasesAmt := PurchasesAmt - NotIn347Amt;
                            IF PurchasesAmt >= MinAmount THEN BEGIN
                                IF PostCode347 = '     ' THEN
                                    ERROR(Text1100009, Vendor."No.");
                                IF VATRegNo347 = '         ' THEN
                                    ERROR(Text1100010, Vendor."No.");
                                CLEAR(OutText);
                                IF LocalCurrencyCode = LocalCurrencyCode::EUR THEN
                                    AmountText := AmtEuro(PurchasesAmt)
                                ELSE
                                    AmountText := FORMAT(PurchasesAmt, 15, Text1100004);

                                OutText := '2347' + FORMAT(DATE2DMY(FromDate, 3)) + VATRegNo + VATRegNo347 + PADSTR('', 9, ' ') +
                                  UPPERCASE(Name347) + Text1100002 + COPYSTR(PostCode347, 1, 2) + PADSTR('', 3, ' ') + Text1100011 +
                                  CONVERTSTR(AmountText, ' ', '0') + '  ' + PADSTR('', 151, ' ');
                                OutFile.WRITE(OutText);

                                TotalAmount += PurchasesAmt;
                                Acum += 1;
                            END;
                            NotIn347Amt := 0;

                            PrevVATRegNo := Vendor."VAT Registration No.";
                        END;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    "Vendor Ledger Entry".SETRANGE("Document Type", "Vendor Ledger Entry"."Document Type"::Invoice, "Document Type"::"Credit Memo");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF (PrevVATRegNo = '') THEN
                    PrevVATRegNo := "VAT Registration No.";

                VATRegNo347 := PADSTR(COPYSTR(DELCHR("VAT Registration No.", '=', '.-/'), 1, 9), 9, ' ');
                Name347 := PADSTR(Name, 40, ' ');
                Name347 := CONVERTSTR(UPPERCASE(Name347), '´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢ÙÑÜ()"&´Š¢', Text1100003);
                PostCode347 := PADSTR(StatementNo("Post Code"), 5, ' ');
                CountryCity := COPYSTR(PostCode347, 1, 2) + '   ';
                IF Vendor."Country/Region Code" <> '' THEN BEGIN
                    Country.GET(Vendor."Country/Region Code");
                    IF StatementNo(Country."EU Country/Region Code") <> '' THEN
                        CountryCity := '99' + COPYSTR(StatementNo(Country."EU Country/Region Code"), 1, 3);
                END;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(PurchasesAmt);
                SETRANGE("Date Filter", FromDate, ToDate);
                SETFILTER("VAT Registration No.", '<> %1', '');
                SETFILTER("Country/Region Code", '= %1', CountryCode);
                PrevVATRegNo := Vendor."VAT Registration No."
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
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
                    Caption = 'Importe m´Š¢n.';
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
                    Caption = 'N´Š¢m. tel´Š¢fono cantacto';
                }
                field(LocalCurrencyCode; LocalCurrencyCode)
                {
                    Caption = 'C´Š¢d. divisa local';
                }
                field(CountryCode; CountryCode)
                {
                    Caption = 'C´Š¢d. pa´Š¢s/regi´Š¢n';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        IF PAGE.RUNMODAL(10, Country) = ACTION::LookupOK THEN
                            CountryCode := Country.Code;
                    end;
                }
                field(FileName; FileName)
                {
                    Caption = 'Nombre archivo';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF MinAmount = 0 THEN
                MinAmount := 3000;
            IF DelegationCode = '' THEN
                DelegationCode := '00';
            IF AdminCode = '' THEN
                AdminCode := '000';
            IF FileName = '' THEN
                FileName := Text1100012;
            CountryCode := Text1100013;
            //RequestOptionsPage.FileNameControl.VISIBLE := NOT ISSERVICETIER;
        end;
    }

    labels
    {
    }

    var
        CompanyInfo: Record "79";
        Country: Record "9";
        GLAccount: Record "15";
        Cust: Record "18";
        Vend: Record "23";
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
        RBMgt: Codeunit "419";
        ToFile: Text[1024];
        PrevVATRegNo: Text[30];
        NewGroupStarted: Boolean;
        [InDataSet]
        FileNameControlVisible: Boolean;
        Text1100000: Label 'Please enter start date and end date.';
        Text1100001: Label 'AAEEIIOOUU´Š¢U    ';
        Text1100002: Label 'D';
        Text1100003: Label 'AAEEIIOOUU´Š¢U     ';
        Text1100004: Label '<Integer>';
        Text1100005: Label 'AAEEIIOOUU´Š¢U     ';
        Text1100006: Label 'Postal Code is missing in customer''s card %1';
        Text1100007: Label 'The VAT Registration Number is missing in the Customer %1';
        Text1100008: Label 'B';
        Text1100009: Label 'Postal Code is missing in vendor''s card %1';
        Text1100010: Label 'The VAT Registration Number is missing in the Vendor %1';
        Text1100011: Label 'A';
        Text1100012: Label 'C:\347\MOD347.TXT';
        Text001: Label 'Contact details are mandatory';
        Text1100013: Label 'ES';

    procedure StatementNo(FullText: Text[30]) NumberR: Text[5]
    begin
        Character := '';
        Position := 0;
        Found := FALSE;
        NumberR := '';

        REPEAT
            Position := Position + 1;
            Character := COPYSTR(FullText, Position, 1);
            Found := Character IN ['0' .. '9'];
        UNTIL Found OR (Position >= STRLEN(FullText));

        IF NOT Found THEN
            EXIT(NumberR);

        i := 1;
        IsDigit := FALSE;
        REPEAT
            IsDigit := COPYSTR(FullText, Position, 1) IN ['0' .. '9'];
            IF IsDigit THEN BEGIN
                NumberR := NumberR + COPYSTR(FullText, Position, 1);
                FullText := DELSTR(FullText, Position, 1);
                i := i + 1;
            END;
        UNTIL (i > 5) OR NOT IsDigit;

        EXIT(NumberR);
    end;

    procedure AmtEuro(Amount: Decimal): Text[15]
    var
        AmtText: Text[15];
    begin
        AmtText := CONVERTSTR(FORMAT(Amount), ' ', '0');
        IF STRPOS(AmtText, ',') = 0 THEN
            AmtText := AmtText + '00'
        ELSE BEGIN
            IF STRLEN(COPYSTR(AmtText, STRPOS(AmtText, ','), STRLEN(AmtText))) = 2 THEN
                AmtText := AmtText + '0';
            AmtText := DELCHR(AmtText, '=', ',');
        END;
        IF STRPOS(AmtText, '.') = 0 THEN
            AmtText := AmtText
        ELSE
            AmtText := DELCHR(AmtText, '=', '.');
        WHILE STRLEN(AmtText) < 15 DO
            AmtText := '0' + AmtText;
        EXIT(AmtText);
    end;

    procedure CreateFileHeader()
    begin
        CLEAR(OutText);
        CLEAR(TempString);

        CompanyInfo.Name := CONVERTSTR(UPPERCASE(CompanyInfo.Name), '´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢ÙÑÜ()"&', Text1100001);

        OutText := '1347' + FORMAT(DATE2DMY(FromDate, 3)) + VATRegNo + UPPERCASE(PADSTR(CompanyInfo.Name, 40, ' ')) + Text1100002;

        IF ContactTelephone <> '' THEN
            OutText := OutText + UPPERCASE(PADSTR(ContactTelephone, 9, '0'))
        ELSE
            OutText := OutText + PADSTR('', 9, '0');
        IF ContactNameCompany <> '' THEN BEGIN
            TempString := COPYSTR(
              CONVERTSTR(UPPERCASE(ContactSurName1Company), '´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢ÙÑÜ()"&´Š¢', Text1100003) + ' ' +
              CONVERTSTR(UPPERCASE(ContactSurName2Company), '´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢ÙÑÜ()"&´Š¢', Text1100003) + ' ' +
              CONVERTSTR(UPPERCASE(ContactNameCompany), '´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢´Š¢ÙÑÜ()"&´Š¢', Text1100003), 1, 30);
            OutText := OutText + UPPERCASE(PADSTR(TempString, 40, ' '));
        END

        ELSE
            OutText := OutText + PADSTR('', 40, ' ');

        IF LocalCurrencyCode = LocalCurrencyCode::EUR THEN
            OutText := OutText + '348' + PADSTR('', 10, '0') + PADSTR('', 2, ' ') + PADSTR('', 13, '0')
        ELSE
            OutText := OutText + '347' + PADSTR('', 10, '0') + PADSTR('', 2, ' ') + PADSTR('', 13, '0');




        IF LocalCurrencyCode = LocalCurrencyCode::EUR THEN
            AmountText := AmtEuro(TotalAmount)
        ELSE
            AmountText := FORMAT(TotalAmount, 15, Text1100004);

        OutText := OutText + CONVERTSTR(FORMAT(Acum, 9, Text1100004), ' ', '0') +
          CONVERTSTR(AmountText, ' ', '0') + PADSTR('', 9, '0') + PADSTR('', 15, '0') +
          PADSTR('', 54, ' ') + PADSTR('', 13, ' ');
        OutFile.WRITE(OutText);
    end;
}

