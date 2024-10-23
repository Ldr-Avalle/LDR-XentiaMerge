tableextension 50009 "Cartera Doc._LDR" extends "Cartera Doc."
{
    fields
    {
        field(50000; Type_LDR; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Receivable,Payable;
        }
    }
}