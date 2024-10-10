report 50006 "Contract clearance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Contract clearance.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table50005)
        {
            dataitem(DataItem1000000001;Table50006)
            {
                DataItemLink = Contract=FIELD(No.);
            }
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
}

