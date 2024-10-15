report 50097 "pasar fechas en mov af"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("FA Ledger Entry"; "FA Ledger Entry")
        {

            trigger OnAfterGetRecord()
            begin
                "FA Ledger Entry".RESET;
                "FA Ledger Entry".SETRANGE("FA Posting Type", "FA Posting Type"::Depreciation);
                "FA Ledger Entry".SETRANGE("G/L Entry No.", 0);
                IF "FA Ledger Entry".FINDSET THEN BEGIN
                    //IF ("FA Ledger Entry"."FA Posting Type"="FA Ledger Entry"."FA Posting Type"::Depreciation) THEN
                    REPEAT
                        "FA Ledger Entry"."FA Posting Date" := 20171228D;
                        "FA Ledger Entry"."Posting Date" := 20171228D;
                        "FA Ledger Entry"."Document Date" := 20171228D;
                        "FA Ledger Entry".MODIFY;
                    UNTIL "FA Ledger Entry".NEXT = 0;

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
}

