report 50097 "pasar fechas en mov af"
{
    ApplicationArea = All;
    Caption = 'pasar fechas en mov af';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("FA Ledger Entry"; "FA Ledger Entry")
        {
            trigger OnAfterGetRecord()
            begin
                "FA Ledger Entry".Reset();
                "FA Ledger Entry".SetRange("FA Posting Type", "FA Posting Type"::Depreciation);
                "FA Ledger Entry".SetRange("G/L Entry No.", 0);
                if "FA Ledger Entry".FindSet() then
                    repeat
                        "FA Ledger Entry"."FA Posting Date" := 20171228D;
                        "FA Ledger Entry"."Posting Date" := 20171228D;
                        "FA Ledger Entry"."Document Date" := 20171228D;
                        "FA Ledger Entry".Modify();
                    until "FA Ledger Entry".Next() = 0;
            end;
        }
    }
}