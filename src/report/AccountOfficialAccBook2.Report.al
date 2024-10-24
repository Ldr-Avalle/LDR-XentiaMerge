report 50065 "Account - Official Acc. Book2"
{
    ApplicationArea = All;
    Caption = 'Account - Official Acc. Book2';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Account - Official Acc. Book2.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number);
            dataitem("G/L Account"; "G/L Account")
            {
                DataItemTableView = sorting("No.") where("Account Type" = const(Posting));
                column(NormalDate_OpenCloseDate; Format(NormalDate(OpenCloseDate)))
                {
                }
                column(OpenTransactDesc; OpenTransactDesc)
                {
                }
                column(GLAccount_GlobalDimension2Code; "G/L Account"."Global Dimension 2 Code")
                {
                }
                column(GLAccount_No; "G/L Account"."No.")
                {
                }
                column(GLAccount_Name; "G/L Account".Name)
                {
                }
                column(DebitAmt; DebitAmt)
                {
                }
                column(CreditAmt; CreditAmt)
                {
                }
                column(V1; 1)
                {
                }
                column(VerGLAccountOnPre; VerGLAccountOnPre)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SetRange("Date Filter", 0D, ClosingDate(AccPeriod."Starting Date" - 1));
                    CalcFields("Balance at Date", "Add.-Currency Balance at Date");
                    if not PrintAmountsInAddCurrency then
                        if "Balance at Date" > 0 then begin
                            DebitAmt := "Balance at Date";
                            CreditAmt := 0;
                            TotalDebitAmt := TotalDebitAmt + DebitAmt;
                        end else begin
                            CreditAmt := -"Balance at Date";
                            DebitAmt := 0;
                            TotalCreditAmt := TotalCreditAmt + CreditAmt;
                        end
                    else
                        if "Add.-Currency Balance at Date" > 0 then begin
                            DebitAmt := "Add.-Currency Balance at Date";
                            CreditAmt := 0;
                            TotalDebitAmt := TotalDebitAmt + DebitAmt;
                        end else begin
                            CreditAmt := -"Add.-Currency Balance at Date";
                            DebitAmt := 0;
                            TotalCreditAmt := TotalCreditAmt + CreditAmt;
                        end;

                    FirstPeriodDate := 99990101D;

                    TFTotalCreditAmt := TotalCreditAmt;
                    TFTotalDebitAmt := TotalDebitAmt;

                    LineID := 1;
                end;

                trigger OnPostDataItem()
                begin
                    NextAccPeriod.CopyFilters(AccPeriod);
                    NextAccPeriod := AccPeriod;
                    if NextAccPeriod.Next() = 0 then
                        LoopEnd := true;
                end;

                trigger OnPreDataItem()
                begin
                    OpenCloseDate := AccPeriod."Starting Date";
                    OpenClosePerTransNo := 1;
                    CurrTransNo := 1;

                    if (((DebitAmt <> 0) or (CreditAmt <> 0)) and not (TempDate <> AccPeriod."Starting Date")
                                                              and not (TempDate > ToDate)
                                                              and not FirstReg and not (FromPerTransNo > 1)) then
                        VerGLAccountOnPre := true
                    else
                        VerGLAccountOnPre := false;
                end;
            }
            dataitem("G/L Register"; "G/L Register")
            {
                DataItemTableView = sorting("Posting Date");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Posting Date";
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemTableView = sorting("Entry No.");
                    column(FORMAT_GLRegister_PostingDate; Format("G/L Register"."Posting Date"))
                    {
                    }
                    column(GLEntry_Description; "G/L Entry".Description)
                    {
                    }
                    column(GLEntry_DocumentType; "G/L Entry"."Document Type")
                    {
                    }
                    column(GLEntry_DocumentNo; "G/L Entry"."Document No.")
                    {
                    }
                    column(GLEntry_GLAccountNo; "G/L Entry"."G/L Account No.")
                    {
                    }
                    column(GLEntry_GLAccountName; "G/L Entry"."G/L Account Name")
                    {
                    }
                    column(DebitAmtEntry; DebitAmt)
                    {
                    }
                    column(CreditAmtEntry; CreditAmt)
                    {
                    }
                    column(GLEntry_AddCurrencyDebitAmount; "G/L Entry"."Add.-Currency Debit Amount")
                    {
                    }
                    column(GLEntry_AddCurrencyCreditAmount; "G/L Entry"."Add.-Currency Credit Amount")
                    {
                    }
                    column(VerGLEntryOnPre; VerGLEntryOnPre)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if not GLAccount.Get("G/L Account No.") then
                            GLAccount.Init();

                        if not PrintAmountsInAddCurrency then begin
                            TotalDebitAmt := TotalDebitAmt + "Debit Amount";
                            TotalCreditAmt := TotalCreditAmt + "Credit Amount";
                        end else begin
                            TotalDebitAmt := TotalDebitAmt + "Add.-Currency Debit Amount";
                            TotalCreditAmt := TotalCreditAmt + "Add.-Currency Credit Amount";
                        end;

                        TFTotalCreditAmt := TotalCreditAmt + CreditAmt;
                        TFTotalDebitAmt := TotalDebitAmt + DebitAmt;

                        LineID := 2;

                        if not (PrintAmountsInAddCurrency) then
                            VerGLEntryOnPre := true
                        else
                            VerGLEntryOnPre := false;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetCurrentKey("Transaction No.");
                        SetRange("Transaction No.", "G/L Register"."No.");
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    FirstRec := false;
                    TempDate := "Posting Date";
                    if TempDate > ClosingDate(NextAccPeriod."Starting Date" - 1) then begin
                        OldDate := "Posting Date";
                        CurrReport.Break();
                    end;

                    if FromPerTransNo <> 0 then
                        if (CurrTransNo < FromPerTransNo) or
                           (CurrTransNo > ToPerTransNo)
                        then
                            CurrReport.Break();

                    TFTotalCreditAmt := TotalCreditAmt + CreditAmt;
                    TFTotalDebitAmt := TotalDebitAmt + DebitAmt;
                    TFTotalCreditAmt1 := TFTotalCreditAmt;
                    TFTotalDebitAmt1 := TFTotalDebitAmt;
                    LineID := 4;
                end;

                trigger OnPreDataItem()
                begin
                    if TableEnd or LoopEnd then
                        CurrReport.Break();

                    if not FirstRec then
                        SetFilter("Posting Date", '>= %1 & <= %2', OldDate, ToDate);

                end;
            }
            dataitem(GLAccount2; "G/L Account")
            {
                DataItemTableView = sorting("No.")
                                    where("Account Type" = const(Posting));
                column(CloseTransactDescGLAccount2; CloseTransactDesc)
                {
                }
                column(GLAccount2_GlobalDimension1Code; GLAccount2."Global Dimension 1 Code")
                {
                }
                column(GLAccount2_No; GLAccount2."No.")
                {
                }
                column(GLAccount2_Name; GLAccount2.Name)
                {
                }
                column(DebitAmtGLAccount2; DebitAmt)
                {
                }
                column(CreditAmtGLAccount2; CreditAmt)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SetRange("Date Filter", 0D, ClosingDate(NextAccPeriod."Starting Date" - 1));
                    CalcFields("Balance at Date", "Add.-Currency Balance at Date");
                    if not PrintAmountsInAddCurrency then
                        if "Balance at Date" < 0 then begin
                            DebitAmt := -"Balance at Date";
                            CreditAmt := 0;
                        end else begin
                            CreditAmt := "Balance at Date";
                            DebitAmt := 0;
                        end
                    else
                        if "Add.-Currency Balance at Date" < 0 then begin
                            DebitAmt := -"Add.-Currency Balance at Date";
                            CreditAmt := 0;
                        end else begin
                            CreditAmt := "Add.-Currency Balance at Date";
                            DebitAmt := 0;
                        end;

                    TFTotalCreditAmt := TFTotalCreditAmt + CreditAmt;
                    TFTotalDebitAmt := TFTotalDebitAmt + DebitAmt;

                    LineID := 3;
                end;

                trigger OnPreDataItem()
                begin
                    if LoopEnd then
                        CurrReport.Break();

                    if TempDate <= ClosingDate(NextAccPeriod."Starting Date" - 1) then
                        TableEnd := true;
                    if TableEnd and
                      (ToDate < ClosingDate(NextAccPeriod."Starting Date" - 1))
                    then begin
                        LoopEnd := true;
                        CurrReport.Break();
                    end;

                    OpenCloseDate := NextAccPeriod."Starting Date" - 1;
                    OpenClosePerTransNo := CurrTransNo + 1;
                    FirstReg := false;

                    if AccPeriod.Next() = 0 then begin
                        if TableEnd then
                            LoopEnd := true
                        else
                            Error(Text1100005, "G/L Register"."No.");
                        TempDate := AccPeriod."Starting Date";

                        if FromPerTransNo <> 0 then
                            if (OpenClosePerTransNo < FromPerTransNo) or
                               (OpenClosePerTransNo > ToPerTransNo) then
                                CurrReport.Break();
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if LoopEnd then
                    CurrReport.Break();

                if PrintAmountsInAddCurrency then
                    HeaderText := Text1100004 + ' ' + GLSetup."Additional Reporting Currency"
                else begin
                    GLSetup.TestField("LCY Code");
                    HeaderText := Text1100004 + ' ' + GLSetup."LCY Code";
                end;

                LineID := 0;
            end;

            trigger OnPreDataItem()
            begin
                GLSetup.Get();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(CloseTransactDesc; CloseTransactDesc)
                {
                    Caption = 'Texto asiento cierre';
                }
                field(OpenTransactDesc; OpenTransactDesc)
                {
                    Caption = 'Texto asiento apertura';
                }
                field(FirstPage; FirstPage)
                {
                    Caption = 'Primera página';
                }
                field(PrintAmountsInAddCurrency; PrintAmountsInAddCurrency)
                {
                    Caption = 'Muestra importes en divisa adicional';
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        FirstRec := true;
        if OpenTransactDesc = '' then
            OpenTransactDesc := Text1100000;
        if CloseTransactDesc = '' then
            CloseTransactDesc := Text1100001;
    end;

    trigger OnPreReport()
    begin
        FirstPageNum := FirstPage;
        GLDateFilter := "G/L Register".GetFilter("Posting Date");
        GLFilter := "G/L Register".GetFilters;
        FromDate := "G/L Register".GetRangeMin("Posting Date");
        ToDate := "G/L Register".GetRangeMax("Posting Date");
        InitPeriodDate := CalcPeriod(FromDate);
        AccPeriod.Reset();
        if InitPeriodDate <> FromDate then begin
            GLentry.SetRange("Posting Date", InitPeriodDate, CalcDate(Text1100002, FromDate));
            if GLentry.Find('-') then
                repeat
                    if not PrintAmountsInAddCurrency then begin
                        TotalDebitAmt := TotalDebitAmt + GLentry."Debit Amount";
                        TotalCreditAmt := TotalCreditAmt + GLentry."Credit Amount";
                    end else begin
                        TotalDebitAmt := TotalDebitAmt + GLentry."Add.-Currency Debit Amount";
                        TotalCreditAmt := TotalCreditAmt + GLentry."Add.-Currency Credit Amount";
                    end;
                until GLentry.Next() = 0;
        end;
        GLentry.SetRange("Posting Date");

        TempDate := FromDate;

        GLReg2.Reset();
        GLReg2.Find('+');
        if GLReg2."Posting Date" < ToDate then begin
            AccPeriod.SetRange("New Fiscal Year", true);
            AccPeriod.SetFilter("Starting Date", '>=%1', GLReg2."Posting Date");
            if not AccPeriod.Find('-') then
                ToDate := GLReg2."Posting Date"
            else
                ToDate := ClosingDate(AccPeriod."Starting Date" - 1);
        end;

        AccPeriod.SetRange("New Fiscal Year", true);
        AccPeriod.SetFilter("Starting Date", '>= %1', FromDate);
        if not AccPeriod.Find('-') then
            AccPeriod."Starting Date" := 99991231D
        else
            if FromDate < AccPeriod."Starting Date" then begin
                AccPeriod.SetRange("Starting Date");
                AccPeriod.Next(-1);
            end;

        if FirstPage <> 0 then
            FirstPage := FirstPage - 1;

        GLReg2.Reset();
        "G/L Register".CopyFilter("Posting Date", GLReg2."Posting Date");
        GLReg2.Find('-');
        GLReg2.SetRange("Posting Date");
        if GLReg2.Next(-1) = 0 then
            FirstReg := true
        else
            FirstReg := false;
    end;

    var
        GLAccount: Record "G/L Account";
        AccPeriod: Record "Accounting Period";
        NextAccPeriod: Record "Accounting Period";
        GLReg2: Record "G/L Register";
        GLSetup: Record "General Ledger Setup";
        GLentry: Record "G/L Entry";
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
        AccPeriod.SetRange("New Fiscal Year", true);
        AccPeriod.SetFilter("Starting Date", '<=%1', InitialDate);
        if AccPeriod.Find('+') then
            exit(AccPeriod."Starting Date")
        else
            Error(Text1100006);
    end;
}