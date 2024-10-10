report 50011 Delete
{
    DefaultLayout = RDLC;
    RDLCLayout = './Delete.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table2000000026)
        {
            DataItemTableView = WHERE(Number=CONST(1));

            trigger OnPostDataItem()
            begin
                MESSAGE('Finish');
            end;

            trigger OnPreDataItem()
            begin
                MESSAGE('Init');
                GLEntry.DELETEALL;
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
        GLEntry: Record "17";
}

