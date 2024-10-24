report 50078 "location/Item entrys2"
{
    ApplicationArea = All;
    Caption = 'location/Item entrys2';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/locationItem entrys2.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = where(ShopCode = filter(<> ''), "Global Dimension 1 Code" = filter('TELECABLE'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Global Dimension 1 Code";
            dataitem("Value Entry"; "Value Entry")
            {
                CalcFields = "Shop Code";
                DataItemLink = "Location Code" = field(Code);
                DataItemTableView = sorting("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code") where("Source Type" = const(Vendor), "Source No." = const('P00040'));
                RequestFilterFields = "Posting Date";
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number);
                column(ValueEntryExternalDocumentNo; "Value Entry"."External Document No.")
                {
                }
                column(ValueEntryPostingDate; "Value Entry"."Posting Date")
                {
                }
                column(ItemVendorItemNo; Item."Vendor Item No.")
                {
                }
                column(LocationCode; Location.Code)
                {
                }
                column(ValueEntryBufferValuedQuantity; ValueEntryBuffer."Valued Quantity")
                {
                }

                trigger OnPreDataItem()
                begin
                    CalcProfitPct();
                    if not Item.Get(ValueEntryBuffer."Item No.") then
                        Item.Init()
                end;
            }
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
            }
        }

        trigger OnOpenPage()
        begin
            PrintToExcel := false;
        end;
    }

    var
        Item: Record Item;
        ValueEntryBuffer: Record "Value Entry" temporary;
        ExcelBuf: Record "Excel Buffer" temporary;
        LocationFilter: Text[250];
        ItemLedgEntryFilter: Text[250];
        PeriodText: Text[30];
        NextEntryNo: Integer;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        PrintToExcel: Boolean;
        Text000: Label 'Period: %1', Comment = 'ESP="Periodo: %1"';
        Text001: Label 'Data', Comment = 'ESP="Datos"';
        Text002: Label 'Customer/Item Sales', Comment = 'ESP="Cliente - Ventas por productos"';
        Text003: Label 'Company Name', Comment = 'ESP="Nombre empresa"';
        Text004: Label 'Report No.', Comment = 'ESP="Nº informe"';
        Text005: Label 'Report Name', Comment = 'ESP="Nombre informe"';
        Text006: Label 'User ID', Comment = 'ESP="Id. usuario"';
        Text007: Label 'Date', Comment = 'ESP="Fecha"';
        Text008: Label 'Customer Filters', Comment = 'ESP="Filtros cliente"';
        Text009: Label 'Value Entry Filters', Comment = 'ESP="Filtros mov. valor"';
        Text010: Label 'Profit', Comment = 'ESP="Bfº bruto"';
        Text011: Label 'Profit %', Comment = 'ESP="Bfº bruto"';

    local procedure CalcProfitPct()
    begin
        if ValueEntryBuffer."Sales Amount (Actual)" <> 0 then
            ProfitPct := Round(100 * Profit / ValueEntryBuffer."Sales Amount (Actual)", 0.1)
        else
            ProfitPct := 0;
    end;
}