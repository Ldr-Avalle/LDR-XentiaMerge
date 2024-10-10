report 50075 "location/Item Sales2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './locationItem Sales2.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table14)
        {
            DataItemTableView = WHERE(ShopCode=FILTER(<>''),
                                      Global Dimension 1 Code=FILTER(EUSKALTEL));
            PrintOnlyIfDetail = true;
            column(PrintOnlyOnePerPage;PrintOnlyOnePerPage)
            {
            }
            column(STRSUBSTNOText000PeriodText;STRSUBSTNO(Text000,PeriodText))
            {
            }
            column(CompanyInfoName;CompanyInfo.Name)
            {
            }
            column(LocationCode;Location.Code)
            {
            }
            dataitem(DataItem1000000001;Table27)
            {
                DataItemTableView = WHERE(On Deposit=CONST(Yes));
                column(ItemVendorItemNo;Item."Vendor Item No.")
                {
                }
                column(ItemDescription;Item.Description)
                {
                }
                column(ItemNo;Item."No.")
                {
                }
                column(InvoicedQuantity;InvoicedQuantity)
                {
                }
                column(SalesAmount;SalesAmount)
                {
                }
                column(ItemInventory;Item.Inventory)
                {
                }
                column(ItemQtyonPurchOrder;Item."Qty. on Purch. Order")
                {
                }
                column(ItemQuantityreturnsorders;Item."Quantity returns orders")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    InvoicedQuantity:=0;
                    SalesAmount :=0;

                    Item.SETFILTER("Location Filter", '%1', Location.Code);
                    Item.CALCFIELDS(Inventory,"Qty. on Purch. Order","Quantity returns orders");

                    ValueEntry.SETRANGE("Item No.", "No.");
                    ValueEntry.SETRANGE("Source Type", ValueEntry."Source Type"::Customer);
                    ValueEntry.SETFILTER("Location Code", '%1', Location.Code);
                    ValueEntry.SETFILTER("Posting Date",'%1..%2',InitialDate,EndDate);
                    IF ValueEntry.FINDFIRST THEN
                     REPEAT
                        InvoicedQuantity+= ValueEntry."Invoiced Quantity" ;
                        SalesAmount +=ValueEntry."Sales Amount (Actual)";
                    UNTIL  ValueEntry.NEXT=0;

                      MakeExcelDataBody;
                end;
            }
            dataitem(DataItem1000000002;Table2000000026)
            {
                DataItemTableView = SORTING(Number);

                trigger OnAfterGetRecord()
                begin
                    /*IF Number = 1 THEN
                      ValueEntryBuffer.FIND('-')
                    ELSE
                      ValueEntryBuffer.NEXT;
                    
                    Profit :=
                      ValueEntryBuffer."Sales Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Actual)" +
                      ValueEntryBuffer."Cost Amount (Non-Invtbl.)";
                    
                    IF PrintToExcel AND Item.GET(ValueEntryBuffer."Item No.") THEN BEGIN
                      //Item.SETFILTER("Date Filter", "Value Entry".GETFILTER("Posting Date"));
                      //Item.SETFILTER("Date Filter", TODAY);
                        Item.SETFILTER("Location Filter", '%1', Location.Code);
                      Item.CALCFIELDS(Inventory,"Qty. on Purch. Order","Quantity returns orders");
                      CalcProfitPct;
                      MakeExcelDataBody;
                    END; */ //en 2016 es standard

                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(
                      ValueEntryBuffer."Sales Amount (Actual)",
                      ValueEntryBuffer."Discount Amount",
                      Profit);

                    ValueEntryBuffer.RESET;
                    SETRANGE(Number, 1, ValueEntryBuffer.COUNT);
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGEPERRECORD := PrintOnlyOnePerPage;

                CurrReport.CREATETOTALS(
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
            area(content)
            {
                field(PrintOnlyOnePerPage;PrintOnlyOnePerPage)
                {
                    Caption = 'P´Š¢gina nueva por tienda';
                }
                field(InitialDate;InitialDate)
                {
                    Caption = 'Fecha inicial';
                }
                field(EndDate;EndDate)
                {
                    Caption = 'Fecha final';
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

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN
          CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        LocationFilter := Location.GETFILTERS;
        //ItemLedgEntryFilter := "Value Entry".GETFILTERS;
        //PeriodText := "Value Entry".GETFILTER("Posting Date");

        IF PrintToExcel THEN
          MakeExcelInfo;
    end;

    var
        ValueEntryBuffer: Record "5802";
        ExcelBuf: Record "370";
        LocationFilter: Text;
        ItemLedgEntryFilter: Text;
        PeriodText: Text;
        NextEntryNo: Integer;
        PrintOnlyOnePerPage: Boolean;
        Profit: Decimal;
        ProfitPct: Decimal;
        PrintToExcel: Boolean;
        ValueEntry: Record "5802";
        Item2: Record "27";
        InitialDate: Date;
        InvoicedQuantity: Decimal;
        SalesAmount: Decimal;
        EndDate: Date;
        Text000: Label 'Periodo: %1';
        Text001: Label 'Datos';
        Text002: Label 'Cliente - Ventas por productos';
        Text003: Label 'Nombre empresa';
        Text004: Label 'N´Š¢ informe';
        Text005: Label 'Nombre informe';
        Text006: Label 'Id. usuario';
        Text007: Label 'Fecha';
        Text008: Label 'Filtros cliente';
        Text009: Label 'Filtros mov. valor';
        Text010: Label 'Bf´Š¢ bruto';
        Text011: Label '% Bf´Š¢ bruto';
        CompanyInfo: Record "79";

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
        /*MakeExcelDataHeader;*/ //en 2016 es standard

    end;

    local procedure MakeExcelDataHeader()
    begin
    end;

    procedure MakeExcelDataBody()
    begin
        /*ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Item."Vendor Item No.",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Item.Description,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Item."No.",FALSE,'',FALSE,FALSE,FALSE,'@');
        ExcelBuf.AddColumn(Location.Code,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(-InvoicedQuantity,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(SalesAmount,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Item.Inventory,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Item."Qty. on Purch. Order",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(Item."Quantity returns orders",FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.AddColumn(0,FALSE,'',FALSE,FALSE,FALSE,'');*/ //en 2016 es standard

    end;

    procedure CreateExcelbook()
    begin
        /*ExcelBuf.CreateBook;
        ExcelBuf.CreateSheet(Text001,Text002,COMPANYNAME,USERID);
        ExcelBuf.GiveUserControl;
        ERROR('');*/ //en 2016 es standard

    end;
}

