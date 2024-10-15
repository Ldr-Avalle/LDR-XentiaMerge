report 50008 "Renumera Reg. movs CONTA"
{
    Permissions = tabledata "G/L Register" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number)
                                where(Number = const(1));

            trigger OnAfterGetRecord()
            begin
                RegMovCont.SetFilter(RegMovCont."No.", '%1..', 186728);
                if RegMovCont.FindLast() then
                    repeat
                        window.Update(1, RegMovCont."No.");
                        RegMovCont.Rename(RegMovCont."No." + 13);
                    until RegMovCont.Next(-1) = 0;
            end;

            trigger OnPostDataItem()
            begin
                window.Close();
            end;

            trigger OnPreDataItem()
            begin
                window.Open('Renumerando Registros movs. contabilidad ##1######');
            end;
        }
    }

    var
        RegMovCont: Record "G/L Register";
        window: Dialog;
}

