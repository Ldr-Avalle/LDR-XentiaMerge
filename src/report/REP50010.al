report 50010 "Duplicate Data"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Accounting Period"; "Accounting Period")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable1.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable1.GET("Starting Date") THEN BEGIN
                    FromTable1.TRANSFERFIELDS("Accounting Period");
                    FromTable1.INSERT;
                END;
            end;
        }
        dataitem("Analysis View Budget Entry"; "Analysis View Budget Entry")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable2.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable2.GET("Analysis View Code", "Budget Name", "G/L Account No.", "Dimension 1 Value Code", "Dimension 2 Value Code", "Dimension 3 Value Code", "Dimension 4 Value Code") THEN BEGIN
                    FromTable2.TRANSFERFIELDS("Analysis View Budget Entry");
                    FromTable2.INSERT;
                END;
            end;
        }
        dataitem("Avg. Cost Adjmt. Entry Point"; "Avg. Cost Adjmt. Entry Point")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable3.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable3.GET("Item No.", "Variant Code", "Location Code", "Valuation Date") THEN BEGIN
                    FromTable3.TRANSFERFIELDS("Avg. Cost Adjmt. Entry Point");
                    FromTable3.INSERT;
                END;
            end;
        }
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable4.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable4.GET("Entry No.") THEN BEGIN
                    FromTable4.TRANSFERFIELDS("Bank Account Ledger Entry");
                    FromTable4.INSERT;
                END;
            end;
        }
        dataitem("Cartera Report Selections"; "Cartera Report Selections")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable5.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable5.GET(Usage, Sequence) THEN BEGIN
                    FromTable5.TRANSFERFIELDS("Cartera Report Selections");
                    FromTable5.INSERT;
                END;
            end;
        }
        dataitem(Customer; Customer)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable6.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable6.GET("No.") THEN BEGIN
                    FromTable6.TRANSFERFIELDS(Customer);
                    FromTable6.INSERT;
                END;
            end;
        }
        dataitem("Default Dimension Priority"; "Default Dimension Priority")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable7.CHANGECOMPANY('SERCABLE');

                IF NOT FromTable7.GET("Source Code", "Table ID") THEN BEGIN
                    FromTable7.TRANSFERFIELDS("Default Dimension Priority");
                    FromTable7.INSERT;
                END;
            end;
        }
        dataitem(Dimension; Dimension)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable8.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable8.GET(Code) THEN BEGIN
                    FromTable8.TRANSFERFIELDS(Dimension);
                    FromTable8.INSERT;
                END;
            end;
        }
        dataitem("Dimension Value"; "Dimension Value")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable9.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable9.GET("Dimension Code", Code) THEN BEGIN
                    FromTable9.TRANSFERFIELDS("Dimension Value");
                    FromTable9.INSERT;
                END;
            end;
        }
        dataitem("Employee Contract"; "Employee Contract")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable10.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable10.GET(Employee, "No.") THEN BEGIN
                    FromTable10.TRANSFERFIELDS("Employee Contract");
                    FromTable10.INSERT;
                END;
            end;
        }
        dataitem("Employee internal historic"; "Employee internal historic")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable11.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable11.GET("Employee No.", "Start Date") THEN BEGIN
                    FromTable11.TRANSFERFIELDS("Employee internal historic");
                    FromTable11.INSERT;
                END;
            end;
        }
        dataitem("FA Date Type"; "FA Date Type")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable12.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable12.GET("FA Date Type No.", "FA Date Type Name") THEN BEGIN
                    FromTable12.TRANSFERFIELDS("FA Date Type");
                    FromTable12.INSERT;
                END;
            end;
        }
        dataitem("G/l Account"; "G/l Account")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable13.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable13.GET("No.") THEN BEGIN
                    FromTable13.TRANSFERFIELDS("G/l Account");
                    FromTable13.INSERT;
                END;
            end;
        }
        dataitem("G/L Budget Entry"; "G/L Budget Entry")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable14.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable14.GET("Entry No.") THEN BEGIN
                    FromTable14.TRANSFERFIELDS("G/L Budget Entry");
                    FromTable14.INSERT;
                END;
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable15.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable15.GET("Entry No.") THEN BEGIN
                    FromTable15.TRANSFERFIELDS("G/L Entry");
                    FromTable15.INSERT;
                END;
            end;
        }
        dataitem("G/L Register"; "G/L Register")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable16.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable16.GET("No.") THEN BEGIN
                    FromTable16.TRANSFERFIELDS("G/L Register");
                    FromTable16.INSERT;
                END;
            end;
        }
        dataitem("IDi Employee"; "IDi Employee")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable17.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable17.GET("Job No.", Employee) THEN BEGIN
                    FromTable17.TRANSFERFIELDS("IDi Employee");
                    FromTable17.INSERT;
                END;
            end;
        }
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable18.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable18.GET("No.") THEN BEGIN
                    FromTable18.TRANSFERFIELDS("Purch. Rcpt. Header");
                    FromTable18.INSERT;
                END;
            end;
        }
        dataitem("Responsibility Center"; "Responsibility Center")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable19.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable19.GET(Code) THEN BEGIN
                    FromTable19.TRANSFERFIELDS("Responsibility Center");
                    FromTable19.INSERT;
                END;
            end;
        }
        dataitem("Return Receipt Line"; "Return Receipt Line")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable20.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable20.GET("Document No.", "Line No.") THEN BEGIN
                    FromTable20.TRANSFERFIELDS("Return Receipt Line");
                    FromTable20.INSERT;
                END;
            end;
        }
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable21.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable21.GET("No.") THEN BEGIN
                    FromTable21.TRANSFERFIELDS("Sales Shipment Header");
                    FromTable21.INSERT;
                END;
            end;
        }
        dataitem("Selected G/L Accounts"; "Selected G/L Accounts")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable22.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable22.GET("No.") THEN BEGIN
                    FromTable22.TRANSFERFIELDS("Selected G/L Accounts");
                    FromTable22.INSERT;
                END;
            end;
        }
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable23.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable23.GET("No.") THEN BEGIN
                    FromTable23.TRANSFERFIELDS("Transfer Shipment Header");
                    FromTable23.INSERT;
                END;
            end;
        }
        dataitem("User Setup"; "User Setup")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable24.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable24.GET("User ID") THEN BEGIN
                    FromTable24.TRANSFERFIELDS("User Setup");
                    FromTable24.INSERT;
                END;
            end;
        }
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {

            trigger OnAfterGetRecord()
            begin
                FromTable25.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable25.GET("Entry No.") THEN BEGIN
                    FromTable25.TRANSFERFIELDS("Vendor Ledger Entry");
                    FromTable25.INSERT;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE('Finish');
    end;

    trigger OnPreReport()
    begin
        MESSAGE('Init');
    end;

    var
        FromTable1: Record "50";
        FromTable2: Record "366";
        FromTable3: Record "5804";
        FromTable4: Record "271";
        FromTable5: Record "7000013";
        FromTable6: Record "18";
        FromTable7: Record "354";
        FromTable8: Record "348";
        FromTable9: Record "349";
        FromTable10: Record "50004";
        FromTable11: Record "50009";
        FromTable12: Record "5645";
        FromTable13: Record "15";
        FromTable14: Record "96";
        FromTable15: Record "17";
        FromTable16: Record "45";
        FromTable17: Record "50026";
        FromTable18: Record "120";
        FromTable19: Record "5714";
        FromTable20: Record "6661";
        FromTable21: Record "110";
        FromTable22: Record "10727";
        FromTable23: Record "5744";
        FromTable24: Record "91";
        FromTable25: Record "25";
}

