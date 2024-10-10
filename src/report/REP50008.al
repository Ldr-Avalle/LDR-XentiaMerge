report 50008 "Renumera Reg. movs CONTA"
{
    Permissions = TableData 45 = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                RegMovCont.SETFILTER(RegMovCont."No.", '%1..', 186728);
                IF RegMovCont.FINDLAST THEN
                    REPEAT
                        window.UPDATE(1, RegMovCont."No.");
                        RegMovCont.RENAME(RegMovCont."No." + 13);
                    UNTIL RegMovCont.NEXT(-1) = 0;
            end;

            trigger OnPostDataItem()
            begin
                window.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                window.OPEN('Renumerando Registros movs. contabilidad ##1######');
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
        RegMovCont: Record "45";
        window: Dialog;
}

