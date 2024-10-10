report 50053 "Dimensions - Detail mod"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Dimensions - Detail mod.rdl';

    dataset
    {
        dataitem("Analysis View"; "Analysis View")
        {
            DataItemTableView = SORTING(Code);
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
                DataItemTableView = SORTING(Number);
                dataitem(Level2; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    dataitem(Level3; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        dataitem(Level4; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            dataitem(Level5; Integer)
                            {
                                DataItemTableView = SORTING(Number);

                                trigger OnAfterGetRecord()
                                begin
                                    IF NOT PrintDetail(5) THEN
                                        CurrReport.BREAK;
                                end;

                                trigger OnPreDataItem()
                                begin
                                    IF DimCode[4] = '' THEN
                                        CurrReport.BREAK;
                                    FindFirstGLEntry[5] := TRUE;
                                end;
                            }
                            dataitem(Level4e; Integer)
                            {
                                DataItemTableView = SORTING(Number)
                                                    WHERE(Number = CONST(1));

                                trigger OnPostDataItem()
                                begin
                                    DebitTotal[4] := 0;
                                    CreditTotal[4] := 0;
                                end;
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF DimCode[4] <> '' THEN BEGIN
                                    IF NOT CalcLine(4) AND NOT PrintEmptyLines THEN
                                        CurrReport.SKIP;
                                END ELSE
                                    IF NOT PrintDetail(4) THEN
                                        CurrReport.BREAK;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF DimCode[3] = '' THEN
                                    CurrReport.BREAK;
                                FindFirstDim[4] := TRUE;
                                FindFirstGLEntry[4] := TRUE;
                            end;
                        }
                        dataitem(Level3e; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = CONST(1));

                            trigger OnPostDataItem()
                            begin
                                DebitTotal[3] := 0;
                                CreditTotal[3] := 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF DimCode[3] <> '' THEN BEGIN
                                IF NOT CalcLine(3) AND NOT PrintEmptyLines THEN
                                    CurrReport.SKIP;
                            END ELSE
                                IF NOT PrintDetail(3) THEN
                                    CurrReport.BREAK;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF DimCode[2] = '' THEN
                                CurrReport.BREAK;
                            FindFirstDim[3] := TRUE;
                            FindFirstGLEntry[3] := TRUE;
                        end;
                    }
                    dataitem(Level2e; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));

                        trigger OnPostDataItem()
                        begin
                            DebitTotal[2] := 0;
                            CreditTotal[2] := 0;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF DimCode[2] <> '' THEN BEGIN
                            IF NOT CalcLine(2) AND NOT PrintEmptyLines THEN
                                CurrReport.SKIP;
                        END ELSE
                            IF NOT PrintDetail(2) THEN
                                CurrReport.BREAK;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF DimCode[1] = '' THEN
                            CurrReport.BREAK;
                        FindFirstDim[2] := TRUE;
                        FindFirstGLEntry[2] := TRUE;
                    end;
                }
                dataitem(Level1e; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
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
                    IF NOT CalcLine(1) AND NOT PrintEmptyLines THEN
                        CurrReport.SKIP;
                end;

                trigger OnPreDataItem()
                begin
                    IF DimCode[1] = '' THEN
                        CurrReport.BREAK;
                    FindFirstDim[1] := TRUE;
                    FindFirstGLEntry[1] := TRUE;
                end;
            }

            trigger OnAfterGetRecord()
            var
                AccountingPeriod: Record "50";
                i: Integer;
                StartDate: Date;
                EndDate: Date;
                ThisFilter: Text[250];
            begin
                IF "Analysis View"."Last Date Updated" <> 0D THEN
                    ViewLastUpdatedText :=
                      STRSUBSTNO('%1', "Analysis View"."Last Date Updated")
                ELSE
                    ViewLastUpdatedText := Text004;

                AnalysisViewEntry.RESET;
                AnalysisViewEntry.SETRANGE("Analysis View Code", "Analysis View".Code);
                AnalysisViewEntry.SETFILTER("Posting Date", DateFilter);
                StartDate := AnalysisViewEntry.GETRANGEMIN("Posting Date");
                EndDate := AnalysisViewEntry.GETRANGEMAX("Posting Date");
                CASE "Analysis View"."Date Compression" OF
                    "Analysis View"."Date Compression"::Week:
                        BEGIN
                            StartDate := CALCDATE('<CW+1D-1W>', StartDate);
                            EndDate := CLOSINGDATE(CALCDATE('<CW>', EndDate));
                        END;
                    "Analysis View"."Date Compression"::Month:
                        BEGIN
                            StartDate := CALCDATE('<CM+1D-1M>', StartDate);
                            EndDate := CLOSINGDATE(CALCDATE('<CM>', EndDate));
                        END;
                    "Analysis View"."Date Compression"::Quarter:
                        BEGIN
                            StartDate := CALCDATE('<CQ+1D-1Q>', StartDate);
                            EndDate := CLOSINGDATE(CALCDATE('<CQ>', EndDate));
                        END;
                    "Analysis View"."Date Compression"::Year:
                        BEGIN
                            StartDate := CALCDATE('<CY+1D-1Y>', StartDate);
                            EndDate := CLOSINGDATE(CALCDATE('<CY>', EndDate));
                        END;
                    "Analysis View"."Date Compression"::Period:
                        BEGIN
                            AccountingPeriod.SETRANGE("Starting Date", 0D, StartDate);
                            IF AccountingPeriod.FIND('+') THEN
                                StartDate := AccountingPeriod."Starting Date";
                            AccountingPeriod.SETRANGE("Starting Date", EndDate, 99991231D);
                            IF AccountingPeriod.FIND('-') THEN
                                IF AccountingPeriod.NEXT <> 0 THEN
                                    EndDate := CLOSINGDATE(AccountingPeriod."Starting Date" - 1);
                        END;
                END;
                AnalysisViewEntry.SETRANGE("Posting Date", StartDate, EndDate);

                AnalysisViewEntry.FILTERGROUP(2);
                TempSelectedDim.RESET;
                TempSelectedDim.SETCURRENTKEY("User ID", "Object Type", "Object ID", "Analysis View Code", Level);
                TempSelectedDim.SETFILTER("Dimension Value Filter", '<>%1', '');
                DimFilterText := '';
                IF TempSelectedDim.FIND('-') THEN
                    REPEAT
                        ThisFilter := '';
                        IF DimFilterText <> '' THEN
                            ThisFilter := ', ';
                        ThisFilter :=
                          ThisFilter + TempSelectedDim."Dimension Code" + ': ' + TempSelectedDim."Dimension Value Filter";
                        IF STRLEN(DimFilterText) + STRLEN(ThisFilter) <= 250 THEN
                            DimFilterText := DimFilterText + ThisFilter;
                        SetAnaViewEntryFilter(
                          TempSelectedDim."Dimension Code", TempSelectedDim."Dimension Value Filter");
                    UNTIL TempSelectedDim.NEXT = 0;
                AnalysisViewEntry.FILTERGROUP(0);

                TempSelectedDim.RESET;
                TempSelectedDim.SETCURRENTKEY("User ID", "Object Type", "Object ID", "Analysis View Code", Level);
                TempSelectedDim.SETFILTER(Level, '<>%1', TempSelectedDim.Level::" ");
                i := 1;
                IF TempSelectedDim.FIND('-') THEN
                    REPEAT
                        DimCode[i] := TempSelectedDim."Dimension Code";
                        LevelFilter[i] := TempSelectedDim."Dimension Value Filter";
                        i := i + 1;
                    UNTIL (TempSelectedDim.NEXT = 0) OR (i > 4);

                IF UseAmtsInAddCurr THEN
                    HeaderText := STRSUBSTNO(Text013, GLSetup."Additional Reporting Currency")
                ELSE
                    IF GLSetup."LCY Code" <> '' THEN
                        HeaderText := STRSUBSTNO(Text013, GLSetup."LCY Code")
                    ELSE
                        HeaderText := '';
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE(Code, AnalysisViewCode);
                GLSetup.GET;
                LCYCODE := GLSetup."LCY Code";
                AddRepCurrency := GLSetup."Additional Reporting Currency";
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AnalysisViewCode; AnalysisViewCode)
                {
                    Caption = 'C´Š¢d vista an´Š¢lisis';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        AnalysisView: Record "363";
                    begin
                        //IF FORM.RUNMODAL(FORM::"Analysis View List",AnalysisView) = ACTION::LookupOK THEN BEGIN
                        IF PAGE.RUNMODAL(PAGE::"Analysis View List", AnalysisView) = ACTION::LookupOK THEN BEGIN
                            AnalysisViewCode := AnalysisView.Code;
                            UpdateColumnDim;
                        END;
                    end;

                    trigger OnValidate()
                    begin
                        UpdateColumnDim;
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
                        DimSelectionBuf.SetDimSelectionLevelGLAcc(3, REPORT::"Dimensions - Detail", AnalysisViewCode, ColumnDim);

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
                        TempGLAcc.SETFILTER("Date Filter", DateFilter);
                        DateFilter := TempGLAcc.GETFILTER("Date Filter");
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
            GLSetup.GET;
            IF GLSetup."Additional Reporting Currency" = '' THEN
                UseAmtsInAddCurr := FALSE;
            UpdateColumnDim;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        SelectedDim: Record "369";
    begin
        IF AnalysisViewCode = '' THEN
            ERROR(Text000);

        IF DateFilter = '' THEN
            ERROR(Text001);

        DimSelectionBuf.CompareDimText(
          3, REPORT::"Dimensions - Detail", AnalysisViewCode, ColumnDim, Text002);

        TempSelectedDim.RESET;
        TempSelectedDim.SETFILTER("Dimension Value Filter", '<>%1', '');
        TempSelectedDim.SETFILTER("Dimension Code", TempGLAcc.TABLECAPTION);
        IF TempSelectedDim.FIND('-') THEN
            GLAcc.SETFILTER("No.", TempSelectedDim."Dimension Value Filter");
        GLAcc.SETRANGE("Account Type", GLAcc."Account Type"::Posting);
        IF GLAcc.FIND('-') THEN
            REPEAT
                TempGLAcc.INIT;
                TempGLAcc := GLAcc;
                TempGLAcc.INSERT;
            UNTIL GLAcc.NEXT = 0;

        TempBusUnit.INIT;
        TempBusUnit.INSERT;
        TempSelectedDim.SETFILTER("Dimension Code", BusUnit.TABLECAPTION);
        IF TempSelectedDim.FIND('-') THEN
            BusUnit.SETFILTER(Code, TempSelectedDim."Dimension Value Filter");
        IF BusUnit.FIND('-') THEN
            REPEAT
                TempBusUnit.INIT;
                TempBusUnit := BusUnit;
                TempBusUnit.INSERT;
            UNTIL BusUnit.NEXT = 0;

        SelectedDim.GetSelectedDim(USERID, 3, REPORT::"Dimensions - Detail", AnalysisViewCode, TempSelectedDim);
        TempSelectedDim.RESET;
        TempSelectedDim.SETCURRENTKEY("User ID", "Object Type", "Object ID", "Analysis View Code", Level);
        TempSelectedDim.SETFILTER(Level, '<>%1', TempSelectedDim.Level::" ");
        DimVal.SETFILTER(
          "Dimension Value Type", '%1|%2', DimVal."Dimension Value Type"::Standard, DimVal."Dimension Value Type"::"Begin-Total");
        IF TempSelectedDim.FIND('-') THEN
            REPEAT
                TempDimVal.INIT;
                TempDimVal.Code := '';
                TempDimVal."Dimension Code" := TempSelectedDim."Dimension Code";
                TempDimVal.Name := Text003;
                TempDimVal.INSERT;
                DimVal.SETRANGE("Dimension Code", TempSelectedDim."Dimension Code");
                IF TempSelectedDim."Dimension Value Filter" <> '' THEN
                    DimVal.SETFILTER(Code, TempSelectedDim."Dimension Value Filter")
                ELSE
                    DimVal.SETRANGE(Code);
                IF DimVal.FIND('-') THEN
                    REPEAT
                        TempDimVal.INIT;
                        TempDimVal := DimVal;
                        TempDimVal.INSERT;
                    UNTIL DimVal.NEXT = 0;
            UNTIL TempSelectedDim.NEXT = 0;
    end;

    var
        AnalysisViewEntry: Record "365";
        TempSelectedDim: Record "369" temporary;
        GLAcc: Record "15";
        BusUnit: Record "220";
        DimVal: Record "349";
        TempGLEntry: Record "17" temporary;
        TempGLAcc: Record "15" temporary;
        TempBusUnit: Record "220" temporary;
        TempDimVal: Record "349" temporary;
        DimSelectionBuf: Record "368";
        GLSetup: Record "98";
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
        CompanyInfo: Record "79";

    local procedure CalcLine(Level: Integer): Boolean
    var
        HasEntries: Boolean;
        i: Integer;
    begin
        IF Level < 4 THEN
            FOR i := Level + 1 TO 4 DO
                SetAnaViewEntryFilter(DimCode[i], '*');
        IF Iteration(
          FindFirstDim[Level], DimCode[Level], DimValCode[Level], DimValName[Level], LevelFilter[Level])
        THEN BEGIN
            SetAnaViewEntryFilter(DimCode[Level], DimValCode[Level]);
            HasEntries := AnalysisViewEntry.FIND('-');
        END ELSE
            CurrReport.BREAK;
        EXIT(HasEntries);
    end;

    procedure PrintDetail(Level: Integer): Boolean
    var
        AnalysisViewEntryToGLEntries: Codeunit "413";
    begin
        IF FindFirstGLEntry[Level] THEN BEGIN
            FindFirstGLEntry[Level] := FALSE;
            TempGLEntry.RESET;
            TempGLEntry.DELETEALL;
            IF AnalysisViewEntry.FIND('-') THEN BEGIN
                REPEAT
                    AnalysisViewEntryToGLEntries.GetGLEntries(AnalysisViewEntry, TempGLEntry);
                UNTIL AnalysisViewEntry.NEXT = 0;
            END;
            TempGLEntry.SETCURRENTKEY("G/L Account No.", "Posting Date");
            TempGLEntry.SETFILTER("Posting Date", DateFilter);
            IF NOT TempGLEntry.FIND('-') THEN
                EXIT(FALSE);
        END ELSE
            IF TempGLEntry.NEXT = 0 THEN
                EXIT(FALSE);
        IF Level > 1 THEN
            CalcTotalAmounts(Level - 1);
        EXIT(TRUE);
    end;

    local procedure CalcTotalAmounts(Level: Integer)
    var
        i: Integer;
    begin
        FOR i := 1 TO Level DO BEGIN
            IF UseAmtsInAddCurr THEN BEGIN
                TempGLEntry."Debit Amount" := TempGLEntry."Add.-Currency Debit Amount";
                TempGLEntry."Credit Amount" := TempGLEntry."Add.-Currency Credit Amount";
            END;
            DebitTotal[i] := DebitTotal[i] + TempGLEntry."Debit Amount";
            CreditTotal[i] := CreditTotal[i] + TempGLEntry."Credit Amount";
        END;
    end;

    local procedure UpdateColumnDim()
    var
        SelectedDim: Record "369";
        TempDimSelectionBuf: Record "368" temporary;
        AnalysisView: Record "363";
    begin
        AnalysisView.CopyAnalysisViewFilters(3, REPORT::"Dimensions - Detail", AnalysisViewCode);
        ColumnDim := '';
        SelectedDim.SETRANGE("User ID", USERID);
        SelectedDim.SETRANGE("Object Type", 3);
        SelectedDim.SETRANGE("Object ID", REPORT::"Dimensions - Detail");
        SelectedDim.SETRANGE("Analysis View Code", AnalysisViewCode);
        IF SelectedDim.FIND('-') THEN BEGIN
            REPEAT
                TempDimSelectionBuf.INIT;
                TempDimSelectionBuf.Code := SelectedDim."Dimension Code";
                TempDimSelectionBuf.Selected := TRUE;
                TempDimSelectionBuf."Dimension Value Filter" := SelectedDim."Dimension Value Filter";
                TempDimSelectionBuf.Level := SelectedDim.Level;
                TempDimSelectionBuf.INSERT;
            UNTIL SelectedDim.NEXT = 0;
            TempDimSelectionBuf.SetDimSelection(
              3, REPORT::"Dimensions - Detail", AnalysisViewCode, ColumnDim, TempDimSelectionBuf);
        END;
    end;

    local procedure Iteration(var FindFirst: Boolean; IterationDimCode: Text[30]; var IterationDimValCode: Code[20]; var IterationDimValName: Text[50]; IterationFilter: Text[250]): Boolean
    var
        SearchResult: Boolean;
    begin
        CASE IterationDimCode OF
            TempGLAcc.TABLECAPTION:
                BEGIN
                    TempGLAcc.RESET;
                    TempGLAcc.SETFILTER("No.", IterationFilter);
                    IF FindFirst THEN
                        SearchResult := TempGLAcc.FIND('-')
                    ELSE
                        IF TempGLAcc.GET(IterationDimValCode) THEN
                            SearchResult := (TempGLAcc.NEXT <> 0);
                    IF SearchResult THEN BEGIN
                        IterationDimValCode := TempGLAcc."No.";
                        IterationDimValName := TempGLAcc.Name;
                    END;
                END;
            TempBusUnit.TABLECAPTION:
                BEGIN
                    TempBusUnit.RESET;
                    TempBusUnit.SETFILTER(Code, IterationFilter);
                    IF FindFirst THEN
                        SearchResult := TempBusUnit.FIND('-')
                    ELSE
                        IF TempBusUnit.GET(IterationDimValCode) THEN
                            SearchResult := (TempBusUnit.NEXT <> 0);
                    IF SearchResult THEN BEGIN
                        IterationDimValCode := TempBusUnit.Code;
                        IF TempBusUnit.Code <> '' THEN
                            IterationDimValName := TempBusUnit.Name
                        ELSE
                            IterationDimValName := Text014;
                    END;
                END;
            ELSE BEGIN
                TempDimVal.RESET;
                TempDimVal.SETRANGE("Dimension Code", IterationDimCode);
                TempDimVal.SETFILTER(Code, IterationFilter);
                IF FindFirst THEN
                    SearchResult := TempDimVal.FIND('-')
                ELSE
                    IF TempDimVal.GET(IterationDimCode, IterationDimValCode) THEN
                        SearchResult := (TempDimVal.NEXT <> 0);
                IF SearchResult THEN BEGIN
                    IterationDimValCode := TempDimVal.Code;
                    IterationDimValName := TempDimVal.Name;
                END;
            END;
        END;
        IF NOT SearchResult THEN BEGIN
            IterationDimValCode := '';
            IterationDimValName := '';
        END;
        FindFirst := FALSE;
        EXIT(SearchResult);
    end;

    local procedure SetAnaViewEntryFilter(AnalysisViewDimCode: Text[30]; AnalysisViewFilter: Text[250])
    begin
        IF AnalysisViewFilter = '' THEN
            AnalysisViewFilter := '''''';
        CASE AnalysisViewDimCode OF
            TempGLAcc.TABLECAPTION:
                IF AnalysisViewFilter = '*' THEN
                    //AnalysisViewEntry.SETRANGE("G/L Account No.") // en 2016 este campo se llama "Account No."
                    AnalysisViewEntry.SETRANGE("Account No.")
                ELSE
                    //AnalysisViewEntry.SETFILTER("G/L Account No.",AnalysisViewFilter);
                    AnalysisViewEntry.SETFILTER("Account No.", AnalysisViewFilter);
            TempBusUnit.TABLECAPTION:
                IF AnalysisViewFilter = '*' THEN
                    AnalysisViewEntry.SETRANGE("Business Unit Code")
                ELSE
                    AnalysisViewEntry.SETFILTER("Business Unit Code", AnalysisViewFilter);

            "Analysis View"."Dimension 1 Code":
                IF AnalysisViewFilter = '*' THEN
                    AnalysisViewEntry.SETRANGE("Dimension 1 Value Code")
                ELSE
                    AnalysisViewEntry.SETFILTER("Dimension 1 Value Code", AnalysisViewFilter);

            "Analysis View"."Dimension 2 Code":
                IF AnalysisViewFilter = '*' THEN
                    AnalysisViewEntry.SETRANGE("Dimension 2 Value Code")
                ELSE
                    AnalysisViewEntry.SETFILTER("Dimension 2 Value Code", AnalysisViewFilter);

            "Analysis View"."Dimension 3 Code":
                IF AnalysisViewFilter = '*' THEN
                    AnalysisViewEntry.SETRANGE("Dimension 3 Value Code")
                ELSE
                    AnalysisViewEntry.SETFILTER("Dimension 3 Value Code", AnalysisViewFilter);

            "Analysis View"."Dimension 4 Code":
                IF AnalysisViewFilter = '*' THEN
                    AnalysisViewEntry.SETRANGE("Dimension 4 Value Code")
                ELSE
                    AnalysisViewEntry.SETFILTER("Dimension 4 Value Code", AnalysisViewFilter);
        END;
    end;
}

