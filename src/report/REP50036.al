report 50036 "Fixed Asset location"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Fixed Asset location.rdl';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = SORTING("No.");
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
                DataItemTableView = SORTING("FA No.", "Depreciation Book Code");
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
                    SETRANGE("FA No.", "Fixed Asset"."No.");
                    SETRANGE("Depreciation Book Code", DeprBookCode);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF Inactive THEN
                    CurrReport.SKIP;
                IF "Main Asset/Component" <> "Main Asset/Component"::" " THEN
                    ComponentFieldname := FIELDCAPTION("Component of Main Asset")
                ELSE
                    ComponentFieldname := '';
                IF "Budgeted Asset" THEN
                    BudgetedAssetFieldname := FIELDCAPTION("Budgeted Asset")
                ELSE
                    BudgetedAssetFieldname := '';
                IF "Serial No." <> '' THEN
                    SerialNoFieldname := FIELDCAPTION("Serial No.")
                ELSE
                    SerialNoFieldname := '';

                IF ISSERVICETIER THEN BEGIN
                    IF PrintOnlyOnePerPage THEN
                        PageGroupNo := PageGroupNo + 1;
                END;
                IF ISSERVICETIER THEN
                    MainAssetComponent := "Main Asset/Component";
                //Calcular localizaci´Š¢n
                CALCFIELDS("Location Code");
            end;

            trigger OnPreDataItem()
            begin
                IF ISSERVICETIER THEN
                    PageGroupNo := 1;

                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DeprBookCode; DeprBookCode)
                {
                    Caption = 'Libro amortizaci´Š¢n';
                }
                field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                {
                    Caption = 'P´Š¢gina nueva por activo';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF DeprBookCode = '' THEN BEGIN
                FASetup.GET;
                DeprBookCode := FASetup."Default Depr. Book";
            END;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        DeprBook.GET(DeprBookCode);
        FAFilter := "Fixed Asset".GETFILTERS;
        DeprBookText := STRSUBSTNO('%1%2 %3', DeprBook.TABLECAPTION, ':', DeprBookCode);
    end;

    var
        FASetup: Record "5603";
        DeprBook: Record "5611";
        PrintOnlyOnePerPage: Boolean;
        DeprBookCode: Code[10];
        FAFilter: Text[250];
        ComponentFieldname: Text[100];
        BudgetedAssetFieldname: Text[100];
        SerialNoFieldname: Text[100];
        DeprBookText: Text[50];
        PageGroupNo: Integer;
        MainAssetComponent: Integer;
        CompanyInfo: Record "79";
}

