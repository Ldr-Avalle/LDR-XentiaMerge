report 50078 "location/Item entrys2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './locationItem entrys2.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table14)
        {
            DataItemTableView = WHERE(ShopCode=FILTER(<>''),
                                      Global Dimension 1 Code=FILTER(TELECABLE));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Global Dimension 1 Code";
            dataitem(DataItem1000000001;Table5802)
            {
                CalcFields = Shop Code;
                DataItemLink = Location Code=FIELD(Code);
                DataItemTableView = SORTING(Item No.,Posting Date,Item Ledger Entry Type,Entry Type,Variance Type,Item Charge No.,Location Code,Variant Code)
                                    WHERE(Source Type=CONST(Vendor),
                                          Source No.=CONST(P00040));
                RequestFilterFields = "Posting Date";
            }
            dataitem(DataItem1000000002;Table2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(ValueEntryExternalDocumentNo;"Value Entry"."External Document No.")
                {
                }
                column(ValueEntryPostingDate;"Value Entry"."Posting Date")
                {
                }
                column(ItemVendorItemNo;Item."Vendor Item No.")
                {
                }
                column(LocationCode;Location.Code)
                {
                }
                column(ValueEntryBufferValuedQuantity;ValueEntryBuffer."Valued Quantity")
                {
                }

                trigger OnPreDataItem()
                begin
                    //Integer, Body (1) - OnPreSection()
                    CalcProfitPct;
                    IF NOT Item.GET(ValueEntryBuffer."Item No.") THEN
                      Item.INIT
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(PrintOnlyOnePerPage;PrintOnlyOnePerPage)
                {
                    Caption = 'P´Š¢gina nueva por tienda';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PrintToExcel := FALSE;
        end;
    }

    labels
    {
    }

    var
        Item: Record "27";
        ValueEntryBuffer: Record "5802" temporary;
        ExcelBuf: Record "370" temporary;
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
        WITH ValueEntryBuffer DO BEGIN
          IF "Sales Amount (Actual)" <> 0 THEN
            ProfitPct := ROUND(100 * Profit / "Sales Amount (Actual)",0.1)
          ELSE
            ProfitPct := 0;
        END;
    end;

    procedure MakeExcelInfo()
    begin
        //MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        /*ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Item.FIELDCAPTION("Vendor Item No."),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(Item.FIELDCAPTION(Description),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Item No."),FALSE,'',TRUE,FALSE,TRUE,'@');
        ExcelBuf.AddColumn("Value Entry".FIELDCAPTION("Shop Code"),FALSE,'',TRUE,FALSE,TRUE,'');
        ExcelBuf.AddColumn(ValueEntryBuffer.FIELDCAPTION("Invoiced Quantity"),FALSE,'',TRUE,FALSE,TRUE,'');*/ //comentado en 2016 es standard

    end;

    procedure MakeExcelDataBody()
    begin
        /*ExcelBuf.NewRow;
        ExcelBuf.AddColumn("Value Entry"."External Document No.",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn("Value Entry"."Posting Date",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Location.Code,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Item."Vendor Item No.",FALSE,'',FALSE,FALSE,FALSE,'');*/ //comentado en 2016 es standard
        //ExcelBuf.AddColumn(Item.Description,FALSE,'',FALSE,FALSE,FALSE,'');
        //ExcelBuf.AddColumn(ValueEntryBuffer."Item No.",FALSE,'',FALSE,FALSE,FALSE,'');
        
        /*ExcelBuf.AddColumn(-ValueEntryBuffer."Valued Quantity",FALSE,'',FALSE,FALSE,FALSE,'');*/ //comentado en 2016 es standard

    end;

    procedure CreateExcelbook()
    begin
        /*ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');*/ //comentado en 2016 es standard

    end;
}

