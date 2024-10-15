report 50053 "Dimensions - Detail mod"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Dimensions - Detail mod.rdl';

    dataset
    {
        dataitem("Analysis View"; "Analysis View")
        {
            DataItemTableView = sorting(Code);
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(DateFilter; DateFilter)
            {
            }
            column(AnalysisView_Code; "Analysis View".Code)
            {
            }
            column(AnalysisView_Name; "Analysis View".Name)
            {
            }
            column(ViewLastUpdatedText; ViewLastUpdatedText)
            {
            }
            column(HeaderText; HeaderText)
            {
            }
            column(DimFilterText; DimFilterText)
            {
            }
            dataitem(Level1; Integer)
            {
                DataItemTableView = sorting(Number);
                dataitem(Level2; Integer)
                {
                    DataItemTableView = sorting(Number);
                    dataitem(Level3; Integer)
                    {
                        DataItemTableView = sorting(Number);
                        dataitem(Level4; Integer)
                        {
                            DataItemTableView = sorting(Number);
                            dataitem(Level5; Integer)
                            {
                                DataItemTableView = sorting(Number);

                                trigger OnAfterGetRecord()
                                begin
                                    if not PrintDetail(5) then
                                        CurrReport.Break();
                                end;

                                trigger OnPreDataItem()
                                begin
                                    if DimCode[4] = '' then
                                        CurrReport.Break();
                                    FindFirstGLEntry[5] := true;
                                end;
                            }
                            dataitem(Level4e; Integer)
                            {
                                DataItemTableView = sorting(Number)
                                                    where(Number = const(1));

                                trigger OnPostDataItem()
                                begin
                                    DebitTotal[4] := 0;
                                    CreditTotal[4] := 0;
                                end;
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if DimCode[4] <> '' then begin
                                    if not CalcLine(4) and not PrintEmptyLines then
                                        CurrReport.Skip();
                                end else
                                    if not PrintDetail(4) then
                                        CurrReport.Break();
                            end;

                            trigger OnPreDataItem()
                            begin
                                if DimCode[3] = '' then
                                    CurrReport.Break();
                                FindFirstDim[4] := true;
                                FindFirstGLEntry[4] := true;
                            end;
                        }
                        dataitem(Level3e; Integer)
                        {
                            DataItemTableView = sorting(Number)
                                                where(Number = const(1));

                            trigger OnPostDataItem()
                            begin
                                DebitTotal[3] := 0;
                                CreditTotal[3] := 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if DimCode[3] <> '' then begin
                                if not CalcLine(3) and not PrintEmptyLines then
                                    CurrReport.Skip();
                            end else
                                if not PrintDetail(3) then
                                    CurrReport.Break();
                        end;

                        trigger OnPreDataItem()
                        begin
                            if DimCode[2] = '' then
                                CurrReport.Break();
                            FindFirstDim[3] := true;
                            FindFirstGLEntry[3] := true;
                        end;
                    }
                    dataitem(Level2e; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));

                        trigger OnPostDataItem()
                        begin
                            DebitTotal[2] := 0;
                            CreditTotal[2] := 0;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if DimCode[2] <> '' then begin
                            if not CalcLine(2) and not PrintEmptyLines then
                                CurrReport.Skip();
                        end else
                            if not PrintDetail(2) then
                                CurrReport.Break();
                    end;

                    trigger OnPreDataItem()
                    begin
                        if DimCode[1] = '' then
                            CurrReport.Break();
                        FindFirstDim[2] := true;
                        FindFirstGLEntry[2] := true;
                    end;
                }
                dataitem(Level1e; Integer)
                {
                    DataItemTableView = sorting(Number)
                                        where(Number = const(1));
                    column(DimCode1; DimCode[1])
                    {
                    }
                    column(DimValCode1; DimValCode[1])
                    {
                    }
                    column(DimValName1; DimValName[1])
                    {
                    }
                    column(DebitTotal; DebitTotal[1])
                    {
                    }
                    column(CreditTotal; CreditTotal[1])
                    {
                    }
                    column(DebitTotal1MenosCreditTotal1; DebitTotal[1] - CreditTotal[1])
                    {
                    }

                    trigger OnPostDataItem()
                    begin
                        DebitTotal[1] := 0;
                        CreditTotal[1] := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if not CalcLine(1) and not PrintEmptyLines then
                        CurrReport.Skip();
                end;

                trigger OnPreDataItem()
                begin
                    if DimCode[1] = '' then
                        CurrReport.Break();
                    FindFirstDim[1] := true;
                    FindFirstGLEntry[1] := true;
                end;
            }

            trigger OnAfterGetRecord()
            var
                AccountingPeriod: Record "Accounting Period";
                i: Integer;
                StartDate: Date;
                EndDate: Date;
                ThisFilter: Text[250];
            begin
                if "Analysis View"."Last Date Updated" <> 0D then
                    ViewLastUpdatedText :=
                      StrSubstNo('%1', "Analysis View"."Last Date Updated")
                else
                    ViewLastUpdatedText := Text004;

                AnalysisViewEntry.Reset();
                AnalysisViewEntry.SetRange("Analysis View Code", "Analysis View".Code);
                AnalysisViewEntry.SetFilter("Posting Date", DateFilter);
                StartDate := AnalysisViewEntry.GetRangeMin("Posting Date");
                EndDate := AnalysisViewEntry.GetRangeMax("Posting Date");
                case "Analysis View"."Date Compression" of
                    "Analysis View"."Date Compression"::Week:
                        begin
                            StartDate := CalcDate('<CW+1D-1W>', StartDate);
                            EndDate := ClosingDate(CalcDate('<CW>', EndDate));
                        end;
                    "Analysis View"."Date Compression"::Month:
                        begin
                            StartDate := CalcDate('<CM+1D-1M>', StartDate);
                            EndDate := ClosingDate(CalcDate('<CM>', EndDate));
                        end;
                    "Analysis View"."Date Compression"::Quarter:
                        begin
                            StartDate := CalcDate('<CQ+1D-1Q>', StartDate);
                            EndDate := ClosingDate(CalcDate('<CQ>', EndDate));
                        end;
                    "Analysis View"."Date Compression"::Year:
                        begin
                            StartDate := CalcDate('<CY+1D-1Y>', StartDate);
                            EndDate := ClosingDate(CalcDate('<CY>', EndDate));
                        end;
                    "Analysis View"."Date Compression"::Period:
                        begin
                            AccountingPeriod.SetRange("Starting Date", 0D, StartDate);
                            if AccountingPeriod.Find('+') then
                                StartDate := AccountingPeriod."Starting Date";
                            AccountingPeriod.SetRange("Starting Date", EndDate, 99991231D);
                            if AccountingPeriod.Find('-') then
                                if AccountingPeriod.Next() <> 0 then
                                    EndDate := ClosingDate(AccountingPeriod."Starting Date" - 1);
                        end;
                end;
                AnalysisViewEntry.SetRange("Posting Date", StartDate, EndDate);

                AnalysisViewEntry.FilterGroup(2);
                TempSelectedDim.Reset();
                TempSelectedDim.SetCurrentKey("User ID", "Object Type", "Object ID", "Analysis View Code", Level);
                TempSelectedDim.SetFilter("Dimension Value Filter", '<>%1', '');
                DimFilterText := '';
                if TempSelectedDim.Find('-') then
                    repeat
                        ThisFilter := '';
                        if DimFilterText <> '' then
                            ThisFilter := ', ';
                        ThisFilter :=
                          ThisFilter + TempSelectedDim."Dimension Code" + ': ' + TempSelectedDim."Dimension Value Filter";
                        if StrLen(DimFilterText) + StrLen(ThisFilter) <= 250 then
                            DimFilterText := DimFilterText + ThisFilter;
                        SetAnaViewEntryFilter(
                          TempSelectedDim."Dimension Code", TempSelectedDim."Dimension Value Filter");
                    until TempSelectedDim.Next() = 0;
                AnalysisViewEntry.FilterGroup(0);

                TempSelectedDim.Reset();
                TempSelectedDim.SetCurrentKey("User ID", "Object Type", "Object ID", "Analysis View Code", Level);
                TempSelectedDim.SetFilter(Level, '<>%1', TempSelectedDim.Level::" ");
                i := 1;
                if TempSelectedDim.Find('-') then
                    repeat
                        DimCode[i] := TempSelectedDim."Dimension Code";
                        LevelFilter[i] := TempSelectedDim."Dimension Value Filter";
                        i := i + 1;
                    until (TempSelectedDim.Next() = 0) or (i > 4);

                if UseAmtsInAddCurr then
                    HeaderText := StrSubstNo(Text013, GLSetup."Additional Reporting Currency")
                else
                    if GLSetup."LCY Code" <> '' then
                        HeaderText := StrSubstNo(Text013, GLSetup."LCY Code")
                    else
                        HeaderText := '';
            end;

            trigger OnPreDataItem()
            begin
                SetRange(Code, AnalysisViewCode);
                GLSetup.Get();
                LCYCODE := GLSetup."LCY Code";
                AddRepCurrency := GLSetup."Additional Reporting Currency";
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(AnalysisViewCode; AnalysisViewCode)
                {
                    Caption = 'C´Š¢d vista an´Š¢lisis';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        AnalysisView: Record "Analysis View";
                    begin
                        //IF FORM.RUNMODAL(FORM::"Analysis View List",AnalysisView) = ACTION::LookupOK THEN BEGIN
                        if Page.RunModal(Page::"Analysis View List", AnalysisView) = Action::LookupOK then begin
                            AnalysisViewCode := AnalysisView.Code;
                            UpdateColumnDim();
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        UpdateColumnDim();
                    end;
                }
                field(ColumnDim; ColumnDim)
                {
                    Caption = 'Incluir dimensiones';

                    trigger OnAssistEdit()
                    begin
                        //DimSelectionBuf.SetDimSelectionLevel(3,REPORT::"Dimensions - Detail",AnalysisViewCode,ColumnDim); //en 2016 se pasa un par´Š¢metro m´Š¢s a esta funci´Š¢n
                        //todo: modificar codigo
                        //DimSelectionBuf.SetDimSelectionLevel(3, REPORT::"Dimensions - Detail", AnalysisViewCode, ColumnDim, GLAcc.TABLECAPTION);
                        DimSelectionBuf.SetDimSelectionLevelGLAcc(3, Report::"Dimensions - Detail", AnalysisViewCode, ColumnDim);

                    end;
                }
                field(DateFilter; DateFilter)
                {
                    Caption = 'Filtro fecha';

                    trigger OnValidate()
                    var
                        //todo: modificar codigo
                        //ApplicationManagement: Codeunit "1";
                        FilterTokens: Codeunit "Filter Tokens";
                    begin
                        //todo: modificar codigo
                        //IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
                        FilterTokens.MakeDateFilter(DateFilter);
                        TempGLAcc.SetFilter("Date Filter", DateFilter);
                        DateFilter := TempGLAcc.GetFilter("Date Filter");
                    end;
                }
                field(PrintEmptyLines; PrintEmptyLines)
                {
                    Caption = 'Imp. l´Š¢n. en blanco';
                }
                field(UseAmtsInAddCurr; UseAmtsInAddCurr)
                {
                    Caption = 'Muestra importes en div. adic.';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            GLSetup.Get();
            if GLSetup."Additional Reporting Currency" = '' then
                UseAmtsInAddCurr := false;
            UpdateColumnDim();
        end;
    }

    trigger OnPreReport()
    var
        SelectedDim: Record "Selected Dimension";
    begin
        if AnalysisViewCode = '' then
            Error(Text000);

        if DateFilter = '' then
            Error(Text001);

        DimSelectionBuf.CompareDimText(
          3, Report::"Dimensions - Detail", AnalysisViewCode, ColumnDim, Text002);

        TempSelectedDim.Reset();
        TempSelectedDim.SetFilter("Dimension Value Filter", '<>%1', '');
        TempSelectedDim.SetFilter("Dimension Code", TempGLAcc.TableCaption);
        if TempSelectedDim.Find('-') then
            GLAcc.SetFilter("No.", TempSelectedDim."Dimension Value Filter");
        GLAcc.SetRange("Account Type", GLAcc."Account Type"::Posting);
        if GLAcc.Find('-') then
            repeat
                TempGLAcc.Init();
                TempGLAcc := GLAcc;
                TempGLAcc.Insert();
            until GLAcc.Next() = 0;

        TempBusUnit.Init();
        TempBusUnit.Insert();
        TempSelectedDim.SetFilter("Dimension Code", BusUnit.TableCaption);
        if TempSelectedDim.Find('-') then
            BusUnit.SetFilter(Code, TempSelectedDim."Dimension Value Filter");
        if BusUnit.Find('-') then
            repeat
                TempBusUnit.Init();
                TempBusUnit := BusUnit;
                TempBusUnit.Insert();
            until BusUnit.Next() = 0;

        SelectedDim.GetSelectedDim(UserId, 3, Report::"Dimensions - Detail", AnalysisViewCode, TempSelectedDim);
        TempSelectedDim.Reset();
        TempSelectedDim.SetCurrentKey("User ID", "Object Type", "Object ID", "Analysis View Code", Level);
        TempSelectedDim.SetFilter(Level, '<>%1', TempSelectedDim.Level::" ");
        DimVal.SetFilter(
          "Dimension Value Type", '%1|%2', DimVal."Dimension Value Type"::Standard, DimVal."Dimension Value Type"::"Begin-Total");
        if TempSelectedDim.Find('-') then
            repeat
                TempDimVal.Init();
                TempDimVal.Code := '';
                TempDimVal."Dimension Code" := TempSelectedDim."Dimension Code";
                TempDimVal.Name := Text003;
                TempDimVal.Insert();
                DimVal.SetRange("Dimension Code", TempSelectedDim."Dimension Code");
                if TempSelectedDim."Dimension Value Filter" <> '' then
                    DimVal.SetFilter(Code, TempSelectedDim."Dimension Value Filter")
                else
                    DimVal.SetRange(Code);
                if DimVal.Find('-') then
                    repeat
                        TempDimVal.Init();
                        TempDimVal := DimVal;
                        TempDimVal.Insert();
                    until DimVal.Next() = 0;
            until TempSelectedDim.Next() = 0;
    end;

    var
        AnalysisViewEntry: Record "Analysis View Entry";
        TempSelectedDim: Record "Selected Dimension" temporary;
        GLAcc: Record "G/L Account";
        BusUnit: Record "Business Unit";
        DimVal: Record "Dimension Value";
        TempGLEntry: Record "G/L Entry" temporary;
        TempGLAcc: Record "G/L Account" temporary;
        TempBusUnit: Record "Business Unit" temporary;
        TempDimVal: Record "Dimension Value" temporary;
        DimSelectionBuf: Record "Dimension Selection Buffer";
        GLSetup: Record "General Ledger Setup";
        PrintEmptyLines: Boolean;
        UseAmtsInAddCurr: Boolean;
        ViewLastUpdatedText: Text[30];
        ColumnDim: Text[250];
        AnalysisViewCode: Code[10];
        DateFilter: Text[250];
        FindFirstDim: array[4] of Boolean;
        FindFirstGLEntry: array[5] of Boolean;
        DimCode: array[4] of Text[30];
        DimValCode: array[4] of Code[20];
        DimValName: array[4] of Text[50];
        LevelFilter: array[4] of Text[250];
        AddRepCurrency: Text[50];
        LCYCODE: Text[50];
        HeaderText: Text[100];
        DebitTotal: array[4] of Decimal;
        CreditTotal: array[4] of Decimal;
        DimFilterText: Text[250];
        Text000: Label 'Please enter an analysis view code.';
        Text001: Label 'Please enter a date filter.';
        Text002: Label 'Include Dimensions';
        Text003: Label '(no dimension value)';
        Text004: Label 'Not updated';
        Text013: Label 'All amounts are in %1.';
        Text014: Label '(no business unit)';
        Text015: Label 'All amounts are in ';
        CompanyInfo: Record "Company Information";

    local procedure CalcLine(Level: Integer): Boolean
    var
        HasEntries: Boolean;
        i: Integer;
    begin
        if Level < 4 then
            for i := Level + 1 to 4 do
                SetAnaViewEntryFilter(DimCode[i], '*');
        if Iteration(
          FindFirstDim[Level], DimCode[Level], DimValCode[Level], DimValName[Level], LevelFilter[Level])
        then begin
            SetAnaViewEntryFilter(DimCode[Level], DimValCode[Level]);
            HasEntries := AnalysisViewEntry.Find('-');
        end else
            CurrReport.Break();
        exit(HasEntries);
    end;

    procedure PrintDetail(Level: Integer): Boolean
    var
        AnalysisViewEntryToGLEntries: Codeunit AnalysisViewEntryToGLEntries;
    begin
        if FindFirstGLEntry[Level] then begin
            FindFirstGLEntry[Level] := false;
            TempGLEntry.Reset();
            TempGLEntry.DeleteAll();
            if AnalysisViewEntry.Find('-') then
                repeat
                    AnalysisViewEntryToGLEntries.GetGLEntries(AnalysisViewEntry, TempGLEntry);
                until AnalysisViewEntry.Next() = 0;
            TempGLEntry.SetCurrentKey("G/L Account No.", "Posting Date");
            TempGLEntry.SetFilter("Posting Date", DateFilter);
            if not TempGLEntry.Find('-') then
                exit(false);
        end else
            if TempGLEntry.Next() = 0 then
                exit(false);
        if Level > 1 then
            CalcTotalAmounts(Level - 1);
        exit(true);
    end;

    local procedure CalcTotalAmounts(Level: Integer)
    var
        i: Integer;
    begin
        for i := 1 to Level do begin
            if UseAmtsInAddCurr then begin
                TempGLEntry."Debit Amount" := TempGLEntry."Add.-Currency Debit Amount";
                TempGLEntry."Credit Amount" := TempGLEntry."Add.-Currency Credit Amount";
            end;
            DebitTotal[i] := DebitTotal[i] + TempGLEntry."Debit Amount";
            CreditTotal[i] := CreditTotal[i] + TempGLEntry."Credit Amount";
        end;
    end;

    local procedure UpdateColumnDim()
    var
        SelectedDim: Record "Selected Dimension";
        TempDimSelectionBuf: Record "Dimension Selection Buffer" temporary;
        AnalysisView: Record "Analysis View";
    begin
        AnalysisView.CopyAnalysisViewFilters(3, Report::"Dimensions - Detail", AnalysisViewCode);
        ColumnDim := '';
        SelectedDim.SetRange("User ID", UserId);
        SelectedDim.SetRange("Object Type", 3);
        SelectedDim.SetRange("Object ID", Report::"Dimensions - Detail");
        SelectedDim.SetRange("Analysis View Code", AnalysisViewCode);
        if SelectedDim.Find('-') then begin
            repeat
                TempDimSelectionBuf.Init();
                TempDimSelectionBuf.Code := SelectedDim."Dimension Code";
                TempDimSelectionBuf.Selected := true;
                TempDimSelectionBuf."Dimension Value Filter" := SelectedDim."Dimension Value Filter";
                TempDimSelectionBuf.Level := SelectedDim.Level;
                TempDimSelectionBuf.Insert();
            until SelectedDim.Next() = 0;
            TempDimSelectionBuf.SetDimSelection(
              3, Report::"Dimensions - Detail", AnalysisViewCode, ColumnDim, TempDimSelectionBuf);
        end;
    end;

    local procedure Iteration(var FindFirst: Boolean; IterationDimCode: Text[30]; var IterationDimValCode: Code[20]; var IterationDimValName: Text[50]; IterationFilter: Text[250]): Boolean
    var
        SearchResult: Boolean;
    begin
        case IterationDimCode of
            TempGLAcc.TableCaption:
                begin
                    TempGLAcc.Reset();
                    TempGLAcc.SetFilter("No.", IterationFilter);
                    if FindFirst then
                        SearchResult := TempGLAcc.Find('-')
                    else
                        if TempGLAcc.Get(IterationDimValCode) then
                            SearchResult := (TempGLAcc.Next() <> 0);
                    if SearchResult then begin
                        IterationDimValCode := TempGLAcc."No.";
                        IterationDimValName := TempGLAcc.Name;
                    end;
                end;
            TempBusUnit.TableCaption:
                begin
                    TempBusUnit.Reset();
                    TempBusUnit.SetFilter(Code, IterationFilter);
                    if FindFirst then
                        SearchResult := TempBusUnit.Find('-')
                    else
                        if TempBusUnit.Get(IterationDimValCode) then
                            SearchResult := (TempBusUnit.Next() <> 0);
                    if SearchResult then begin
                        IterationDimValCode := TempBusUnit.Code;
                        if TempBusUnit.Code <> '' then
                            IterationDimValName := TempBusUnit.Name
                        else
                            IterationDimValName := Text014;
                    end;
                end;
            else begin
                TempDimVal.Reset();
                TempDimVal.SetRange("Dimension Code", IterationDimCode);
                TempDimVal.SetFilter(Code, IterationFilter);
                if FindFirst then
                    SearchResult := TempDimVal.Find('-')
                else
                    if TempDimVal.Get(IterationDimCode, IterationDimValCode) then
                        SearchResult := (TempDimVal.Next() <> 0);
                if SearchResult then begin
                    IterationDimValCode := TempDimVal.Code;
                    IterationDimValName := TempDimVal.Name;
                end;
            end;
        end;
        if not SearchResult then begin
            IterationDimValCode := '';
            IterationDimValName := '';
        end;
        FindFirst := false;
        exit(SearchResult);
    end;

    local procedure SetAnaViewEntryFilter(AnalysisViewDimCode: Text[30]; AnalysisViewFilter: Text[250])
    begin
        if AnalysisViewFilter = '' then
            AnalysisViewFilter := '''''';
        case AnalysisViewDimCode of
            TempGLAcc.TableCaption:
                if AnalysisViewFilter = '*' then
                    //AnalysisViewEntry.SETRANGE("G/L Account No.") // en 2016 este campo se llama "Account No."
                    AnalysisViewEntry.SetRange("Account No.")
                else
                    //AnalysisViewEntry.SETFILTER("G/L Account No.",AnalysisViewFilter);
                    AnalysisViewEntry.SetFilter("Account No.", AnalysisViewFilter);
            TempBusUnit.TableCaption:
                if AnalysisViewFilter = '*' then
                    AnalysisViewEntry.SetRange("Business Unit Code")
                else
                    AnalysisViewEntry.SetFilter("Business Unit Code", AnalysisViewFilter);

            "Analysis View"."Dimension 1 Code":
                if AnalysisViewFilter = '*' then
                    AnalysisViewEntry.SetRange("Dimension 1 Value Code")
                else
                    AnalysisViewEntry.SetFilter("Dimension 1 Value Code", AnalysisViewFilter);

            "Analysis View"."Dimension 2 Code":
                if AnalysisViewFilter = '*' then
                    AnalysisViewEntry.SetRange("Dimension 2 Value Code")
                else
                    AnalysisViewEntry.SetFilter("Dimension 2 Value Code", AnalysisViewFilter);

            "Analysis View"."Dimension 3 Code":
                if AnalysisViewFilter = '*' then
                    AnalysisViewEntry.SetRange("Dimension 3 Value Code")
                else
                    AnalysisViewEntry.SetFilter("Dimension 3 Value Code", AnalysisViewFilter);

            "Analysis View"."Dimension 4 Code":
                if AnalysisViewFilter = '*' then
                    AnalysisViewEntry.SetRange("Dimension 4 Value Code")
                else
                    AnalysisViewEntry.SetFilter("Dimension 4 Value Code", AnalysisViewFilter);
        end;
    end;
}

