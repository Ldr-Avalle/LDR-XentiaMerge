report 50011 Delete
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Delete.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = WHERE(Number = CONST(1));

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

