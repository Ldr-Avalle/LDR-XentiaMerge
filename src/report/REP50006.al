report 50006 "Contract clearance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Contract clearance.rdl';

    dataset
    {
        dataitem("G/L Register CP"; "G/L Register CP_LDR")
        {
            dataitem("Contract lines"; "Contract lines_LDR")
            {
                DataItemLink = Contract = FIELD("No.");
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

