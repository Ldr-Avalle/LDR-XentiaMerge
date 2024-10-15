report 50031 "17vs45 v5"
{
    Permissions = tabledata "G/L Entry" = m,
                  tabledata "G/L Register" = im;
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Register"; "G/L Register")
        {

            trigger OnAfterGetRecord()
            var
                regMovCont: Record "G/L Entry";
                regMovCont2: Record "G/L Entry";
                T45: Record "G/L Register";
                NumMov: Integer;
            begin
                regMovCont.Reset();
                regMovCont.SetCurrentKey("Transaction No.");
                regMovCont.SetRange("Transaction No.", "G/L Register"."No.");
                if regMovCont.FindSet() then begin
                    NumMov := regMovCont."Entry No.";
                    repeat
                        if regMovCont."Entry No." <> NumMov then begin
                            "G/L Register"."To Entry No." := NumMov - 1;
                            "G/L Register".Modify();

                            gblUltimoAsiento += 1;
                            Clear(T45);
                            T45."No." := gblUltimoAsiento;
                            T45."From Entry No." := regMovCont."Entry No.";
                            repeat
                                regMovCont2 := regMovCont;
                                regMovCont2."Transaction No." := gblUltimoAsiento;
                                regMovCont2.Modify();
                            until regMovCont.Next() = 0;

                            T45."To Entry No." := regMovCont."Entry No.";
                            T45."Creation Date" := "Creation Date";
                            T45."Source Code" := regMovCont."Source Code";
                            T45."User ID" := regMovCont."User ID";
                            T45."Journal Batch Name" := regMovCont."Journal Batch Name";
                            T45."Posting Date" := regMovCont."Posting Date";
                            T45.Insert();

                            gblCont += 1;
                        end;
                        NumMov += 1;
                    until regMovCont.Next() = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Error('xx');
                Message('Se han insertado %1 contenedores', gblCont);
            end;
        }
    }

    trigger OnPreReport()
    begin
        gblT17.LockTable();
        gblT45.LockTable();
        gblT45.FindLast();
        gblUltimoAsiento := gblT45."No.";
    end;

    var
        gblCont: Integer;
        gblUltimoAsiento: Integer;
        gblT17: Record "G/L Entry";
        gblT45: Record "G/L Register";
}

