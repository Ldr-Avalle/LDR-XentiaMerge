tableextension 50042 SalesInvoiceLine_LDR extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "Serial No."; Code[20])
        {
            Description = 'SERCABLE';
        }
        field(50091; TipoNoExenta; Option)
        {
            Description = 'TBAI_AL_01 TipoNoExenta';
            OptionCaption = '';
            OptionMembers = TbaiTipoNoExenta;
        }
    }
    keys
    {
        // key(Key12; "VAT Prod. Posting Group")
        // {
        // }
    }
}