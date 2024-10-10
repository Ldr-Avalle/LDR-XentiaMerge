report 50031 "17vs45 v5"
{
    Permissions = TableData 17=m,
                  TableData 45=im;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000001;Table45)
        {

            trigger OnAfterGetRecord()
            var
                regMovCont: Record "17";
                regMovCont2: Record "17";
                T45: Record "45";
                NumMov: Integer;
            begin
                regMovCont.RESET;
                regMovCont.SETCURRENTKEY("Transaction No.");
                regMovCont.SETRANGE("Transaction No.", "G/L Register"."No.");
                IF regMovCont.FINDSET THEN BEGIN
                  NumMov := regMovCont."Entry No.";
                  REPEAT
                    IF regMovCont."Entry No." <> NumMov THEN
                    BEGIN
                      "G/L Register"."To Entry No." := NumMov - 1;
                      "G/L Register".MODIFY;

                      gblUltimoAsiento += 1;
                      CLEAR(T45);
                      T45."No." := gblUltimoAsiento;
                      T45."From Entry No." := regMovCont."Entry No.";
                      REPEAT
                        regMovCont2 := regMovCont;
                        regMovCont2."Transaction No." := gblUltimoAsiento;
                        regMovCont2.MODIFY;
                      UNTIL regMovCont.NEXT = 0;

                      T45."To Entry No." := regMovCont."Entry No.";
                      T45."Creation Date" := "Creation Date";
                      T45."Source Code" := regMovCont."Source Code";
                      T45."User ID" := regMovCont."User ID";
                      T45."Journal Batch Name" := regMovCont."Journal Batch Name";
                      // t45."From VAT Entry No." := TraePrimerMovIva();
                      // t45."To VAT Entry No." := TraeUltMovIva();
                      T45."Posting Date" := regMovCont."Posting Date";
                      T45.INSERT;

                      gblCont += 1;
                    END;
                    NumMov += 1;
                  UNTIL regMovCont.NEXT = 0;
                END;
            end;

            trigger OnPostDataItem()
            begin
                ERROR('xx');
                MESSAGE('Se han insertado %1 contenedores', gblCont);
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
        gblT17.LOCKTABLE();
        gblT45.LOCKTABLE();
        gblT45.FINDLAST;
        gblUltimoAsiento := gblT45."No.";
    end;

    var
        gblCont: Integer;
        gblUltimoAsiento: Integer;
        gblT17: Record "17";
        gblT45: Record "45";
}

