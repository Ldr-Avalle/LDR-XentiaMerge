report 50029 "17vs45"
{
    Permissions = TableData 45 = rimd,
                  TableData 50029 = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Register"; "G/L Register")
        {

            trigger OnAfterGetRecord()
            var
                regContenedorCP: Record "50005";
                T17: Record "17";
                NumAsiento: Integer;
            begin

                i += 1;
                v.UPDATE(1, ROUND(i / n * 10000, 1));

                //regContenedorCP.TRANSFERFIELDS("G/L Register");
                //regContenedorCP.INSERT;
            end;

            trigger OnPostDataItem()
            begin
                DELETEALL;
            end;

            trigger OnPreDataItem()
            begin

                n := COUNT;
                v.OPEN('@1@@@@@@@@@@@@@@@@@@@\' +
                       '@2@@@@@@@@@@@@@@@@@@@');
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Transaction No.");

            trigger OnAfterGetRecord()
            var
                t45: Record "45";
            begin

                i += 1;
                v.UPDATE(2, ROUND(i / n * 10000, 1));


                t45."No." := "Transaction No.";
                t45."From Entry No." := "G/L Entry"."Entry No.";


                SETRANGE("Transaction No.", "Transaction No.");
                FINDLAST;
                SETRANGE("Transaction No.");

                t45."To Entry No." := "G/L Entry"."Entry No.";
                t45."Creation Date" := TraeFechaCreacion(t45."From Entry No.", t45."To Entry No.", "G/L Entry");
                t45."Source Code" := "G/L Entry"."Source Code";
                t45."User ID" := "G/L Entry"."User ID";
                t45."Journal Batch Name" := "G/L Entry"."Journal Batch Name";
                t45."From VAT Entry No." := TraePrimerMovIva();
                t45."To VAT Entry No." := TraeUltMovIva();
                t45."Posting Date" := "G/L Entry"."Posting Date";
                t45.INSERT;
            end;

            trigger OnPreDataItem()
            begin

                n := COUNT;
                i := 0;
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

    trigger OnPreReport()
    begin
        gblT17.LOCKTABLE;
        gblT45.LOCKTABLE;
    end;

    var
        i: Integer;
        n: Integer;
        v: Dialog;
        gblT45: Record "45";
        gblT17: Record "17";

    local procedure TraePrimerMovIva(): Integer
    var
        regMovIva: Record "254";
    begin

        regMovIva.RESET;
        regMovIva.SETCURRENTKEY("Document No.");
        regMovIva.SETRANGE("Document No.", "G/L Entry"."Document No.");
        regMovIva.SETRANGE("Posting Date", "G/L Entry"."Posting Date");
        IF regMovIva.FIND('-') THEN
            EXIT(regMovIva."Entry No.");

        EXIT(0);
    end;

    local procedure TraeUltMovIva(): Integer
    var
        regMovIva: Record "254";
    begin

        regMovIva.RESET;
        regMovIva.SETCURRENTKEY("Document No.");
        regMovIva.SETRANGE("Document No.", "G/L Entry"."Document No.");
        regMovIva.SETRANGE("Posting Date", "G/L Entry"."Posting Date");
        IF regMovIva.FIND('+') THEN
            EXIT(regMovIva."Entry No.");
    end;

    local procedure TraeFechaCreacion(desde: Integer; hasta: Integer; regMovCont: Record "17"): Date
    var
        regContenedorCP: Record "50005";
    begin

        regContenedorCP.RESET;
        regContenedorCP.SETCURRENTKEY("From Entry No.");
        regContenedorCP.SETRANGE("From Entry No.", desde);
        regContenedorCP.SETRANGE("To Entry No.", hasta);
        IF NOT regContenedorCP.FIND('-') THEN BEGIN
            regContenedorCP.SETRANGE("To Entry No.");
            IF NOT regContenedorCP.FIND('-') THEN BEGIN
                regContenedorCP.RESET;
                regContenedorCP.SETCURRENTKEY("To Entry No.");
                regContenedorCP.SETRANGE("From Entry No.");
                regContenedorCP.SETRANGE("To Entry No.", hasta);
                IF NOT regContenedorCP.FIND('-') THEN
                    EXIT(0D);
                //      ERROR('%1-%2',desde,hasta);
            END;
        END;

        EXIT(regContenedorCP."Creation Date");
    end;
}

