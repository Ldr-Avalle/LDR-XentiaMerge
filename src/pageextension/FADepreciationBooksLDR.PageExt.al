pageextension 50061 "FA Depreciation Books_LDR" extends "FA Depreciation Books"
{
    layout
    {
        addafter("No. of Depreciation Months")
        {
            field("Acquisition Cost_LDR"; Rec."Acquisition Cost")
            {
                ApplicationArea = All;
            }
            field(Depreciation_LDR; Rec.Depreciation)
            {
                ApplicationArea = All;
            }
        }
    }
}
