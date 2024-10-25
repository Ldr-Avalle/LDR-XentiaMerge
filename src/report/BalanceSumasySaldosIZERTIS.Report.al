report 50083 "Balance Sumas y Saldos IZERTIS"
{
    ApplicationArea = All;
    Caption = 'Trial Balance', Comment = 'ESP="Balance sumas y saldos"';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Balance Sumas y Saldos IZERTIS.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(WorkDateFormatted; Format(WorkDate(), 0, 4))
            {
            }
            column(PeriodText1; Text1100003 + PeriodText)
            {
            }
            column(CompanyName; CompanyName)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(PrintToExcel; PrintToExcel)
            {
            }
            column(HeaderText; HeaderText)
            {
            }
            column(IncludeEntries; IncludeEntries)
            {
            }
            column(GLFilter_GLAccount; "G/L Account".TableCaption + ': ' + "G/L Account".GetFilters)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(AcumBalance; AcumBalance)
            {
            }
            column(TotalDebitAmtAtEnd; TotalDebitAmtAtEnd)
            {
            }
            column(TotalCreditAmtAtEnd; TotalCreditAmtAtEnd)
            {
            }
            column(TotalBalanceAtEnd; TotalBalanceAtEnd)
            {
            }
            column(TotalPeriodDebitAmt; TotalPeriodDebitAmt)
            {
            }
            column(TotalPeriodCreditAmt; TotalPeriodCreditAmt)
            {
            }
            column(No1_GLAccount; "No.")
            {
            }
            column(TrialBalanceCaption; TrialBalanceCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(AccinPeriodCaption; AccinPeriodCaptionLbl)
            {
            }
            column(AccPeriodatDateCaption; AccPeriodatDateCaptionLbl)
            {
            }
            column(AccountCaption; AccountCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(BalanceatDateCaption; BalanceatDateCaptionLbl)
            {
            }
            column(AcumBalanceatDateCaption; AcumBalanceatDateCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(FechaCabecera; Format(Today, 0, 4))
            {
            }
            column(Periodo; Text1100003 + PeriodText)
            {
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number) where(Number = const(1));
                column(No_GLAccount; "G/L Account"."No.")
                {
                }
                column(IndentName_GLAccount; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(DebitAmount_GLAccount; "G/L Account"."Debit Amount" + OpenDebitAmt + CloseDebitAmt)
                {
                }
                column(CreditAmount_GLAccount; "G/L Account"."Credit Amount" + OpenCreditAmt + CloseCreditAmt)
                {
                }
                column(DebitAmount2_GLAccount; GLAcc2."Debit Amount" + OpenDebitAmtEnd + CloseDebitAmt)
                {
                }
                column(CreditAmount2_GLAccount; GLAcc2."Credit Amount" + OpenCreditAmtEnd + CloseCreditAmt)
                {
                }
                column(BalanceType; BalanceType)
                {
                }
                column(CreditAmount3_GLAccount; GLAcc2."Add.-Currency Credit Amount" + OpenCreditAmtEnd + CloseCreditAmt)
                {
                }
                column(DebitAmount3_GLAccount; GLAcc2."Add.-Currency Debit Amount" + OpenDebitAmtEnd + CloseDebitAmt)
                {
                }
                column(CreditAmount4_GLAccount; "G/L Account"."Add.-Currency Credit Amount" + OpenCreditAmt + CloseCreditAmt)
                {
                }
                column(DebitAmount4_GLAccount; "G/L Account"."Add.-Currency Debit Amount" + OpenDebitAmt + CloseDebitAmt)
                {
                }
                column(AccountType_GLAccount; Format("G/L Account"."Account Type", 0, 2))
                {
                }
                column(GLFilterOption; Format(GLFilterOption, 0, 2))
                {
                }
                column(NoofBlankLines_GLAccount; "G/L Account"."No. of Blank Lines")
                {
                }
                column(PrintAmountsInAddCurrency; PrintAmountsInAddCurrency)
                {
                }
                column(PageGroupNo; PageGroupNo)
                {
                }
                column(AccountType_GLAcc; "G/L Account"."Account Type")
                {
                }
                column(SaldoInicial; OpenDebitAmt - OpenCreditAmt)
                {
                }
                column(SaldoInicial2; (GLAcc2."Debit Amount" - GLAcc2."Credit Amount" - BalanceType) * -1)
                {
                }
                dataitem(BlankLineRepeater; Integer)
                {
                    column(BlankLineNo; BlankLineNo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if BlankLineNo = 0 then
                            CurrReport.Break();

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
                Accumulate := false;
                CalcFields("Debit Amount", "Credit Amount", "Balance at Date", "Add.-Currency Debit Amount",
                           "Add.-Currency Credit Amount", "Add.-Currency Balance at Date", "Net Change", "Balance at Date");
                GLAcc2 := "G/L Account";
                GLAcc2.SetRange("Date Filter", StartingPeriod(FromFec), ToFec);
                if GlobalDim1 <> '' then
                    "G/L Account".CopyFilter("G/L Account"."Global Dimension 1 Filter", GLAcc2."Global Dimension 1 Filter");
                if GlobalDim2 <> '' then
                    "G/L Account".CopyFilter("G/L Account"."Global Dimension 2 Filter", GLAcc2."Global Dimension 2 Filter");
                GLAcc2.CalcFields("Additional-Currency Net Change", "Net Change", "Debit Amount", "Credit Amount",
                                  "Add.-Currency Debit Amount", "Add.-Currency Credit Amount", "Balance at Date");
                if PrintAmountsInAddCurrency then begin
                    PreviousBalance := GLAcc2."Additional-Currency Net Change";
                    BalanceType := GLAcc2."Additional-Currency Net Change";
                    if AcumBalance then
                        BalanceType := GLAcc2."Add.-Currency Balance at Date";
                end else begin
                    PreviousBalance := GLAcc2."Net Change";
                    BalanceType := GLAcc2."Net Change";
                    if AcumBalance then
                        BalanceType := GLAcc2."Balance at Date";
                end;
                OpenCreditAmt := 0;
                OpenDebitAmt := 0;
                OpenCreditAmtEnd := 0;
                OpenDebitAmtEnd := 0;
                if OpenEntries then begin
                    if "Account Type" = "Account Type"::Heading then
                        CalcOpenEntriesHeading()
                    else
                        CalcOpenEntries();
                    if not AcumBalance then
                        BalanceType := BalanceType + OpenDebitAmtEnd - OpenCreditAmtEnd;
                end;
                CloseDebitAmt := 0;
                CloseCreditAmt := 0;
                if CloseEntries then begin
                    if "Account Type" = "Account Type"::Heading then
                        CalcCloseEntriesHeading()
                    else
                        CalcCloseEntries();
                    if not AcumBalance then
                        BalanceType := BalanceType + CloseDebitAmt - CloseCreditAmt
                    else
                        BalanceType := GLAcc2."Net Change" - BalanceType;
                end;

                if AcumBalance and (not OpenEntries) and (not CloseEntries) then
                    BalanceType := GLAcc2."Net Change";

                PreviousDebit := 0;
                PreviousCredit := 0;
                if PreviousBalance > 0 then
                    PreviousDebit := PreviousBalance
                else
                    PreviousCredit := Abs(PreviousBalance);
                GLAcc.SetRange("Date Filter", FromFec, ToFec);
                if GlobalDim1 <> '' then
                    "G/L Account".CopyFilter("G/L Account"."Global Dimension 1 Filter", GLAcc2."Global Dimension 1 Filter");
                if GlobalDim2 <> '' then
                    "G/L Account".CopyFilter("G/L Account"."Global Dimension 2 Filter", GLAcc2."Global Dimension 2 Filter");
                GLAcc.CalcFields("Debit Amount", "Credit Amount", "Add.-Currency Debit Amount", "Add.-Currency Credit Amount",
                  "Net Change", "Balance at Date");
                if not PrintAmountsInAddCurrency then begin
                    PeriodDebitAmt := GLAcc."Debit Amount";
                    PeriodCreditAmt := GLAcc."Credit Amount";
                    BalanceAtEnd := BalanceAtEnd + PreviousBalance;
                    DebitAmtAtEnd := GLAcc2."Debit Amount";
                    CreditAmtAtEnd := GLAcc2."Credit Amount";
                    I := I + 1;
                    if I = 1 then
                        FixedLevel := StrLen("No.");
                    if (CopyStr("No.", 1, 1) <> PrevAccount) and (StrLen("No.") >= FixedLevel) then begin
                        Accumulate := true;
                        FirstLevel := StrLen("No.");
                    end else
                        if (StrLen("No.") <= PreviousLevel) and (StrLen("No.") <= FirstLevel) and (StrLen("No.") >= FixedLevel) then
                            Accumulate := true
                        else
                            Accumulate := false;
                    if Accumulate or (GLFilterOption = GLFilterOption::Posting) then begin
                        TotalPeriodDebitAmt := TotalPeriodDebitAmt + "Debit Amount" + CloseDebitAmt;
                        TotalPeriodCreditAmt := TotalPeriodCreditAmt + "Credit Amount" + CloseCreditAmt;
                        if IsOpenDate then begin
                            TotalPeriodDebitAmt := TotalPeriodDebitAmt + OpenDebitAmt;
                            TotalPeriodCreditAmt := TotalPeriodCreditAmt + OpenCreditAmt;
                        end;
                        TotalDebitAmtAtEnd := TotalDebitAmtAtEnd + DebitAmtAtEnd + OpenDebitAmtEnd + CloseDebitAmt;
                        TotalCreditAmtAtEnd := TotalCreditAmtAtEnd + CreditAmtAtEnd + OpenCreditAmtEnd + CloseCreditAmt;
                        if OpenEntries or CloseEntries then
                            TotalBalanceAtEnd := TotalBalanceAtEnd + BalanceType
                        else
                            TotalBalanceAtEnd := TotalBalanceAtEnd + BalanceAtEnd;
                    end;
                end else begin
                    PeriodDebitAmt := GLAcc."Add.-Currency Debit Amount";
                    PeriodCreditAmt := GLAcc."Add.-Currency Credit Amount";
                    BalanceAtEnd := BalanceAtEnd + PreviousBalance;
                    DebitAmtAtEnd := GLAcc2."Add.-Currency Debit Amount";
                    CreditAmtAtEnd := GLAcc2."Add.-Currency Credit Amount";
                    if CopyStr("No.", 1, 1) <> PrevAccount then begin
                        Accumulate := true;
                        FirstLevel := StrLen("No.");
                    end else
                        if (StrLen("No.") <= PreviousLevel) and (StrLen("No.") <= FirstLevel) then
                            Accumulate := true
                        else
                            Accumulate := false;
                    if Accumulate or (GLFilterOption = GLFilterOption::Posting) then begin
                        TotalPeriodDebitAmt := TotalPeriodDebitAmt + "Add.-Currency Debit Amount" + CloseDebitAmt;
                        TotalPeriodCreditAmt := TotalPeriodCreditAmt + "Add.-Currency Credit Amount" + CloseCreditAmt;
                        if IsOpenDate then begin
                            TotalPeriodDebitAmt := TotalPeriodDebitAmt + OpenDebitAmt;
                            TotalPeriodCreditAmt := TotalPeriodCreditAmt + OpenCreditAmt;
                        end;
                        TotalDebitAmtAtEnd := TotalDebitAmtAtEnd + DebitAmtAtEnd + OpenDebitAmtEnd + CloseDebitAmt;
                        TotalCreditAmtAtEnd := TotalCreditAmtAtEnd + CreditAmtAtEnd + OpenCreditAmtEnd + CloseCreditAmt;
                        if OpenEntries or CloseEntries then
                            TotalBalanceAtEnd := TotalBalanceAtEnd + BalanceType
                        else
                            TotalBalanceAtEnd := TotalBalanceAtEnd + BalanceAtEnd;
                    end;
                end;

                if (StrLen("No.") >= FixedLevel) then begin
                    PreviousLevel := StrLen("No.");
                    PrevAccount := CopyStr("No.", 1, 1);
                end;

                if PrintAllHavingBal and ("Balance at Date" = 0) and ("Debit Amount" = 0) and ("Credit Amount" = 0) then
                    CurrReport.Skip();

                if PrintToExcel then
                    MakeExcelDataBody();

                if GlobalNo < 1 then begin
                    GLSetup.Get();
                    if PrintAmountsInAddCurrency then
                        HeaderText := StrSubstNo(Text1100004, GLSetup."Additional Reporting Currency")
                    else begin
                        GLSetup.TestField("LCY Code");
                        HeaderText := StrSubstNo(Text1100004, GLSetup."LCY Code");
                    end;
                    if OpenEntries and not CloseEntries then
                        IncludeEntries := Text1100005;
                    if CloseEntries and not OpenEntries then
                        IncludeEntries := Text1100006;
                    if CloseEntries and OpenEntries then
                        IncludeEntries := Text1100007;
                    GlobalNo := GlobalNo + 1;
                end;

                PageGroupNo := NextPageGroupNo;
                if not PrintToExcel and "New Page" then
                    NextPageGroupNo := PageGroupNo + 1;
            end;

            trigger OnPostDataItem()
            begin
                "G/L Account".SetRange("Date Filter");
                "G/L Account".SetRange("Global Dimension 1 Filter");
                "G/L Account".SetRange("Global Dimension 2 Filter");
            end;

            trigger OnPreDataItem()
            begin
                FromFec := 0D;
                if GetFilter("Date Filter") = '' then
                    ToFec := 99991231D
                else begin
                    FromFec := GetRangeMin("Date Filter");
                    ToFec := GetRangeMax("Date Filter");
                end;
                CurrReport.CreateTotals(PeriodDebitAmt, PeriodCreditAmt, DebitAmtAtEnd, CreditAmtAtEnd, BalanceAtEnd);
                GLFilter := "G/L Account".GetFilter("G/L Account"."Account Type");
                if GLFilter <> '' then begin
                    GLFilterOption := GetRangeMin("Account Type");
                    SetRange("Account Type", GLFilterOption);
                end else
                    GLFilterOption := -1;

                if CloseEntries then
                    if ToFec <> NormalDate(ToFec) then
                        IsClosingDate(ToFec)
                    else
                        Error(Text1100002, ToFec);
                if OpenEntries then
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
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options', Comment = 'ESP="Opciones"';
                    field(OnlyGLAccountsWithBalanceAtDate; PrintAllHavingBal)
                    {
                        Caption = 'Only G/L accounts with Balance at Date', Comment = 'ESP="Sólo cuentas con Saldo a la fecha"';
                        MultiLine = true;
                    }
                    field(ShowAmountsInAddCurrency; PrintAmountsInAddCurrency)
                    {
                        Caption = 'Show Amounts in Add. Currency', Comment = 'ESP="Muestra importes en divisa adicional"';
                    }
                    field(AcumBalanceAtDate; AcumBalance)
                    {
                        Caption = 'Acum. Balance at date', Comment = 'ESP="Saldo acum. a fecha"';
                    }
                    field(IncludeOpeningEntries; OpenEntries)
                    {
                        Caption = 'Include Opening Entries', Comment = 'ESP="Incluye movs. apertura"';
                    }
                    field(IncludeClosingEntries; CloseEntries)
                    {
                        Caption = 'Include Closing Entries', Comment = 'ESP="Incluye movs. cierre"';
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel', Comment = 'ESP="Imprimir en Excel"';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            PrintAllHavingBal := true;
            OpenEntries := true;
        end;
    }

    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    trigger OnPostReport()
    begin
        ExcelBuf.NewRow();
        ExcelBuf.NewRow();
        MakeExcelDataFooter();
        if PrintToExcel then
            CreateExcelbook();
    end;

    trigger OnPreReport()
    begin
        PeriodText := "G/L Account".GetFilter("Date Filter");
        GlobalDim1 := "G/L Account".GetFilter("G/L Account"."Global Dimension 1 Filter");
        GlobalDim2 := "G/L Account".GetFilter("G/L Account"."Global Dimension 2 Filter");
        if PrintToExcel then
            MakeExcelInfo();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        GLAcc: Record "G/L Account";
        GLAcc2: Record "G/L Account";
        CompanyInfo: Record "Company Information";
        ExcelBuf: Record "Excel Buffer" temporary;
        Text000: Label 'Period: %1', Comment = 'ESP="Periodo: %1"';
        Text001: Label 'Trial Balance', Comment = 'ESP="Balance comprobación"';
        Text002: Label 'Data', Comment = 'ESP="Datos"';
        Text003: Label 'Debit', Comment = 'ESP="Debe"';
        Text004: Label 'Credit', Comment = 'ESP="Haber"';
        Text005: Label 'Company Name', Comment = 'ESP="Nombre empresa"';
        Text006: Label 'Report No.', Comment = 'ESP="Nº informe"';
        Text007: Label 'Report Name', Comment = 'ESP="Nombre informe"';
        Text008: Label 'User ID', Comment = 'ESP="Id. usuario"';
        Text009: Label 'Date', Comment = 'ESP="Fecha"';
        Text010: Label 'G/L Filter', Comment = 'ESP="Filtro C/G"';
        Text011: Label 'Period Filter', Comment = 'ESP="Filtro periodo"';
        Text1100002: Label 'The date %1 is not a Closing Date', Comment = 'ESP="La fecha %1 no es una fecha de cierre"';
        Text1100003: Label 'Period: ', Comment = 'ESP="Periodo:"';
        Text1100004: Label 'All Amounts in %1', Comment = 'ESP="Importes en %1"';
        Text1100005: Label 'Include Opening Entries', Comment = 'ESP="Incluye movs. apertura"';
        Text1100006: Label 'Include Closing Entries', Comment = 'ESP="Incluye movs. cierre"';
        Text1100007: Label 'Include Closing/Opening Entries', Comment = 'ESP="Incluye movs. de apertura/cierre"';
        Text1100008: Label 'The fiscal year does not exist', Comment = 'ESP="No existe el ejercicio."';
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
        Text1100009: Label 'Acc. in Period', Comment = 'ESP="Acum. periodo"';
        Text1100010: Label 'Acc. Period at Date', Comment = 'ESP="Acum. periodo a fecha"';
        Text1100011: Label 'Balance at Date', Comment = 'ESP="Saldo a la fecha"';
        Text1100012: Label 'Total:', Comment = 'ESP="Total:"';
        GlobalNo: Integer;
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        TrialBalanceCaptionLbl: Label 'Trial Balance', Comment = 'ESP="Balance comprobación"';
        PageCaptionLbl: Label 'Page', Comment = 'ESP="Pág."';
        AccinPeriodCaptionLbl: Label 'Acc. in Period', Comment = 'ESP="Acum. periodo"';
        AccPeriodatDateCaptionLbl: Label 'Acc. Period at Date', Comment = 'ESP="Acum. periodo a fecha"';
        AccountCaptionLbl: Label 'Account', Comment = 'ESP="Cuenta"';
        NameCaptionLbl: Label 'Name', Comment = 'ESP="Nombre"';
        DebitCaptionLbl: Label 'Debit', Comment = 'ESP="Debe"';
        CreditCaptionLbl: Label 'Credit', Comment = 'ESP="Haber"';
        BalanceatDateCaptionLbl: Label 'Balance at Date', Comment = 'ESP="Saldo a la fecha"';
        AcumBalanceatDateCaptionLbl: Label 'Acum. Balance at Date', Comment = 'ESP="Saldo acum. a fecha"';
        TotalCaptionLbl: Label 'Total. . . . . . . . ';
        BlankLineNo: Integer;

    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet();
        ExcelBuf.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyName, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text007), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Format(Text001), false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Report::"Trial Balance", false, false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text008), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text009), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(Today, false, false, false, false, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text010), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GetFilter("No."), false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text011), false, true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GetFilter("Date Filter"), false, false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow();
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.AddColumn("G/L Account".FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("G/L Account".FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format(Text1100009 + ' - ' + Text003), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format(Text1100009 + ' - ' + Text004), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format(Text1100010 + ' - ' + Text003), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format(Text1100010 + ' - ' + Text004), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          Format(Text1100010 + ' - ' + Text1100011), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
    begin
        BlankFiller := PadStr(' ', MaxStrLen(BlankFiller), ' ');
        ExcelBuf.NewRow();
        ExcelBuf.AddColumn(
          "G/L Account"."No.", false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
          false, false, '', ExcelBuf."Cell Type"::Text);
        if "G/L Account".Indentation = 0 then
            ExcelBuf.AddColumn(
              "G/L Account".Name, false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
              false, false, '', ExcelBuf."Cell Type"::Text)
        else
            ExcelBuf.AddColumn(
              CopyStr(BlankFiller, 1, 2 * "G/L Account".Indentation) + "G/L Account".Name,
              false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text);

        if "G/L Account"."Debit Amount" + OpenDebitAmt + CloseDebitAmt +
           "G/L Account"."Credit Amount" + OpenCreditAmt + CloseCreditAmt = 0 then begin
            ExcelBuf.AddColumn(
              '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(
              '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text);
        end else begin
            if "G/L Account"."Debit Amount" + OpenDebitAmt + CloseDebitAmt <> 0 then
                ExcelBuf.AddColumn(
                  "G/L Account"."Debit Amount" + OpenDebitAmt + CloseDebitAmt, false, '',
                  "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number)
            else
                ExcelBuf.AddColumn(
                  '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text);
            if "G/L Account"."Credit Amount" + OpenCreditAmt + CloseCreditAmt <> 0 then
                ExcelBuf.AddColumn(
                  "G/L Account"."Credit Amount" + OpenCreditAmt + CloseCreditAmt, false, '',
                  "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number)
            else
                ExcelBuf.AddColumn(
                  '', false, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text);
        end;

        if GLAcc2."Debit Amount" + OpenDebitAmtEnd + CloseDebitAmt +
           GLAcc2."Credit Amount" + OpenCreditAmtEnd + CloseCreditAmt = 0 then begin

            ExcelBuf.AddColumn(
              '', false, '', GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(
              '', false, '', GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text);
            ExcelBuf.AddColumn(
              '', false, '', GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text)
        end else begin
            if GLAcc2."Debit Amount" + OpenDebitAmtEnd + CloseDebitAmt <> 0 then
                ExcelBuf.AddColumn(
                  GLAcc2."Debit Amount" + OpenDebitAmtEnd + CloseDebitAmt, false, '',
                  GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number)
            else
                ExcelBuf.AddColumn(
                  '', false, '', GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text);
            if GLAcc2."Credit Amount" + OpenCreditAmtEnd + CloseCreditAmt <> 0 then
                ExcelBuf.AddColumn(
                  GLAcc2."Credit Amount" + OpenCreditAmtEnd + CloseCreditAmt, false, '',
                  GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number)
            else
                ExcelBuf.AddColumn(
                  '', false, '', GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text);
            if Abs(BalanceType) <> 0 then
                ExcelBuf.AddColumn(
                  BalanceType, false, '', GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting, false, false, '#,##0.00', ExcelBuf."Cell Type"::Number)
            else
                ExcelBuf.AddColumn(
                  '', false, '', GLAcc2."Account Type" <> GLAcc2."Account Type"::Posting, false, false, '', ExcelBuf."Cell Type"::Text);
        end;
    end;

    procedure CreateExcelbook()
    begin
        ExcelBuf.CreateNewBook(Text002);
        Error('');
    end;

    procedure StartingPeriod(Date: Date): Date
    var
        AccPeriod: Record "Accounting Period";
    begin
        AccPeriod.SetRange("New Fiscal Year", true);
        AccPeriod.SetFilter("Starting Date", '<= %1', Date);
        if AccPeriod.Find('+') then
            exit(AccPeriod."Starting Date")
        else
            Error(Text1100008);
    end;

    procedure IsOpeningDate(Date: Date): Boolean
    var
        AccPeriod5: Record "Accounting Period";
    begin
        AccPeriod5.SetRange(AccPeriod5."New Fiscal Year", true);
        AccPeriod5.SetRange(AccPeriod5."Starting Date", Date);
        if AccPeriod5.Find('-') then
            exit(true)
        else
            exit(false);
    end;

    procedure IsClosingDate(ToFec: Date)
    var
        AccPeriod2: Record "Accounting Period";
    begin
        AccPeriod2.SetRange(AccPeriod2."New Fiscal Year", true);
        if AccPeriod2.Get(NormalDate(ToFec) + 1) then
            exit
        else
            Error(Text1100002, ToFec);
    end;

    procedure CalcOpenEntries()
    var
        GlAccount3: Record "G/L Account";
        AccPeriod3: Record "Accounting Period";
    begin
        AccPeriod3.SetRange(AccPeriod3."New Fiscal Year", true);
        AccPeriod3.SetFilter(AccPeriod3."Starting Date", '<= %1', FromFec);
        if AccPeriod3.Find('+') then begin
            GlAccount3.Get("G/L Account"."No.");
            GlAccount3.SetRange(GlAccount3."Date Filter", 0D, ClosingDate((AccPeriod3."Starting Date" - 1)));
            if GlobalDim1 <> '' then
                GlAccount3.SetFilter("Global Dimension 1 Filter", GlobalDim1);
            if GlobalDim2 <> '' then
                GlAccount3.SetFilter("Global Dimension 2 Filter", GlobalDim2);
            GlAccount3.CalcFields("Additional-Currency Net Change", "Net Change");
            if PrintAmountsInAddCurrency then begin
                if GlAccount3."Additional-Currency Net Change" > 0 then
                    OpenDebitAmtEnd := GlAccount3."Additional-Currency Net Change"
                else
                    OpenCreditAmtEnd := Abs(GlAccount3."Additional-Currency Net Change");
            end else
                if GlAccount3."Net Change" > 0 then
                    OpenDebitAmtEnd := GlAccount3."Net Change"
                else
                    OpenCreditAmtEnd := Abs(GlAccount3."Net Change");
            if IsOpenDate then begin
                OpenDebitAmt := OpenDebitAmtEnd;
                OpenCreditAmt := OpenCreditAmtEnd;
            end;
        end;
    end;

    procedure CalcCloseEntries()
    var
        GlAccount4: Record "G/L Account";
        AccPeriod4: Record "Accounting Period";
    begin
        AccPeriod4.SetRange(AccPeriod4."New Fiscal Year", true);
        AccPeriod4.Get((NormalDate(ToFec) + 1));
        GlAccount4.Get("G/L Account"."No.");
        GlAccount4.SetRange(GlAccount4."Date Filter", 0D, ToFec);
        if GlobalDim1 <> '' then
            GlAccount4.SetFilter("Global Dimension 1 Filter", GlobalDim1);
        if GlobalDim2 <> '' then
            GlAccount4.SetFilter("Global Dimension 2 Filter", GlobalDim2);
        GlAccount4.CalcFields("Additional-Currency Net Change", "Net Change");
        if PrintAmountsInAddCurrency then begin
            if GlAccount4."Additional-Currency Net Change" > 0 then
                CloseCreditAmt := Abs(GlAccount4."Additional-Currency Net Change")
            else
                CloseDebitAmt := Abs(GlAccount4."Additional-Currency Net Change");
        end else
            if GlAccount4."Net Change" > 0 then
                CloseCreditAmt := Abs(GlAccount4."Net Change")
            else
                CloseDebitAmt := Abs(GlAccount4."Net Change");
    end;

    procedure CalcCloseEntriesHeading()
    var
        GLAcc: Record "G/L Account";
        long: Integer;
    begin
        GLAcc.SetRange("Date Filter", 0D, ToFec);
        GLAcc.SetFilter("No.", "G/L Account".Totaling);
        GLAcc.SetRange("Account Type", GLAcc."Account Type"::Posting);
        if GlobalDim1 <> '' then
            GLAcc.SetFilter("Global Dimension 1 Filter", GlobalDim1);
        if GlobalDim2 <> '' then
            GLAcc.SetFilter("Global Dimension 2 Filter", GlobalDim2);

        if GLAcc.Find('-') then
            repeat
                GLAcc.CalcFields("Additional-Currency Net Change", "Net Change");
                if PrintAmountsInAddCurrency then begin
                    if GLAcc."Additional-Currency Net Change" > 0 then
                        CloseCreditAmt := CloseCreditAmt + Abs(GLAcc."Additional-Currency Net Change")
                    else
                        CloseDebitAmt := CloseDebitAmt + Abs(GLAcc."Additional-Currency Net Change");
                end else
                    if GLAcc."Net Change" > 0 then
                        CloseCreditAmt := CloseCreditAmt + Abs(GLAcc."Net Change")
                    else
                        CloseDebitAmt := CloseDebitAmt + Abs(GLAcc."Net Change");
            until GLAcc.Next() = 0;
    end;

    procedure CalcOpenEntriesHeading()
    var
        GLAcc: Record "G/L Account";
        long: Integer;
        AccPeriod3: Record "Accounting Period";
    begin
        AccPeriod3.SetRange(AccPeriod3."New Fiscal Year", true);
        AccPeriod3.SetFilter(AccPeriod3."Starting Date", '<= %1', FromFec);
        if AccPeriod3.Find('+') then begin
            GLAcc.SetRange("Date Filter", 0D, ClosingDate((AccPeriod3."Starting Date" - 1)));
            GLAcc.SetFilter("No.", "G/L Account".Totaling);
            GLAcc.SetRange("Account Type", GLAcc."Account Type"::Posting);
            if GlobalDim1 <> '' then
                GLAcc.SetFilter("Global Dimension 1 Filter", GlobalDim1);
            if GlobalDim2 <> '' then
                GLAcc.SetFilter("Global Dimension 2 Filter", GlobalDim2);
            if GLAcc.Find('-') then
                repeat
                    GLAcc.CalcFields("Additional-Currency Net Change", "Net Change");
                    if PrintAmountsInAddCurrency then begin
                        if GLAcc."Additional-Currency Net Change" > 0 then
                            OpenDebitAmtEnd := OpenDebitAmtEnd + Abs(GLAcc."Additional-Currency Net Change")
                        else
                            OpenCreditAmtEnd := OpenCreditAmtEnd + Abs(GLAcc."Additional-Currency Net Change");
                    end else
                        if GLAcc."Net Change" > 0 then
                            OpenDebitAmtEnd := OpenDebitAmtEnd + Abs(GLAcc."Net Change")
                        else
                            OpenCreditAmtEnd := OpenCreditAmtEnd + Abs(GLAcc."Net Change");
                until GLAcc.Next() = 0;
            if IsOpenDate then begin
                OpenDebitAmt := OpenDebitAmtEnd;
                OpenCreditAmt := OpenCreditAmtEnd;
            end;
        end;
    end;

    local procedure MakeExcelDataFooter()
    begin
        ExcelBuf.AddColumn('', false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Format(Text1100012), false, '', true, false, true, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
          TotalPeriodDebitAmt, false, '', true, false, true, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(
          TotalPeriodCreditAmt, false, '', true, false, true, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(
          TotalDebitAmtAtEnd, false, '', true, false, true, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(
          TotalCreditAmtAtEnd, false, '', true, false, true, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(
          TotalBalanceAtEnd, false, '', true, false, true, '#,##0.00', ExcelBuf."Cell Type"::Number);
    end;
}