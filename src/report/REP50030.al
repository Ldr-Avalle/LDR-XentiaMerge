report 50030 "Test 17vs45"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Test 17vs45.rdlc';

    dataset
    {
        dataitem(DataItem1000000001;Table45)
        {
            column(No_GLRegister;"G/L Register"."No.")
            {
            }
            column(FromEntryNo_GLRegister;"G/L Register"."From Entry No.")
            {
            }
            column(ToEntryNo_GLRegister;"G/L Register"."To Entry No.")
            {
            }
            column(salto;Salto)
            {
            }

            trigger OnAfterGetRecord()
            begin
                regMovCont.RESET;
                regMovCont.SETCURRENTKEY("Transaction No.");
                regMovCont.SETRANGE("Transaction No.", "G/L Register"."No.");
                IF regMovCont.FINDSET THEN BEGIN
                  primer := regMovCont."Entry No.";
                  regMovCont.FINDLAST;
                  ultimo := regMovCont."Entry No.";
                
                  IF (ultimo - primer + 1) = regMovCont.COUNT THEN
                    CurrReport.SKIP;
                END;
                
                /*
                regMovCont.SETRANGE("Entry No.","From Entry No.","To Entry No.");
                IF regMovCont.FIND('-') THEN
                  IF ("G/L Register"."No." - regMovCont."Transaction No.") = Salto THEN
                    CurrReport.SKIP;
                
                Salto := "G/L Register"."No." - regMovCont."Transaction No.";
                */

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

    var
        n: Integer;
        primer: Integer;
        ultimo: Integer;
        regMovCont: Record "17";
        Salto: Integer;
}

