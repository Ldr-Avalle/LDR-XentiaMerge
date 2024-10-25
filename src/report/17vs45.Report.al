report 50029 "17vs45"
{
    ApplicationArea = All;
    Caption = '17vs45';
    Permissions = tabledata "G/L Register" = rimd,
                  tabledata "G/L Register CP2_LDR" = rimd;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Register"; "G/L Register")
        {
            trigger OnAfterGetRecord()
            var
                regContenedorCP: Record "G/L Register CP_LDR";
                T17: Record "G/L Entry";
                NumAsiento: Integer;
            begin
                i += 1;
                v.Update(1, Round(i / n * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                DeleteAll();
            end;

            trigger OnPreDataItem()
            begin
                n := Count;
                v.Open('@1@@@@@@@@@@@@@@@@@@@\' +
                       '@2@@@@@@@@@@@@@@@@@@@');
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = sorting("Transaction No.");

            trigger OnAfterGetRecord()
            var
                t45: Record "G/L Register";
            begin
                i += 1;
                v.Update(2, Round(i / n * 10000, 1));

                t45."No." := "Transaction No.";
                t45."From Entry No." := "G/L Entry"."Entry No.";

                SetRange("Transaction No.", "Transaction No.");
                FindLast();
                SetRange("Transaction No.");

                t45."To Entry No." := "G/L Entry"."Entry No.";
                t45."Creation Date" := TraeFechaCreacion(t45."From Entry No.", t45."To Entry No.", "G/L Entry");
                t45."Source Code" := "G/L Entry"."Source Code";
                t45."User ID" := "G/L Entry"."User ID";
                t45."Journal Batch Name" := "G/L Entry"."Journal Batch Name";
                t45."From VAT Entry No." := TraePrimerMovIva();
                t45."To VAT Entry No." := TraeUltMovIva();
                t45."Posting Date" := "G/L Entry"."Posting Date";
                t45.Insert();
            end;

            trigger OnPreDataItem()
            begin
                n := Count;
                i := 0;
            end;
        }
    }

    trigger OnPreReport()
    begin
        gblT17.LockTable();
        gblT45.LockTable();
    end;

    var
        gblT45: Record "G/L Register";
        gblT17: Record "G/L Entry";
        i: Integer;
        n: Integer;
        v: Dialog;

    local procedure TraePrimerMovIva(): Integer
    var
        regMovIva: Record "VAT Entry";
    begin
        regMovIva.Reset();
        regMovIva.SetCurrentKey("Document No.");
        regMovIva.SetRange("Document No.", "G/L Entry"."Document No.");
        regMovIva.SetRange("Posting Date", "G/L Entry"."Posting Date");
        if regMovIva.Find('-') then
            exit(regMovIva."Entry No.");

        exit(0);
    end;

    local procedure TraeUltMovIva(): Integer
    var
        regMovIva: Record "VAT Entry";
    begin
        regMovIva.Reset();
        regMovIva.SetCurrentKey("Document No.");
        regMovIva.SetRange("Document No.", "G/L Entry"."Document No.");
        regMovIva.SetRange("Posting Date", "G/L Entry"."Posting Date");
        if regMovIva.Find('+') then
            exit(regMovIva."Entry No.");
    end;

    local procedure TraeFechaCreacion(desde: Integer; hasta: Integer; regMovCont: Record "G/L Entry"): Date
    var
        regContenedorCP: Record "G/L Register CP_LDR";
    begin
        regContenedorCP.Reset();
        regContenedorCP.SetCurrentKey("From Entry No.");
        regContenedorCP.SetRange("From Entry No.", desde);
        regContenedorCP.SetRange("To Entry No.", hasta);
        if not regContenedorCP.Find('-') then begin
            regContenedorCP.SetRange("To Entry No.");
            if not regContenedorCP.Find('-') then begin
                regContenedorCP.Reset();
                regContenedorCP.SetCurrentKey("To Entry No.");
                regContenedorCP.SetRange("From Entry No.");
                regContenedorCP.SetRange("To Entry No.", hasta);
                if not regContenedorCP.Find('-') then
                    exit(0D);
            end;
        end;

        exit(regContenedorCP."Creation Date");
    end;
}