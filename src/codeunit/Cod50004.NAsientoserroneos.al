codeunit 50004 "Nº Asientos erroneos"
{
    trigger OnRun()
    VAR
        GLEntry: Record 17;
        PossibleRepeat: Record 50016;
        GLEntry2: Record 17;
        VentanaNotificacion: Dialog;
        Progreso: Integer;
        CurrLine: Integer;
        TotalLine: Integer;
    BEGIN
        Progreso := 0;
        VentanaNotificacion.OPEN('#1##########################\\Progreso\\@2@@@@@@@@@@@@@@@@@@@@@@@@@', Progreso);

        IF GLEntry.FINDSET() THEN BEGIN
            REPEAT
                TotalLine := GLEntry.COUNT;
                GLEntry2.RESET;
                CLEAR(GLEntry2);
                GLEntry2.SETRANGE("Transaction No.", GLEntry."Transaction No.");
                IF GLEntry2.FINDSET() THEN BEGIN
                    REPEAT
                        IF GLEntry."Document No." <> GLEntry2."Document No." THEN BEGIN
                            PossibleRepeat."No." := GLEntry."Entry No.";
                            PossibleRepeat."From Entry No." := GLEntry."Transaction No.";
                            //TODO: esta línea no tiene sentido, no se puede asignar un valor de texto a un campo de tipo entero
                            //PossibleRepeat."To Entry No." := GLEntry."Document No.";
                            PossibleRepeat."To Entry No." := GLEntry."Transaction No.";
                            PossibleRepeat.INSERT;
                            COMMIT;
                        END;
                    UNTIL GLEntry2.NEXT = 0;
                END;
                Progreso := ROUND(CurrLine / TotalLine * 10000, 1);
                CurrLine += 1;
                VentanaNotificacion.UPDATE(2, Progreso);
            UNTIL GLEntry.NEXT = 0;
        END;
        VentanaNotificacion.CLOSE;
        MESSAGE('ok');
    END;
}
