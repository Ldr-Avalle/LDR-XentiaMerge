tableextension 50080 SalespersonPurchaser_LDR extends "Salesperson/Purchaser"
{
    fields
    {
        modify("E-Mail")
        {
            trigger OnAfterValidate()
            begin
                if "E-Mail" <> xRec."E-Mail" then
                    "E-Mail 2" := "E-Mail";
            end;
        }
    }
}
