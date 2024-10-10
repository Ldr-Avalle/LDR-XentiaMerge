report 50065 "Account - Official Acc. Book2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Account - Official Acc. Book2.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table2000000026)
        {
            DataItemTableView = SORTING(Number);
            dataitem(DataItem1000000001;Table15)
            {
                DataItemTableView = SORTING(No.)
                                    WHERE(Account Type=CONST(Posting));
                column(NormalDate_OpenCloseDate;FORMAT(NORMALDATE(OpenCloseDate)))
                {
                }
                column(OpenTransactDesc;OpenTransactDesc)
                {
                }
                column(GLAccount_GlobalDimension2Code;"G/L Account"."Global Dimension 2 Code")
                {
                }
                column(GLAccount_No;"G/L Account"."No.")
                {
                }
                column(GLAccount_Name;"G/L Account".Name)
                {
                }
                column(DebitAmt;DebitAmt)
                {
                }
                column(CreditAmt;CreditAmt)
                {
                }
                column(V1;1)
                {
                }
                column(VerGLAccountOnPre;VerGLAccountOnPre)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SETRANGE("Date Filter",0D,CLOSINGDATE(AccPeriod."Starting Date" - 1));
                    CALCFIELDS("Balance at Date","Add.-Currency Balance at Date");
                    IF NOT PrintAmountsInAddCurrency THEN
                      IF "Balance at Date" > 0 THEN BEGIN
                        DebitAmt := "Balance at Date";
                        CreditAmt := 0;
                        TotalDebitAmt := TotalDebitAmt + DebitAmt;
                      END ELSE BEGIN
                        CreditAmt := -"Balance at Date";
                        DebitAmt := 0;
                        TotalCreditAmt := TotalCreditAmt + CreditAmt;
                      END
                    ELSE
                      IF "Add.-Currency Balance at Date" > 0 THEN BEGIN
                        DebitAmt := "Add.-Currency Balance at Date";
                        CreditAmt := 0;
                        TotalDebitAmt := TotalDebitAmt + DebitAmt;
                      END ELSE BEGIN
                        CreditAmt := -"Add.-Currency Balance at Date";
                        DebitAmt := 0;
                        TotalCreditAmt := TotalCreditAmt + CreditAmt;
                      END;

                    FirstPeriodDate := 010199D;

                    TFTotalCreditAmt := TotalCreditAmt;
                    TFTotalDebitAmt := TotalDebitAmt;

                    LineID := 1;
                end;

                trigger OnPostDataItem()
                begin
                    NextAccPeriod.COPYFILTERS(AccPeriod);
                    NextAccPeriod := AccPeriod;
                    IF NextAccPeriod.NEXT = 0 THEN
                      LoopEnd := TRUE;
                end;

                trigger OnPreDataItem()
                begin
                    OpenCloseDate := AccPeriod."Starting Date";
                    OpenClosePerTransNo := 1;
                    CurrTransNo := 1;

                    // --> G/L Account, Body (2) - OnPreSection()

                    IF (((DebitAmt <> 0) OR (CreditAmt <> 0)) AND NOT (TempDate <> AccPeriod."Starting Date")
                                                              AND NOT (TempDate > ToDate)
                                                              AND NOT FirstReg AND NOT (FromPerTransNo > 1)) THEN
                      VerGLAccountOnPre := TRUE
                    ELSE
                      VerGLAccountOnPre := FALSE;

                    // <-- G/L Account, Body (2) - OnPreSection()
                end;
            }
            dataitem(DataItem1000000002;Table45)
            {
                DataItemTableView = SORTING(Posting Date,Period Trans. No.);
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Posting Date","Period Trans. No.";
                dataitem(DataItem1000000003;Table17)
                {
                    DataItemTableView = SORTING(Entry No.);
                    column(GLRegister_PeriodTransNo;"G/L Register"."Period Trans. No.")
                    {
                    }
                    column(FORMAT_GLRegister_PostingDate;FORMAT("G/L Register"."Posting Date"))
                    {
                    }
                    column(GLEntry_Description;"G/L Entry".Description)
                    {
                    }
                    column(GLEntry_DocumentType;"G/L Entry"."Document Type")
                    {
                    }
                    column(GLEntry_DocumentNo;"G/L Entry"."Document No.")
                    {
                    }
                    column(GLEntry_GLAccountNo;"G/L Entry"."G/L Account No.")
                    {
                    }
                    column(GLEntry_GLAccountName;"G/L Entry"."G/L Account Name")
                    {
                    }
                    column(DebitAmtEntry;DebitAmt)
                    {
                    }
                    column(CreditAmtEntry;CreditAmt)
                    {
                    }
                    column(GLEntry_AddCurrencyDebitAmount;"G/L Entry"."Add.-Currency Debit Amount")
                    {
                    }
                    column(GLEntry_AddCurrencyCreditAmount;"G/L Entry"."Add.-Currency Credit Amount")
                    {
                    }
                    column(VerGLEntryOnPre;VerGLEntryOnPre)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF NOT GLAccount.GET("G/L Account No.") THEN
                          GLAccount.INIT;

                        IF NOT PrintAmountsInAddCurrency THEN BEGIN
                          TotalDebitAmt := TotalDebitAmt + "Debit Amount";
                          TotalCreditAmt := TotalCreditAmt + "Credit Amount";
                        END ELSE BEGIN
                          TotalDebitAmt := TotalDebitAmt + "Add.-Currency Debit Amount";
                          TotalCreditAmt := TotalCreditAmt + "Add.-Currency Credit Amount";
                        END;

                        TFTotalCreditAmt := TotalCreditAmt + CreditAmt;
                        TFTotalDebitAmt := TotalDebitAmt + DebitAmt;

                        LineID := 2;


                        // --> G/L Entry, Body (1) - OnPreSection()
                        IF NOT (PrintAmountsInAddCurrency) THEN
                          VerGLEntryOnPre := TRUE
                        ELSE
                          VerGLEntryOnPre := FALSE;
                        // <-- G/L Entry, Body (1) - OnPreSection()
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETCURRENTKEY("Transaction No.");
                        //SETRANGE("Transaction No.","G/L Register"."Transaction No."); // en nav 2016 este campo no se llama as´Š¢
                        SETRANGE("Transaction No.","G/L Register"."No."); // nombre del campo en nav 2016
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    TESTFIELD("Period Trans. No.");
                    FirstRec := FALSE;
                    TempDate := "Posting Date";
                    IF TempDate > CLOSINGDATE(NextAccPeriod."Starting Date" - 1) THEN BEGIN
                      OldDate := "Posting Date";
                      CurrReport.BREAK;
                    END;

                    CurrTransNo := "Period Trans. No.";
                    IF FromPerTransNo <> 0 THEN
                      IF (CurrTransNo < FromPerTransNo) OR
                         (CurrTransNo > ToPerTransNo)
                      THEN
                        CurrReport.BREAK;

                    TFTotalCreditAmt := TotalCreditAmt + CreditAmt;
                    TFTotalDebitAmt := TotalDebitAmt + DebitAmt;
                    TFTotalCreditAmt1 := TFTotalCreditAmt;
                    TFTotalDebitAmt1 := TFTotalDebitAmt;
                    LineID := 4;
                end;

                trigger OnPreDataItem()
                begin
                    IF TableEnd OR LoopEnd THEN
                      CurrReport.BREAK;

                    IF NOT FirstRec THEN
                      SETFILTER("Posting Date",'>= %1 & <= %2',OldDate,ToDate);
                    IF "G/L Register".GETFILTER("Period Trans. No.") <> '' THEN
                      SETRANGE("Period Trans. No.",FromPerTransNo,ToPerTransNo);
                end;
            }
            dataitem(GLAccount2;Table15)
            {
                DataItemTableView = SORTING(No.)
                                    WHERE(Account Type=CONST(Posting));
                column(CloseTransactDescGLAccount2;CloseTransactDesc)
                {
                }
                column(GLAccount2_GlobalDimension1Code;GLAccount2."Global Dimension 1 Code")
                {
                }
                column(GLAccount2_No;GLAccount2."No.")
                {
                }
                column(GLAccount2_Name;GLAccount2.Name)
                {
                }
                column(DebitAmtGLAccount2;DebitAmt)
                {
                }
                column(CreditAmtGLAccount2;CreditAmt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SETRANGE("Date Filter",0D,CLOSINGDATE(NextAccPeriod."Starting Date" - 1));
                    CALCFIELDS("Balance at Date","Add.-Currency Balance at Date");
                    IF NOT PrintAmountsInAddCurrency THEN
                      IF "Balance at Date" < 0 THEN BEGIN
                        DebitAmt := -"Balance at Date";
                        CreditAmt := 0;
                      END ELSE BEGIN
                        CreditAmt := "Balance at Date";
                        DebitAmt := 0;
                      END
                    ELSE
                      IF "Add.-Currency Balance at Date" < 0 THEN BEGIN
                        DebitAmt := -"Add.-Currency Balance at Date";
                        CreditAmt := 0;
                      END ELSE BEGIN
                        CreditAmt := "Add.-Currency Balance at Date";
                        DebitAmt := 0;
                      END;

                    TFTotalCreditAmt := TFTotalCreditAmt + CreditAmt;
                    TFTotalDebitAmt := TFTotalDebitAmt + DebitAmt;

                    LineID := 3;
                end;

                trigger OnPreDataItem()
                begin
                    IF LoopEnd THEN
                      CurrReport.BREAK;

                    IF TempDate <= CLOSINGDATE(NextAccPeriod."Starting Date" - 1) THEN
                      TableEnd := TRUE;
                    IF TableEnd AND
                      (ToDate < CLOSINGDATE(NextAccPeriod."Starting Date" - 1))
                    THEN BEGIN
                      LoopEnd := TRUE;
                      CurrReport.BREAK;
                    END;

                    OpenCloseDate := NextAccPeriod."Starting Date" - 1;
                    OpenClosePerTransNo := CurrTransNo + 1;
                    FirstReg := FALSE;

                    IF AccPeriod.NEXT = 0 THEN BEGIN
                      IF TableEnd THEN
                        LoopEnd := TRUE
                      ELSE
                        //ERROR(Text1100005,"G/L Register"."Transaction No."); // en nav 2016 este campo no se llama as´Š¢
                        ERROR(Text1100005,"G/L Register"."No."); // nombre del campo en nav 2016
                    END ELSE
                      TempDate := AccPeriod."Starting Date";

                    IF FromPerTransNo <> 0 THEN
                      IF (OpenClosePerTransNo < FromPerTransNo) OR
                         (OpenClosePerTransNo > ToPerTransNo) THEN
                        CurrReport.BREAK;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF LoopEnd THEN
                  CurrReport.BREAK;

                IF PrintAmountsInAddCurrency THEN
                  HeaderText := Text1100004 + ' ' + GLSetup."Additional Reporting Currency"
                ELSE BEGIN
                  GLSetup.TESTFIELD("LCY Code");
                  HeaderText := Text1100004 + ' ' + GLSetup."LCY Code";
                END;

                LineID := 0;
            end;

            trigger OnPreDataItem()
            begin
                GLSetup.GET;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(CloseTransactDesc;CloseTransactDesc)
                {
                    Caption = 'Texto asiento cierre';
                }
                field(OpenTransactDesc;OpenTransactDesc)
                {
                    Caption = 'Texto asiento apertura';
                }
                field(FirstPage;FirstPage)
                {
                    Caption = 'Primera p´Š¢gina';
                }
                field(PrintAmountsInAddCurrency;PrintAmountsInAddCurrency)
                {
                    Caption = 'Muestra importes en divisa adicional';
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
        FirstRec := TRUE;
        IF OpenTransactDesc = '' THEN
          OpenTransactDesc := Text1100000;
        IF CloseTransactDesc = '' THEN
          CloseTransactDesc := Text1100001;
    end;

    trigger OnPreReport()
    begin
        FirstPageNum := FirstPage;
        GLDateFilter := "G/L Register".GETFILTER("Posting Date");
        GLFilter := "G/L Register".GETFILTERS;
        FromDate := "G/L Register".GETRANGEMIN("Posting Date");
        ToDate := "G/L Register".GETRANGEMAX("Posting Date");
        InitPeriodDate := CalcPeriod(FromDate);
        AccPeriod.RESET;
        IF InitPeriodDate <> FromDate THEN BEGIN
         GLentry.SETRANGE("Posting Date",InitPeriodDate,CALCDATE(Text1100002,FromDate));
         IF GLentry.FIND('-') THEN
           REPEAT
             IF NOT PrintAmountsInAddCurrency THEN BEGIN
               TotalDebitAmt := TotalDebitAmt + GLentry."Debit Amount";
               TotalCreditAmt := TotalCreditAmt + GLentry."Credit Amount";
             END ELSE BEGIN
               TotalDebitAmt := TotalDebitAmt + GLentry."Add.-Currency Debit Amount";
               TotalCreditAmt := TotalCreditAmt + GLentry."Add.-Currency Credit Amount";
             END;
           UNTIL GLentry.NEXT = 0;
        END;
        GLentry.SETRANGE("Posting Date");
        IF "G/L Register".GETFILTER("Period Trans. No.") <> '' THEN BEGIN
          FromPerTransNo := "G/L Register".GETRANGEMIN("Period Trans. No.");
          ToPerTransNo := "G/L Register".GETRANGEMAX("Period Trans. No.");
        END;

        TempDate := FromDate;

        GLReg2.RESET;
        GLReg2.SETCURRENTKEY("Posting Date","Period Trans. No.");
        GLReg2.FIND('+');
        IF GLReg2."Posting Date" < ToDate THEN BEGIN
          AccPeriod.SETRANGE("New Fiscal Year",TRUE);
          AccPeriod.SETFILTER("Starting Date",'>=%1',GLReg2."Posting Date");
          IF NOT AccPeriod.FIND('-') THEN
            ToDate := GLReg2."Posting Date"
          ELSE
            ToDate := CLOSINGDATE(AccPeriod."Starting Date" - 1);
        END;

        AccPeriod.SETRANGE("New Fiscal Year",TRUE);
        AccPeriod.SETFILTER("Starting Date",'>= %1',FromDate);
        IF NOT AccPeriod.FIND('-') THEN
          AccPeriod."Starting Date" := 31129999D
        ELSE
          IF FromDate < AccPeriod."Starting Date" THEN BEGIN
            AccPeriod.SETRANGE("Starting Date");
            AccPeriod.NEXT(-1);
          END;

        IF FirstPage <> 0 THEN
          FirstPage := FirstPage - 1;

        GLReg2.RESET;
        GLReg2.SETCURRENTKEY("Posting Date","Period Trans. No.");
        "G/L Register".COPYFILTER("Posting Date",GLReg2."Posting Date");
        GLReg2.FIND('-');
        GLReg2.SETRANGE("Posting Date");
        IF GLReg2.NEXT(-1) = 0 THEN
          FirstReg := TRUE
        ELSE
          FirstReg := FALSE;
    end;

    var
        GLAccount: Record "15";
        AccPeriod: Record "50";
        NextAccPeriod: Record "50";
        GLReg2: Record "45";
        GLSetup: Record "98";
        GLentry: Record "17";
        GLFilter: Text[250];
        LoopEnd: Boolean;
        FirstRec: Boolean;
        TempDate: Date;
        OldDate: Date;
        FromDate: Date;
        ToDate: Date;
        FromPerTransNo: Integer;
        ToPerTransNo: Integer;
        OpenTransactDesc: Text[30];
        CloseTransactDesc: Text[30];
        DebitAmt: Decimal;
        CreditAmt: Decimal;
        TFTotalCreditAmt: Decimal;
        TFTotalDebitAmt: Decimal;
        TotalDebitAmt: Decimal;
        TotalCreditAmt: Decimal;
        OpenClosePerTransNo: Integer;
        OpenCloseDate: Date;
        TableEnd: Boolean;
        FirstPage: Integer;
        GLDateFilter: Text[250];
        FirstReg: Boolean;
        CurrTransNo: Integer;
        PrintAmountsInAddCurrency: Boolean;
        HeaderText: Text[50];
        InitPeriodDate: Date;
        FirstPeriodDate: Date;
        LineID: Integer;
        FirstPageNum: Integer;
        TFTotalCreditAmt1: Decimal;
        TFTotalDebitAmt1: Decimal;
        Text1100000: Label 'Period Opening Transaction';
        Text1100001: Label 'Period Closing Transaction';
        Text1100002: Label '-1D';
        Text1100003: Label 'Period: ';
        Text1100004: Label 'All amounts are in ';
        Text1100005: Label 'No hay m s AccPeriods y s´Š¢ registros. Trans: %1';
        Text1100006: Label 'There is not any period in this range of date';
        VerGLAccountOnPre: Boolean;
        VerGLEntryOnPre: Boolean;

    procedure CalcPeriod(InitialDate: Date): Date
    begin
        AccPeriod.SETRANGE("New Fiscal Year",TRUE);
        AccPeriod.SETFILTER("Starting Date",'<=%1',InitialDate);
        IF AccPeriod.FIND('+') THEN
          EXIT(AccPeriod."Starting Date")
        ELSE
          ERROR(Text1100006);
    end;
}

