report 50011 Delete
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Delete.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = where(Number = const(1));

            trigger OnPostDataItem()
            begin
                Message('Finish');
            end;

            trigger OnPreDataItem()
            begin
                Message('Init');
                GLEntry.DeleteAll();
            end;
        }
    }

    var
        GLEntry: Record "G/L Entry";
}

