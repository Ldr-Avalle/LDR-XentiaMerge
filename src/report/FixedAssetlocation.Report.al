report 50036 "Fixed Asset location"
{
    ApplicationArea = All;
    Caption = 'Fixed Asset location';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Fixed Asset location.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "Budgeted Asset";
            UseTemporary = true;

            column(DeprBookText; DeprBookText)
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            dataitem("FA Depreciation Book"; "FA Depreciation Book")
            {
                CalcFields = "Acquisition Cost", Depreciation;
                DataItemTableView = sorting("FA No.", "Depreciation Book Code");

                column(FixedAsset_No; "Fixed Asset"."No.")
                {
                }
                column(FixedAsset_Description; "Fixed Asset".Description)
                {
                }
                column(FixedAsset_Location; "Fixed Asset"."Location Code")
                {
                }
                column(FADepreciationBook_AcquisitionCost; "FA Depreciation Book"."Acquisition Cost")
                {
                }

                trigger OnPreDataItem()
                begin
                    SetRange("FA No.", "Fixed Asset"."No.");
                    SetRange("Depreciation Book Code", DeprBookCode);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if Inactive then
                    CurrReport.Skip();
                if "Main Asset/Component" <> "Main Asset/Component"::" " then
                    ComponentFieldname := FieldCaption("Component of Main Asset")
                else
                    ComponentFieldname := '';
                if "Budgeted Asset" then
                    BudgetedAssetFieldname := FieldCaption("Budgeted Asset")
                else
                    BudgetedAssetFieldname := '';
                if "Serial No." <> '' then
                    SerialNoFieldname := FieldCaption("Serial No.")
                else
                    SerialNoFieldname := '';

                if IsServiceTier then
                    if PrintOnlyOnePerPage then
                        PageGroupNo := PageGroupNo + 1;
                if IsServiceTier then
                    MainAssetComponent := "Main Asset/Component";
                CalcFields("Location Code");
            end;

            trigger OnPreDataItem()
            begin
                if IsServiceTier then
                    PageGroupNo := 1;
                CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(DeprBookCode; DeprBookCode)
                {
                    Caption = 'Libro amortización';
                }
                field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                {
                    Caption = 'Página nueva por activo';
                }
            }
        }

        trigger OnOpenPage()
        begin
            if DeprBookCode = '' then begin
                FASetup.Get();
                DeprBookCode := FASetup."Default Depr. Book";
            end;
        end;
    }

    trigger OnPreReport()
    begin
        DeprBook.Get(DeprBookCode);
        FAFilter := "Fixed Asset".GetFilters;
        DeprBookText := StrSubstNo('%1%2 %3', DeprBook.TableCaption, ':', DeprBookCode);
    end;

    var
        FASetup: Record "FA Setup";
        DeprBook: Record "Depreciation Book";
        PrintOnlyOnePerPage: Boolean;
        DeprBookCode: Code[10];
        FAFilter: Text[250];
        ComponentFieldname: Text[100];
        BudgetedAssetFieldname: Text[100];
        SerialNoFieldname: Text[100];
        DeprBookText: Text[50];
        PageGroupNo: Integer;
        MainAssetComponent: Integer;
        CompanyInfo: Record "Company Information";
}