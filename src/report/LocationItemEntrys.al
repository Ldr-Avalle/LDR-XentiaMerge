report 50077 "location/Item entrys"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/locationItem entrys.rdl';

    dataset
    {
        dataitem(Location; Location)
        {
            DataItemTableView = where(ShopCode = filter(<> ''),
                                      "Global Dimension 1 Code" = filter('EUSKALTEL'));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Global Dimension 1 Code";
            dataitem("Value Entry"; "Value Entry")
            {
                //todo:comentado porque no se utiliza
                //CalcFields = "Shop Code";
                DataItemLink = "Location Code" = field(Code);
                DataItemTableView = sorting("Item No.", "Posting Date", "Item Ledger Entry Type", "Entry Type", "Variance Type", "Item Charge No.", "Location Code", "Variant Code")
                                    where("Source Type" = const(Vendor),
                                          "Source No." = const('P00040'));
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
                    //Integer, Body (1) - OnPreSection()
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
        Text000: Label 'Period: %1';
        Text001: Label 'Data';
        Text002: Label 'Customer/Item Sales';
        Text003: Label 'Company Name';
        Text004: Label 'Report No.';
        Text005: Label 'Report Name';
        Text006: Label 'User ID';
        Text007: Label 'Date';
        Text008: Label 'Customer Filters';
        Text009: Label 'Value Entry Filters';
        Text010: Label 'Profit';
        Text011: Label 'Profit %';

    local procedure CalcProfitPct()
    begin
        with ValueEntryBuffer do
            if "Sales Amount (Actual)" <> 0 then
                ProfitPct := Round(100 * Profit / "Sales Amount (Actual)", 0.1)
            else
                ProfitPct := 0;
    end;
}

