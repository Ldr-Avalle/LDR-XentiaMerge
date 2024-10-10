codeunit 50004 "Nº Asientos erroneos"
{
    trigger OnRun()
    var
        GLEntry: Record "G/L Entry";
        PossibleRepeat: Record "G/L Register2_LDR";
        GLEntry2: Record "G/L Entry";
        VentanaNotificacion: Dialog;
        Progreso: Integer;
        CurrLine: Integer;
        TotalLine: Integer;
    begin
        Progreso := 0;
        VentanaNotificacion.Open('#1##########################\\Progreso\\@2@@@@@@@@@@@@@@@@@@@@@@@@@', Progreso);

        if GLEntry.FindSet() then
            repeat
                TotalLine := GLEntry.Count;
                GLEntry2.Reset();
                Clear(GLEntry2);
                GLEntry2.SetRange("Transaction No.", GLEntry."Transaction No.");
                if GLEntry2.FindSet() then
                    repeat
                        if GLEntry."Document No." <> GLEntry2."Document No." then begin
                            PossibleRepeat."No." := GLEntry."Entry No.";
                            PossibleRepeat."From Entry No." := GLEntry."Transaction No.";
                            //TODO: esta línea no tiene sentido, no se puede asignar un valor de texto a un campo de tipo entero
                            //PossibleRepeat."To Entry No." := GLEntry."Document No.";
                            PossibleRepeat."To Entry No." := GLEntry."Transaction No.";
                            PossibleRepeat.Insert();
                            Commit();
                        end;
                    until GLEntry2.Next() = 0;
                Progreso := Round(CurrLine / TotalLine * 10000, 1);
                CurrLine += 1;
                VentanaNotificacion.Update(2, Progreso);
            until GLEntry.Next() = 0;
        VentanaNotificacion.Close();
        Message('ok');
    end;
}
