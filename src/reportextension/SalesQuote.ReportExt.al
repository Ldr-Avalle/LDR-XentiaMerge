reportextension 50002 "Sales - Quote" extends "Standard Sales - Quote"
{
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = './src/layout/Sales - Quote.rdl';
        }
    }
}