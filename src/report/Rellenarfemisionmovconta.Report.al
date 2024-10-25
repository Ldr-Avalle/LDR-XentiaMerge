report 50099 "Rellenar f. emision mov conta"
{
    ApplicationArea = All;
    Caption = 'Rellenar f. emision mov conta';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            trigger OnAfterGetRecord()
            begin
                "G/L Entry".Reset();
                "G/L Entry".SetRange("Posting Date", 0D);

                if "G/L Entry".FindSet() then
                    if ("G/L Entry"."Document Date" = 0D) then
                        repeat
                            "G/L Entry"."Document Date" := "G/L Entry"."Posting Date";
                            "G/L Entry".Modify();
                        until "G/L Entry".Next() = 0;
            end;
        }
    }
}