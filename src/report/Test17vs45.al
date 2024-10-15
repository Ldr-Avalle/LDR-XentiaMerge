report 50030 "Test 17vs45"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Test 17vs45.rdl';

    dataset
    {
        dataitem("G/L Register"; "G/L Register")
        {
            column(No_GLRegister; "G/L Register"."No.")
            {
            }
            column(FromEntryNo_GLRegister; "G/L Register"."From Entry No.")
            {
            }
            column(ToEntryNo_GLRegister; "G/L Register"."To Entry No.")
            {
            }
            column(salto; Salto)
            {
            }

            trigger OnAfterGetRecord()
            begin
                regMovCont.Reset();
                regMovCont.SetCurrentKey("Transaction No.");
                regMovCont.SetRange("Transaction No.", "G/L Register"."No.");
                if regMovCont.FindSet() then begin
                    primer := regMovCont."Entry No.";
                    regMovCont.FindLast();
                    ultimo := regMovCont."Entry No.";

                    if (ultimo - primer + 1) = regMovCont.Count then
                        CurrReport.Skip();
                end;
            end;
        }
    }

    var
        n: Integer;
        primer: Integer;
        ultimo: Integer;
        regMovCont: Record "G/L Entry";
        Salto: Integer;
}

