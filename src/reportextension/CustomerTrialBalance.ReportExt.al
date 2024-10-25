reportextension 50001 "Customer - Trial Balance" extends "Customer - Trial Balance"
{
    dataset
    {
        modify(customer)
        {
            CalcFields = "Net Change", "Net Change (LCY)", "Invoice Amounts";
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './src/layout/Customer - Trial Balance.rdl';
        }
    }
}