report 50010 "Duplicate Data"
{
    ApplicationArea = All;
    Caption = 'Duplicate Data';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Accounting Period"; "Accounting Period")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable1.ChangeCompany('SERCABLE');
                if not FromTable1.Get("Starting Date") then begin
                    FromTable1.TransferFields("Accounting Period");
                    FromTable1.Insert();
                end;
            end;
        }
        dataitem("Analysis View Budget Entry"; "Analysis View Budget Entry")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable2.ChangeCompany('SERCABLE');
                if not FromTable2.Get("Analysis View Code", "Budget Name", "G/L Account No.", "Dimension 1 Value Code", "Dimension 2 Value Code", "Dimension 3 Value Code", "Dimension 4 Value Code") then begin
                    FromTable2.TransferFields("Analysis View Budget Entry");
                    FromTable2.Insert();
                end;
            end;
        }
        dataitem("Avg. Cost Adjmt. Entry Point"; "Avg. Cost Adjmt. Entry Point")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable3.ChangeCompany('SERCABLE');
                if not FromTable3.Get("Item No.", "Variant Code", "Location Code", "Valuation Date") then begin
                    FromTable3.TransferFields("Avg. Cost Adjmt. Entry Point");
                    FromTable3.Insert();
                end;
            end;
        }
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable4.ChangeCompany('SERCABLE');
                if not FromTable4.Get("Entry No.") then begin
                    FromTable4.TransferFields("Bank Account Ledger Entry");
                    FromTable4.Insert();
                end;
            end;
        }
        dataitem("Cartera Report Selections"; "Cartera Report Selections")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable5.ChangeCompany('SERCABLE');
                if not FromTable5.Get(Usage, Sequence) then begin
                    FromTable5.TransferFields("Cartera Report Selections");
                    FromTable5.Insert();
                end;
            end;
        }
        dataitem(Customer; Customer)
        {
            trigger OnAfterGetRecord()
            begin
                FromTable6.ChangeCompany('SERCABLE');
                if not FromTable6.Get("No.") then begin
                    FromTable6.TransferFields(Customer);
                    FromTable6.Insert();
                end;
            end;
        }
        dataitem("Default Dimension Priority"; "Default Dimension Priority")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable7.ChangeCompany('SERCABLE');

                if not FromTable7.Get("Source Code", "Table ID") then begin
                    FromTable7.TransferFields("Default Dimension Priority");
                    FromTable7.Insert();
                end;
            end;
        }
        dataitem(Dimension; Dimension)
        {
            trigger OnAfterGetRecord()
            begin
                FromTable8.ChangeCompany('SERCABLE');
                if not FromTable8.Get(Code) then begin
                    FromTable8.TransferFields(Dimension);
                    FromTable8.Insert();
                end;
            end;
        }
        dataitem("Dimension Value"; "Dimension Value")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable9.ChangeCompany('SERCABLE');
                if not FromTable9.Get("Dimension Code", Code) then begin
                    FromTable9.TransferFields("Dimension Value");
                    FromTable9.Insert();
                end;
            end;
        }
        dataitem("Employee Contract"; "Employee Contract")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable10.ChangeCompany('SERCABLE');
                if not FromTable10.Get(Employee, "No.") then begin
                    FromTable10.TransferFields("Employee Contract");
                    FromTable10.Insert();
                end;
            end;
        }
        dataitem("Employee internal historic"; "Employee internal historic_LDR")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable11.ChangeCompany('SERCABLE');
                if not FromTable11.GET("Employee No.", "Start Date") then begin
                    FromTable11.TransferFields("Employee internal historic");
                    FromTable11.Insert();
                end;
            end;
        }
        dataitem("FA Date Type"; "FA Date Type")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable12.ChangeCompany('SERCABLE');
                if not FromTable12.Get("FA Date Type No.", "FA Date Type Name") then begin
                    FromTable12.TransferFields("FA Date Type");
                    FromTable12.Insert();
                end;
            end;
        }
        dataitem("G/l Account"; "G/L Account")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable13.ChangeCompany('SERCABLE');
                if not FromTable13.Get("No.") then begin
                    FromTable13.TransferFields("G/l Account");
                    FromTable13.Insert();
                end;
            end;
        }
        dataitem("G/L Budget Entry"; "G/L Budget Entry")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable14.ChangeCompany('SERCABLE');
                if not FromTable14.Get("Entry No.") then begin
                    FromTable14.TransferFields("G/L Budget Entry");
                    FromTable14.Insert();
                end;
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable15.ChangeCompany('SERCABLE');
                if not FromTable15.Get("Entry No.") then begin
                    FromTable15.TransferFields("G/L Entry");
                    FromTable15.Insert();
                end;
            end;
        }
        dataitem("G/L Register"; "G/L Register")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable16.ChangeCompany('SERCABLE');
                if not FromTable16.Get("No.") then begin
                    FromTable16.TransferFields("G/L Register");
                    FromTable16.Insert();
                end;
            end;
        }
        dataitem("IDi Employee"; "IDi Employee_LDR")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable17.ChangeCompany('SERCABLE');
                if not FromTable17.GET("Job No.", Employee) then begin
                    FromTable17.TransferFields("IDi Employee");
                    FromTable17.Insert();
                end;
            end;
        }
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable18.ChangeCompany('SERCABLE');
                if not FromTable18.Get("No.") then begin
                    FromTable18.TransferFields("Purch. Rcpt. Header");
                    FromTable18.Insert();
                end;
            end;
        }
        dataitem("Responsibility Center"; "Responsibility Center")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable19.ChangeCompany('SERCABLE');
                if not FromTable19.Get(Code) then begin
                    FromTable19.TransferFields("Responsibility Center");
                    FromTable19.Insert();
                end;
            end;
        }
        dataitem("Return Receipt Line"; "Return Receipt Line")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable20.ChangeCompany('SERCABLE');
                if not FromTable20.Get("Document No.", "Line No.") then begin
                    FromTable20.TransferFields("Return Receipt Line");
                    FromTable20.Insert();
                end;
            end;
        }
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable21.ChangeCompany('SERCABLE');
                if not FromTable21.Get("No.") then begin
                    FromTable21.TransferFields("Sales Shipment Header");
                    FromTable21.Insert();
                end;
            end;
        }
        dataitem("Selected G/L Accounts"; "Selected G/L Accounts")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable22.ChangeCompany('SERCABLE');
                if not FromTable22.Get("No.") then begin
                    FromTable22.TransferFields("Selected G/L Accounts");
                    FromTable22.Insert();
                end;
            end;
        }
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable23.ChangeCompany('SERCABLE');
                if not FromTable23.Get("No.") then begin
                    FromTable23.TransferFields("Transfer Shipment Header");
                    FromTable23.Insert();
                end;
            end;
        }
        dataitem("User Setup"; "User Setup")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable24.ChangeCompany('SERCABLE');
                if not FromTable24.Get("User ID") then begin
                    FromTable24.TransferFields("User Setup");
                    FromTable24.Insert();
                end;
            end;
        }
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            trigger OnAfterGetRecord()
            begin
                FromTable25.ChangeCompany('SERCABLE');
                if not FromTable25.Get("Entry No.") then begin
                    FromTable25.TransferFields("Vendor Ledger Entry");
                    FromTable25.Insert();
                end;
            end;
        }
    }

    trigger OnPostReport()
    begin
        Message('Finish');
    end;

    trigger OnPreReport()
    begin
        Message('Init');
    end;

    var
        FromTable1: Record "Accounting Period";
        FromTable2: Record "Analysis View Budget Entry";
        FromTable3: Record "Avg. Cost Adjmt. Entry Point";
        FromTable4: Record "Bank Account Ledger Entry";
        FromTable5: Record "Cartera Report Selections";
        FromTable6: Record Customer;
        FromTable7: Record "Default Dimension Priority";
        FromTable8: Record Dimension;
        FromTable9: Record "Dimension Value";
        FromTable10: Record "Employee Contract";
        FromTable11: Record "Employee internal historic_LDR";
        FromTable12: Record "FA Date Type";
        FromTable13: Record "G/L Account";
        FromTable14: Record "G/L Budget Entry";
        FromTable15: Record "G/L Entry";
        FromTable16: Record "G/L Register";
        FromTable17: Record "IDI Employee_LDR";
        FromTable18: Record "Purch. Rcpt. Header";
        FromTable19: Record "Responsibility Center";
        FromTable20: Record "Return Receipt Line";
        FromTable21: Record "Sales Shipment Header";
        FromTable22: Record "Selected G/L Accounts";
        FromTable23: Record "Transfer Shipment Header";
        FromTable24: Record "User Setup";
        FromTable25: Record "Vendor Ledger Entry";
}