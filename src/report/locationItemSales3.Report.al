report 50076 "location/Item Sales3"
{
    ApplicationArea = All;
    Caption = 'location/Item Sales3';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/locationItem Sales3.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = where(ShopCode = filter(<> ''), "Global Dimension 1 Code" = filter('TELECABLE'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Global Dimension 1 Code";
            column(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
            {
            }
            column(STRSUBSTNOText000PeriodText; StrSubstNo(Text000, PeriodText))
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(LocationCode; Location.Code)
            {
            }
            dataitem(Item; Item)
            {
                DataItemTableView = where("On Deposit" = const(true));
                column(ItemVendorItemNo; Item."Vendor Item No.")
                {
                }
                column(ItemDescription; Item.Description)
                {
                }
                column(ItemNo; Item."No.")
                {
                }
                column(InvoicedQuantity; InvoicedQuantity)
                {
                }
                column(SalesAmount; SalesAmount)
                {
                }
                column(ItemInventory; Item.Inventory)
                {
                }
                column(ItemQtyonPurchOrder; Item."Qty. on Purch. Order")
                {
                }
                column(ItemQuantityreturnsorders; Item."Quantity returns orders")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    InvoicedQuantity := 0;
                    SalesAmount := 0;

                    Item.SetFilter("Location Filter", '%1', Location.Code);
                    Item.CalcFields(Inventory, "Qty. on Purch. Order", "Quantity returns orders");

                    ValueEntry.SetRange("Item No.", "No.");
                    ValueEntry.SetRange("Source Type", ValueEntry."Source Type"::Customer);
                    ValueEntry.SetFilter("Location Code", '%1', Location.Code);
                    ValueEntry.SetFilter("Posting Date", '%1..%2', InitialDate, EndDate);
                    if ValueEntry.FindFirst() then
                        repeat
                            InvoicedQuantity += ValueEntry."Invoiced Quantity";
                            SalesAmount += ValueEntry."Sales Amount (Actual)";
                        until ValueEntry.Next() = 0;
                end;
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number);

                trigger OnPreDataItem()
                begin
                    CurrReport.CreateTotals(
                      ValueEntryBuffer."Sales Amount (Actual)",
                      ValueEntryBuffer."Discount Amount",
                      Profit);

                    ValueEntryBuffer.Reset();
                    SetRange(Number, 1, ValueEntryBuffer.Count);
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.NewPagePerRecord := PrintOnlyOnePerPage;

                CurrReport.CreateTotals(
                  ValueEntryBuffer."Sales Amount (Actual)", ValueEntryBuffer."Invoiced Quantity",
                  ValueEntryBuffer."Discount Amount",
                  Profit);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(PrintOnlyOnePerPage; PrintOnlyOnePerPage)
                {
                    Caption = 'Página nueva por tienda';
                }
                field(InitialDate; InitialDate)
                {
                    Caption = 'Fecha inicial';
                }
                field(EndDate; EndDate)
                {
                    Caption = 'Fecha final';
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        LocationFilter := Location.GetFilters;
    end;

    var
        ValueEntryBuffer: Record "Value Entry";
        ExcelBuf: Record "Excel Buffer";
        ValueEntry: Record "Value Entry";
        Item2: Record Item;
        CompanyInfo: Record "Company Information";
        LocationFilter: Text;
        ItemLedgEntryFilter: Text;
        PeriodText: Text;
        NextEntryNo: Integer;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        PrintToExcel: Boolean;
        InitialDate: Date;
        InvoicedQuantity: Decimal;
        SalesAmount: Decimal;
        EndDate: Date;
        Text000: Label 'Periodo: %1', Comment = 'ESP="Periodo: %1"';
        Text001: Label 'Datos';
        Text002: Label 'Cliente - Ventas por productos';
        Text003: Label 'Nombre empresa';
        Text004: Label 'Nº informe';
        Text005: Label 'Nombre informe';
        Text006: Label 'Id. usuario';
        Text007: Label 'Fecha';
        Text008: Label 'Filtros cliente';
        Text009: Label 'Filtros mov. valor';
        Text010: Label 'Bfº bruto';
        Text011: Label '% Bfº bruto';

    local procedure CalcProfitPct()
    begin
        if ValueEntryBuffer."Sales Amount (Actual)" <> 0 then
            ProfitPct := Round(100 * Profit / ValueEntryBuffer."Sales Amount (Actual)", 0.1)
        else
            ProfitPct := 0;
    end;
}