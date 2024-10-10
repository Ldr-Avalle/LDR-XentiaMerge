codeunit 50003 "renumerar asientos"
{
    Permissions = tabledata "G/L Entry" = rimd;

    trigger OnRun()
    VAR
        GLEntry: Record 17;
    BEGIN
        //Editar Movs contabilidad:

        GLEntry.GET(587290);
        GLEntry."G/L Account No." := '540000000';
        GLEntry.MODIFY;

        GLEntry.GET(769282);
        GLEntry."G/L Account No." := '540000000';
        GLEntry.MODIFY;

        GLEntry.GET(845615);
        GLEntry."G/L Account No." := '540000000';
        GLEntry.MODIFY;

        GLEntry.GET(845618);
        GLEntry."G/L Account No." := '540000000';
        GLEntry.MODIFY;



        MESSAGE('ok');
        /*
        CLEAR(r45);
        r45.SETRANGE("No.",139430,178711);
        IF r45.FINDSET THEN REPEAT
          CLEAR(r17);
          r17.SETRANGE("Entry No.",r45."From Entry No.",r45."To Entry No.");
          r17.MODIFYALL("Transaction No.",r45."No.");
        UNTIL r45.NEXT=0;AF000468
        */
        /*
        FALedgerEntry.SETFILTER("FA No.",'<>AF000468');

        IF FALedgerEntry.FINDSET(TRUE,TRUE) THEN BEGIN
          REPEAT
            IF FALedgerEntry."Reversed by Entry No." = 4670 THEN BEGIN
              FALedgerEntry."Reversed by Entry No." := 0;
              FALedgerEntry.MODIFY(FALSE);
            END;
            IF FALedgerEntry."Reversed Entry No." = 4670 THEN BEGIN
              FALedgerEntry."Reversed Entry No."  := 0;
              FALedgerEntry.MODIFY(FALSE);
            END;
          UNTIL FALedgerEntry.NEXT = 0;
        END;
        MESSAGE('ok');
          Progreso := 0;
          VentanaNotificacion.OPEN('#1##########################\\Progreso\\@2@@@@@@@@@@@@@@@@@@@@@@@@@',Progreso);

        IF GLEntry.FINDSET(TRUE,TRUE) THEN BEGIN
          REPEAT
            TotalLine :=  GLEntry.COUNT;
            GLEntry2.RESET;
            CLEAR(GLEntry2);
            GLEntry2.SETRANGE("Transaction No.",GLEntry."Transaction No.");
            IF GLEntry2.FINDSET(TRUE,TRUE) THEN BEGIN
              REPEAT
                IF GLEntry."Document No." <> GLEntry2."Document No." THEN BEGIN
                  PossibleRepeat."Entry No." := GLEntry."Entry No.";
                  PossibleRepeat."Transaction No." := GLEntry."Transaction No.";
                  PossibleRepeat."Document No." := GLEntry."Document No.";
                   PossibleRepeat.insert;
                   COMMIT;
                END;
              UNTIL GLEntry2.NEXT = 0;
            END;
            Progreso := ROUND(CurrLine/TotalLine*10000,1);
            CurrLine += 1;
            VentanaNotificacion.UPDATE(2,Progreso);
          UNTIL GLEntry.NEXT = 0;
        END;
        VentanaNotificacion.CLOSE;
        MESSAGE('ok');
        */
    END;
}
