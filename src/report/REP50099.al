report 50099 "Rellenar f. emision mov conta"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {

            trigger OnAfterGetRecord()
            begin
                "G/L Entry".RESET;
                //"G/L Entry".SETRANGE("G/L Account No.",'410000000');
                //"G/L Entry".SETRANGE("Document Date",0D);
                "G/L Entry".SETRANGE("Posting Date", 0D);

                IF "G/L Entry".FINDSET THEN BEGIN
                    //IF ("G/L Entry". "G/L Account No." = '410000000')   AND ("G/L Entry"."Document Date" = 0D) THEN
                    IF ("G/L Entry"."Document Date" = 0D) THEN
                        REPEAT
                            "G/L Entry"."Document Date" := "G/L Entry"."Posting Date";
                            "G/L Entry".MODIFY;
                        UNTIL "G/L Entry".NEXT = 0;
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

