report 50006 "Contract clearance"
{
    ApplicationArea = All;
    Caption = 'Contract clearance';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Contract clearance.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Register CP"; "G/L Register CP_LDR")
        {
            dataitem("Contract lines"; "Contract Lines_LDR")
            {
                DataItemLink = Contract = field("No.");
            }
        }
    }
}