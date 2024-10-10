report 50083 "Balance Sumas y Saldos IZERTIS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Balance Sumas y Saldos IZERTIS.rdlc';
    Caption = 'Trial Balance';

    dataset
    {
        dataitem(DataItem6710;Table15)
        {
            DataItemTableView = SORTING(No.);
            RequestFilterFields = "No.","Account Type","Date Filter","Global Dimension 1 Filter","Global Dimension 2 Filter";
            column(WorkDateFormatted;FORMAT(WORKDATE,0,4))
            {
            }
            column(PeriodText1;Text1100003 + PeriodText)
            {
            }
            column(CompanyName;COMPANYNAME)
            {
            }
            column(PeriodText;PeriodText)
            {
            }
            column(PrintToExcel;PrintToExcel)
            {
            }
            column(HeaderText;HeaderText)
            {
            }
            column(IncludeEntries;IncludeEntries)
            {
            }
            column(GLFilter_GLAccount;"G/L Account".TABLECAPTION + ': ' + "G/L Account".GETFILTERS)
            {
            }
            column(GLFilter;GLFilter)
            {
            }
            column(AcumBalance;AcumBalance)
            {
            }
            column(TotalDebitAmtAtEnd;TotalDebitAmtAtEnd)
            {
            }
            column(TotalCreditAmtAtEnd;TotalCreditAmtAtEnd)
            {
            }
            column(TotalBalanceAtEnd;TotalBalanceAtEnd)
            {
            }
            column(TotalPeriodDebitAmt;TotalPeriodDebitAmt)
            {
            }
            column(TotalPeriodCreditAmt;TotalPeriodCreditAmt)
            {
            }
            column(No1_GLAccount;"No.")
            {
            }
            column(TrialBalanceCaption;TrialBalanceCaptionLbl)
            {
            }
            column(PageCaption;PageCaptionLbl)
            {
            }
            column(AccinPeriodCaption;AccinPeriodCaptionLbl)
            {
            }
            column(AccPeriodatDateCaption;AccPeriodatDateCaptionLbl)
            {
            }
            column(AccountCaption;AccountCaptionLbl)
            {
            }
            column(NameCaption;NameCaptionLbl)
            {
            }
            column(DebitCaption;DebitCaptionLbl)
            {
            }
            column(CreditCaption;CreditCaptionLbl)
            {
            }
            column(BalanceatDateCaption;BalanceatDateCaptionLbl)
            {
            }
            column(AcumBalanceatDateCaption;AcumBalanceatDateCaptionLbl)
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            column(CompanyInfo_Picture;CompanyInfo.Picture)
            {
            }
            column(FechaCabecera;FORMAT(TODAY,0,4))
            {
            }
            column(Periodo;Text1100003 + PeriodText)
            {
            }
            dataitem(DataItem5444;Table2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=CONST(1));
                column(No_GLAccount;"G/L Account"."No.")
                {
                }
                column(IndentName_GLAccount;PADSTR('',"G/L Account".Indentation * 2)+"G/L Account".Name)
                {
                }
                column(DebitAmount_GLAccount;"G/L Account"."Debit Amount" + OpenDebitAmt + CloseDebitAmt)
                {
                }
                column(CreditAmount_GLAccount;"G/L Account"."Credit Amount" + OpenCreditAmt + CloseCreditAmt)
                {
                }
                column(DebitAmount2_GLAccount;GLAcc2."Debit Amount" + OpenDebitAmtEnd + CloseDebitAmt)
                {
                }
                column(CreditAmount2_GLAccount;GLAcc2."Credit Amount" + OpenCreditAmtEnd + CloseCreditAmt)
                {
                }
                column(BalanceType;BalanceType)
                {
                }
                column(CreditAmount3_GLAccount;GLAcc2."Add.-Currency Credit Amount" + OpenCreditAmtEnd + CloseCreditAmt)
                {
                }
                column(DebitAmount3_GLAccount;GLAcc2."Add.-Currency Debit Amount" + OpenDebitAmtEnd + CloseDebitAmt)
                {
                }
                column(CreditAmount4_GLAccount;"G/L Account"."Add.-Currency Credit Amount" + OpenCreditAmt + CloseCreditAmt)
                {
                }
                column(DebitAmount4_GLAccount;"G/L Account"."Add.-Currency Debit Amount" + OpenDebitAmt + CloseDebitAmt)
                {
                }
                column(AccountType_GLAccount;FORMAT("G/L Account"."Account Type",0,2))
                {
                }
                column(GLFilterOption;FORMAT(GLFilterOption,0,2))
                {
                }
                column(NoofBlankLines_GLAccount;"G/L Account"."No. of Blank Lines")
                {
                }
                column(PrintAmountsInAddCurrency;PrintAmountsInAddCurrency)
                {
                }
                column(PageGroupNo;PageGroupNo)
                {
                }
                column(AccountType_GLAcc;"G/L Account"."Account Type")
                {
                }
                column(SaldoInicial;OpenDebitAmt-OpenCreditAmt)
                {
                }
                column(SaldoInicial2;(GLAcc2."Debit Amount"-GLAcc2."Credit Amount"-BalanceType)*-1)
                {
                }
                dataitem(BlankLineRepeater;Table2000000026)
                {
                    column(BlankLineNo;BlankLineNo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF BlankLineNo = 0 THEN
                          CurrReport.BREAK;

                        BlankLineNo -= 1;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    BlankLineNo := "G/L Account"."No. of Blank Lines" + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Accumulate := FALSE;
                CALCFIELDS("Debit Amount","Credit Amount","Balance at Date","Add.-Currency Debit Amount",
                           "Add.-Currency Credit Amount","Add.-Currency Balance at Date", "Net Change","Balance at Date");
                GLAcc2 := "G/L Account";
                GLAcc2.SETRANGE("Date Filter",StartingPeriod(FromFec),ToFec);
                IF GlobalDim1 <> '' THEN
                  "G/L Account".COPYFILTER("G/L Account"."Global Dimension 1 Filter", GLAcc2."Global Dimension 1 Filter");
                IF GlobalDim2 <> '' THEN
                  "G/L Account".COPYFILTER("G/L Account"."Global Dimension 2 Filter", GLAcc2."Global Dimension 2 Filter");
                GLAcc2.CALCFIELDS("Additional-Currency Net Change","Net Change","Debit Amount","Credit Amount",
                                  "Add.-Currency Debit Amount","Add.-Currency Credit Amount","Balance at Date");
                IF PrintAmountsInAddCurrency THEN BEGIN
                  PreviousBalance := GLAcc2."Additional-Currency Net Change";
                  BalanceType := GLAcc2."Additional-Currency Net Change";
                  IF AcumBalance THEN
                    BalanceType := GLAcc2."Add.-Currency Balance at Date";
                END ELSE BEGIN
                  PreviousBalance := GLAcc2."Net Change";
                  BalanceType := GLAcc2."Net Change";
                  IF AcumBalance THEN
                    BalanceType := GLAcc2."Balance at Date";
                END;
                OpenCreditAmt := 0;
                OpenDebitAmt := 0;
                OpenCreditAmtEnd := 0;
                OpenDebitAmtEnd := 0;
                IF OpenEntries THEN BEGIN
                  IF "Account Type" = "Account Type"::Heading THEN
                    CalcOpenEntriesHeading
                  ELSE
                    CalcOpenEntries;
                  IF NOT AcumBalance THEN
                    BalanceType := BalanceType + OpenDebitAmtEnd - OpenCreditAmtEnd;
                END;
                CloseDebitAmt := 0;
                CloseCreditAmt := 0;
                IF CloseEntries THEN BEGIN
                  IF "Account Type" = "Account Type"::Heading THEN
                    CalcCloseEntriesHeading
                  ELSE
                    CalcCloseEntries;
                  IF NOT AcumBalance THEN
                    BalanceType := BalanceType + CloseDebitAmt - CloseCreditAmt
                  ELSE
                    BalanceType := GLAcc2."Net Change" - BalanceType;
                END;

                IF AcumBalance AND (NOT OpenEntries) AND (NOT CloseEntries) THEN
                  BalanceType := GLAcc2."Net Change";

                PreviousDebit := 0;
                PreviousCredit := 0;
                IF PreviousBalance > 0 THEN
                  PreviousDebit := PreviousBalance
                ELSE
                  PreviousCredit := ABS(PreviousBalance);
                GLAcc.SETRANGE("Date Filter",FromFec,ToFec);
                IF GlobalDim1 <> '' THEN
                  "G/L Account".COPYFILTER("G/L Account"."Global Dimension 1 Filter", GLAcc2."Global Dimension 1 Filter");
                IF GlobalDim2 <> '' THEN
                  "G/L Account".COPYFILTER("G/L Account"."Global Dimension 2 Filter", GLAcc2."Global Dimension 2 Filter");
                GLAcc.CALCFIELDS("Debit Amount","Credit Amount","Add.-Currency Debit Amount","Add.-Currency Credit Amount",
                  "Net Change","Balance at Date");
                IF NOT PrintAmountsInAddCurrency THEN BEGIN
                  PeriodDebitAmt := GLAcc."Debit Amount";
                  PeriodCreditAmt := GLAcc."Credit Amount";
                  BalanceAtEnd := BalanceAtEnd + PreviousBalance;
                  DebitAmtAtEnd := GLAcc2."Debit Amount";
                  CreditAmtAtEnd := GLAcc2."Credit Amount";
                  I := I + 1;
                  IF I = 1 THEN
                    FixedLevel := STRLEN ("No.");
                  IF (COPYSTR("No.",1,1) <> PrevAccount) AND (STRLEN("No.") >= FixedLevel) THEN BEGIN
                    Accumulate := TRUE;
                    FirstLevel := STRLEN ("No.");
                  END ELSE
                    IF (STRLEN("No.") <= PreviousLevel) AND (STRLEN("No.") <= FirstLevel) AND (STRLEN("No.") >= FixedLevel) THEN
                      Accumulate := TRUE
                    ELSE
                      Accumulate := FALSE;
                  IF Accumulate OR (GLFilterOption = GLFilterOption::Posting) THEN BEGIN
                    TotalPeriodDebitAmt := TotalPeriodDebitAmt + "Debit Amount" + CloseDebitAmt;
                    TotalPeriodCreditAmt := TotalPeriodCreditAmt + "Credit Amount" + CloseCreditAmt;
                    IF IsOpenDate THEN BEGIN
                      TotalPeriodDebitAmt := TotalPeriodDebitAmt + OpenDebitAmt;
                      TotalPeriodCreditAmt := TotalPeriodCreditAmt + OpenCreditAmt;
                    END;
                    TotalDebitAmtAtEnd := TotalDebitAmtAtEnd + DebitAmtAtEnd + OpenDebitAmtEnd + CloseDebitAmt;
                    TotalCreditAmtAtEnd := TotalCreditAmtAtEnd + CreditAmtAtEnd + OpenCreditAmtEnd + CloseCreditAmt;
                    IF OpenEntries OR CloseEntries THEN
                      TotalBalanceAtEnd := TotalBalanceAtEnd + BalanceType
                    ELSE
                      TotalBalanceAtEnd := TotalBalanceAtEnd + BalanceAtEnd ;
                  END;
                END ELSE BEGIN
                  PeriodDebitAmt := GLAcc."Add.-Currency Debit Amount";
                  PeriodCreditAmt := GLAcc."Add.-Currency Credit Amount";
                  BalanceAtEnd := BalanceAtEnd + PreviousBalance;
                  DebitAmtAtEnd := GLAcc2."Add.-Currency Debit Amount";
                  CreditAmtAtEnd := GLAcc2."Add.-Currency Credit Amount";
                  IF COPYSTR("No.",1,1) <> PrevAccount THEN BEGIN
                    Accumulate := TRUE;
                    FirstLevel := STRLEN ("No.");
                  END ELSE
                    IF (STRLEN("No.") <= PreviousLevel) AND (STRLEN("No.") <= FirstLevel) THEN
                      Accumulate := TRUE
                    ELSE
                      Accumulate := FALSE;
                  IF Accumulate OR (GLFilterOption = GLFilterOption::Posting) THEN BEGIN
                    TotalPeriodDebitAmt := TotalPeriodDebitAmt + "Add.-Currency Debit Amount" + CloseDebitAmt;
                    TotalPeriodCreditAmt := TotalPeriodCreditAmt + "Add.-Currency Credit Amount" + CloseCreditAmt;
                    IF IsOpenDate THEN BEGIN
                      TotalPeriodDebitAmt := TotalPeriodDebitAmt + OpenDebitAmt;
                      TotalPeriodCreditAmt := TotalPeriodCreditAmt + OpenCreditAmt;
                    END;
                    TotalDebitAmtAtEnd := TotalDebitAmtAtEnd + DebitAmtAtEnd + OpenDebitAmtEnd + CloseDebitAmt;
                    TotalCreditAmtAtEnd := TotalCreditAmtAtEnd + CreditAmtAtEnd + OpenCreditAmtEnd + CloseCreditAmt;
                    IF OpenEntries OR CloseEntries THEN
                      TotalBalanceAtEnd := TotalBalanceAtEnd + BalanceType
                    ELSE
                      TotalBalanceAtEnd := TotalBalanceAtEnd + BalanceAtEnd;
                  END;
                END;

                IF (STRLEN("No.") >= FixedLevel) THEN BEGIN
                  PreviousLevel := STRLEN("No.");
                  PrevAccount := COPYSTR("No.",1,1);
                END;

                IF PrintAllHavingBal AND ("Balance at Date" = 0) AND ("Debit Amount" = 0) AND ("Credit Amount" = 0) THEN
                  CurrReport.SKIP;

                IF PrintToExcel THEN
                  MakeExcelDataBody;

                IF GlobalNo < 1 THEN BEGIN
                  GLSetup.GET;
                  IF PrintAmountsInAddCurrency THEN
                    HeaderText := STRSUBSTNO(Text1100004,GLSetup."Additional Reporting Currency")
                  ELSE BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    HeaderText := STRSUBSTNO(Text1100004,GLSetup."LCY Code");
                  END;
                  IF OpenEntries AND NOT CloseEntries THEN
                    IncludeEntries := Text1100005;
                  IF CloseEntries AND NOT OpenEntries THEN
                    IncludeEntries := Text1100006;
                  IF CloseEntries AND OpenEntries THEN
                    IncludeEntries := Text1100007;
                  GlobalNo := GlobalNo +1;
                END;

                PageGroupNo := NextPageGroupNo;
                IF NOT PrintToExcel AND "New Page" THEN
                  NextPageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPostDataItem()
            begin
                "G/L Account".SETRANGE("Date Filter");
                "G/L Account".SETRANGE("Global Dimension 1 Filter");
                "G/L Account".SETRANGE("Global Dimension 2 Filter");
                /*CurrReport.SHOWOUTPUT(Cuenta.GETFILTERS = '');*/

            end;

            trigger OnPreDataItem()
            begin
                FromFec := 0D;
                IF GETFILTER("Date Filter") = '' THEN
                  ToFec := 31129999D
                ELSE BEGIN
                  FromFec := GETRANGEMIN("Date Filter");
                  ToFec := GETRANGEMAX("Date Filter");
                END;
                CurrReport.CREATETOTALS(PeriodDebitAmt,PeriodCreditAmt,DebitAmtAtEnd,CreditAmtAtEnd,BalanceAtEnd);
                GLFilter := "G/L Account".GETFILTER("G/L Account"."Account Type");
                IF GLFilter <> '' THEN BEGIN
                  // Only accept single account type filter, to display both 2 types user should leave this filter blank.
                  GLFilterOption := GETRANGEMIN("Account Type");
                  SETRANGE("Account Type",GLFilterOption);
                END ELSE
                  GLFilterOption := -1;

                IF CloseEntries THEN
                  IF ToFec <> NORMALDATE(ToFec) THEN
                    IsClosingDate(ToFec)
                  ELSE
                    ERROR(Text1100002,ToFec);
                IF OpenEntries THEN
                  IsOpenDate := IsOpeningDate(FromFec);
                I := 0;

                PageGroupNo := 1;
                NextPageGroupNo := 1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(OnlyGLAccountsWithBalanceAtDate;PrintAllHavingBal)
                    {
                        Caption = 'Only G/L accounts with Balance at Date';
                        MultiLine = true;
                    }
                    field(ShowAmountsInAddCurrency;PrintAmountsInAddCurrency)
                    {
                        Caption = 'Show Amounts in Add. Currency';
                    }
                    field(AcumBalance;AcumBalance)
                    {
                        Caption = 'Acum. Balance at date';
                    }
                    field(IncludeOpeningEntries;OpenEntries)
                    {
                        Caption = 'Include Opening Entries';
                    }
                    field(IncludeClosingEntries;CloseEntries)
                    {
                        Caption = 'Include Closing Entries';
                    }
                    field(PrintToExcel;PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PrintAllHavingBal := TRUE;
            OpenEntries :=TRUE;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    trigger OnPostReport()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.NewRow;
        MakeExcelDataFooter;
        IF PrintToExcel THEN
          CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        PeriodText := "G/L Account".GETFILTER("Date Filter");
        GlobalDim1 := "G/L Account".GETFILTER("G/L Account"."Global Dimension 1 Filter");
        GlobalDim2 := "G/L Account".GETFILTER("G/L Account"."Global Dimension 2 Filter");
        IF PrintToExcel THEN
          MakeExcelInfo;
    end;

    var
        Text000: Label 'Period: %1';
        ExcelBuf: Record "370" temporary;
        Text001: Label 'Trial Balance';
        Text002: Label 'Data';
        Text003: Label 'Debit';
        Text004: Label 'Credit';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        Text010: Label 'G/L Filter';
        Text011: Label 'Period Filter';
        Text1100002: Label 'The date %1 is not a Closing Date';
        Text1100003: Label 'Period: ';
        Text1100004: Label 'All Amounts in %1';
        Text1100005: Label 'Include Opening Entries';
        Text1100006: Label 'Include Closing Entries';
        Text1100007: Label 'Include Closing/Opening Entries';
        Text1100008: Label 'The fiscal year does not exist';
        GLSetup: Record "98";
        GLAcc: Record "15";
        GLAcc2: Record "15";
        HeaderText: Text[30];
        PeriodText: Text[30];
        PrintToExcel: Boolean;
        FromFec: Date;
        ToFec: Date;
        PrintAllHavingBal: Boolean;
        IncludeEntries: Text[40];
        GLFilter: Text[30];
        GLFilterOption: Option Posting,Heading;
        PreviousBalance: Decimal;
        PreviousDebit: Decimal;
        PreviousCredit: Decimal;
        IsOpenDate: Boolean;
        PrintAmountsInAddCurrency: Boolean;
        PeriodDebitAmt: Decimal;
        PeriodCreditAmt: Decimal;
        BalanceAtEnd: Decimal;
        DebitAmtAtEnd: Decimal;
        CreditAmtAtEnd: Decimal;
        TotalPeriodDebitAmt: Decimal;
        TotalPeriodCreditAmt: Decimal;
        TotalBalanceAtEnd: Decimal;
        TotalDebitAmtAtEnd: Decimal;
        TotalCreditAmtAtEnd: Decimal;
        BalanceType: Decimal;
        AcumBalance: Boolean;
        CloseEntries: Boolean;
        OpenEntries: Boolean;
        OpenCreditAmt: Decimal;
        OpenDebitAmt: Decimal;
        CloseCreditAmt: Decimal;
        CloseDebitAmt: Decimal;
        OpenCreditAmtEnd: Decimal;
        OpenDebitAmtEnd: Decimal;
        PreviousLevel: Integer;
        PrevAccount: Code[1];
        FirstLevel: Integer;
        Accumulate: Boolean;
        GlobalDim1: Text[30];
        GlobalDim2: Text[30];
        I: Integer;
        FixedLevel: Integer;
        Text1100009: Label 'Acc. in Period';
        Text1100010: Label 'Acc. Period at Date';
        Text1100011: Label 'Balance at Date';
        Text1100012: Label 'Total:';
        GlobalNo: Integer;
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        TrialBalanceCaptionLbl: Label 'Trial Balance';
        PageCaptionLbl: Label 'Page';
        AccinPeriodCaptionLbl: Label 'Acc. in Period';
        AccPeriodatDateCaptionLbl: Label 'Acc. Period at Date';
        AccountCaptionLbl: Label 'Account';
        NameCaptionLbl: Label 'Name';
        DebitCaptionLbl: Label 'Debit';
        CreditCaptionLbl: Label 'Credit';
        BalanceatDateCaptionLbl: Label 'Balance at Date';
        AcumBalanceatDateCaptionLbl: Label 'Acum. Balance at Date';
        TotalCaptionLbl: Label 'Total. . . . . . . . ';
        BlankLineNo: Integer;
        CompanyInfo: Record "79";

    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text001),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Trial Balance",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text010),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("No."),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("Date Filter"),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.AddColumn("G/L Account".FIELDCAPTION("No."),FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("G/L Account".FIELDCAPTION(Name),FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          FORMAT(Text1100009 + ' - ' + Text003),FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          FORMAT(Text1100009 + ' - ' + Text004),FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          FORMAT(Text1100010 + ' - ' + Text003),FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          FORMAT(Text1100010 + ' - ' + Text004),FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          FORMAT(Text1100010 + ' - ' + Text1100011),FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
    begin
        BlankFiller := PADSTR(' ',MAXSTRLEN(BlankFiller),' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(
          "G/L Account"."No.",FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
          FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        IF "G/L Account".Indentation = 0 THEN
          ExcelBuf.AddColumn(
            "G/L Account".Name,FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
            FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        ELSE
          ExcelBuf.AddColumn(
            COPYSTR(BlankFiller,1,2 * "G/L Account".Indentation) + "G/L Account".Name,
            FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);

        IF "G/L Account"."Debit Amount" + OpenDebitAmt + CloseDebitAmt +
           "G/L Account"."Credit Amount" + OpenCreditAmt + CloseCreditAmt = 0 THEN BEGIN
              ExcelBuf.AddColumn(
                '',FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
              ExcelBuf.AddColumn(
                '',FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END ELSE BEGIN
          IF "G/L Account"."Debit Amount" + OpenDebitAmt + CloseDebitAmt <> 0 THEN
            ExcelBuf.AddColumn(
              "G/L Account"."Debit Amount" + OpenDebitAmt + CloseDebitAmt,FALSE,'',
              "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number)
          ELSE
            ExcelBuf.AddColumn(
              '',FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          IF "G/L Account"."Credit Amount" + OpenCreditAmt + CloseCreditAmt <> 0 THEN
            ExcelBuf.AddColumn(
              "G/L Account"."Credit Amount" + OpenCreditAmt + CloseCreditAmt,FALSE,'',
              "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number)
            ELSE
              ExcelBuf.AddColumn(
                '',FALSE,'',"G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;

        IF GLAcc2."Debit Amount" + OpenDebitAmtEnd + CloseDebitAmt +
           GLAcc2."Credit Amount" + OpenCreditAmtEnd + CloseCreditAmt = 0 THEN BEGIN

          ExcelBuf.AddColumn(
            '',FALSE,'',GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn(
            '',FALSE,'',GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          ExcelBuf.AddColumn(
            '',FALSE,'',GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text)
        END ELSE BEGIN
          IF GLAcc2."Debit Amount" + OpenDebitAmtEnd + CloseDebitAmt <> 0 THEN
            ExcelBuf.AddColumn(
              GLAcc2."Debit Amount" + OpenDebitAmtEnd + CloseDebitAmt,FALSE,'',
              GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number)
          ELSE
            ExcelBuf.AddColumn(
              '',FALSE,'',GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          IF GLAcc2."Credit Amount" + OpenCreditAmtEnd + CloseCreditAmt <> 0 THEN
            ExcelBuf.AddColumn(
              GLAcc2."Credit Amount" + OpenCreditAmtEnd + CloseCreditAmt,FALSE,'',
              GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number)
          ELSE
            ExcelBuf.AddColumn(
              '',FALSE,'',GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
          IF ABS(BalanceType) <> 0 THEN
            ExcelBuf.AddColumn(
              BalanceType,FALSE,'',GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting,FALSE,FALSE,'#,##0.00',ExcelBuf."Cell Type"::Number)
          ELSE
            ExcelBuf.AddColumn(
              '',FALSE,'',GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        END;
    end;

    procedure CreateExcelbook()
    begin
        ExcelBuf.CreateBookAndOpenExcel(Text002,Text001,COMPANYNAME,COMPANYNAME,USERID);
        ERROR('');
    end;

    procedure StartingPeriod(Date: Date): Date
    var
        AccPeriod: Record "50";
    begin
        AccPeriod.SETRANGE("New Fiscal Year",TRUE);
        AccPeriod.SETFILTER("Starting Date",'<= %1',Date);
        IF AccPeriod.FIND('+') THEN
          EXIT(AccPeriod."Starting Date")
        ELSE
          ERROR(Text1100008);
    end;

    procedure IsOpeningDate(Date: Date): Boolean
    var
        AccPeriod5: Record "50";
    begin
        AccPeriod5.SETRANGE(AccPeriod5."New Fiscal Year",TRUE);
        AccPeriod5.SETRANGE(AccPeriod5."Starting Date",Date);
        IF AccPeriod5.FIND('-') THEN
          EXIT(TRUE)
        ELSE
          EXIT(FALSE);
    end;

    procedure IsClosingDate(ToFec: Date)
    var
        AccPeriod2: Record "50";
    begin
        AccPeriod2.SETRANGE(AccPeriod2."New Fiscal Year",TRUE);
        IF AccPeriod2.GET(NORMALDATE(ToFec) + 1) THEN
          EXIT
        ELSE
          ERROR(Text1100002,ToFec);
    end;

    procedure CalcOpenEntries()
    var
        GlAccount3: Record "15";
        AccPeriod3: Record "50";
    begin
        AccPeriod3.SETRANGE(AccPeriod3."New Fiscal Year",TRUE);
        AccPeriod3.SETFILTER(AccPeriod3."Starting Date",'<= %1',FromFec);
        IF AccPeriod3.FIND('+') THEN BEGIN
          GlAccount3.GET("G/L Account"."No.");
          GlAccount3.SETRANGE(GlAccount3."Date Filter",0D,CLOSINGDATE((AccPeriod3."Starting Date" - 1)));
          IF GlobalDim1 <> '' THEN
            GlAccount3.SETFILTER("Global Dimension 1 Filter",GlobalDim1);
          IF GlobalDim2 <> '' THEN
            GlAccount3.SETFILTER("Global Dimension 2 Filter",GlobalDim2);
          GlAccount3.CALCFIELDS("Additional-Currency Net Change","Net Change");
          IF PrintAmountsInAddCurrency THEN BEGIN
            IF GlAccount3."Additional-Currency Net Change" > 0 THEN
              OpenDebitAmtEnd := GlAccount3."Additional-Currency Net Change"
            ELSE
              OpenCreditAmtEnd := ABS(GlAccount3."Additional-Currency Net Change");
          END ELSE BEGIN
            IF GlAccount3."Net Change" > 0 THEN
              OpenDebitAmtEnd := GlAccount3."Net Change"
            ELSE
              OpenCreditAmtEnd := ABS(GlAccount3."Net Change");
          END;
          IF IsOpenDate THEN BEGIN
            OpenDebitAmt := OpenDebitAmtEnd;
            OpenCreditAmt := OpenCreditAmtEnd;
          END;
        END;
    end;

    procedure CalcCloseEntries()
    var
        GlAccount4: Record "15";
        AccPeriod4: Record "50";
    begin
        AccPeriod4.SETRANGE(AccPeriod4."New Fiscal Year",TRUE);
        AccPeriod4.GET((NORMALDATE(ToFec) + 1));
        GlAccount4.GET("G/L Account"."No.");
        GlAccount4.SETRANGE(GlAccount4."Date Filter",0D,ToFec);
        IF GlobalDim1 <> '' THEN
          GlAccount4.SETFILTER("Global Dimension 1 Filter",GlobalDim1);
        IF GlobalDim2 <> '' THEN
          GlAccount4.SETFILTER("Global Dimension 2 Filter",GlobalDim2);
        GlAccount4.CALCFIELDS("Additional-Currency Net Change","Net Change");
        IF PrintAmountsInAddCurrency THEN BEGIN
          IF GlAccount4."Additional-Currency Net Change" > 0 THEN
            CloseCreditAmt := ABS(GlAccount4."Additional-Currency Net Change")
          ELSE
            CloseDebitAmt := ABS(GlAccount4."Additional-Currency Net Change");
        END ELSE BEGIN
          IF GlAccount4."Net Change" > 0 THEN
            CloseCreditAmt := ABS(GlAccount4."Net Change")
          ELSE
            CloseDebitAmt := ABS(GlAccount4."Net Change");
        END;
    end;

    procedure CalcCloseEntriesHeading()
    var
        GLAcc: Record "15";
        long: Integer;
    begin
        GLAcc.SETRANGE("Date Filter",0D,ToFec);
        GLAcc.SETFILTER("No.","G/L Account".Totaling);
        GLAcc.SETRANGE("Account Type",GLAcc."Account Type"::Posting);
        IF GlobalDim1 <> '' THEN
          GLAcc.SETFILTER("Global Dimension 1 Filter",GlobalDim1);
        IF GlobalDim2 <> '' THEN
          GLAcc.SETFILTER("Global Dimension 2 Filter",GlobalDim2);

        IF GLAcc.FIND('-') THEN BEGIN
          REPEAT
            GLAcc.CALCFIELDS("Additional-Currency Net Change","Net Change");
              IF PrintAmountsInAddCurrency THEN BEGIN
                IF GLAcc."Additional-Currency Net Change" > 0 THEN
                  CloseCreditAmt := CloseCreditAmt + ABS(GLAcc."Additional-Currency Net Change")
                ELSE
                  CloseDebitAmt := CloseDebitAmt + ABS(GLAcc."Additional-Currency Net Change");
              END ELSE BEGIN
                IF GLAcc."Net Change" > 0 THEN
                  CloseCreditAmt := CloseCreditAmt + ABS(GLAcc."Net Change")
                ELSE
                  CloseDebitAmt := CloseDebitAmt + ABS(GLAcc."Net Change");
              END;
          UNTIL GLAcc.NEXT = 0;
        END;
    end;

    procedure CalcOpenEntriesHeading()
    var
        GLAcc: Record "15";
        long: Integer;
        AccPeriod3: Record "50";
    begin
        AccPeriod3.SETRANGE(AccPeriod3."New Fiscal Year",TRUE);
        AccPeriod3.SETFILTER(AccPeriod3."Starting Date",'<= %1',FromFec);
        IF AccPeriod3.FIND('+') THEN BEGIN
          GLAcc.SETRANGE("Date Filter",0D,CLOSINGDATE((AccPeriod3."Starting Date" - 1)));
          GLAcc.SETFILTER("No.","G/L Account".Totaling);
          GLAcc.SETRANGE("Account Type",GLAcc."Account Type"::Posting);
          IF GlobalDim1 <> '' THEN
            GLAcc.SETFILTER("Global Dimension 1 Filter",GlobalDim1);
          IF GlobalDim2 <> '' THEN
            GLAcc.SETFILTER("Global Dimension 2 Filter",GlobalDim2);
          IF GLAcc.FIND ('-') THEN BEGIN
            REPEAT
              GLAcc.CALCFIELDS("Additional-Currency Net Change","Net Change");
                  IF PrintAmountsInAddCurrency THEN BEGIN
                    IF GLAcc."Additional-Currency Net Change" > 0 THEN
                      OpenDebitAmtEnd := OpenDebitAmtEnd + ABS(GLAcc."Additional-Currency Net Change")
                    ELSE
                      OpenCreditAmtEnd := OpenCreditAmtEnd + ABS(GLAcc."Additional-Currency Net Change");
                  END ELSE BEGIN
                    IF GLAcc."Net Change" > 0 THEN
                      OpenDebitAmtEnd := OpenDebitAmtEnd + ABS(GLAcc."Net Change")
                    ELSE
                      OpenCreditAmtEnd := OpenCreditAmtEnd + ABS(GLAcc."Net Change");
                  END;
            UNTIL GLAcc.NEXT = 0;
          END;
          IF IsOpenDate THEN BEGIN
              OpenDebitAmt := OpenDebitAmtEnd;
              OpenCreditAmt := OpenCreditAmtEnd;
          END;
        END;
    end;

    local procedure MakeExcelDataFooter()
    begin
        ExcelBuf.AddColumn('',FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(FORMAT(Text1100012),FALSE,'',TRUE,FALSE,TRUE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          TotalPeriodDebitAmt,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(
          TotalPeriodCreditAmt,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(
          TotalDebitAmtAtEnd,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(
          TotalCreditAmtAtEnd,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(
          TotalBalanceAtEnd,FALSE,'',TRUE,FALSE,TRUE,'#,##0.00',ExcelBuf."Cell Type"::Number);
    end;
}

