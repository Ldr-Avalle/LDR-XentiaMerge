pageextension 50061 "FA Depreciation Books" extends "FA Depreciation Books"
{
    layout
    {
        addafter("No. of Depreciation Months")
        {
            field("Acquisition Cost"; Rec."Acquisition Cost")
            {
                ApplicationArea = All;
            }
            field(Depreciation; Rec.Depreciation)
            {
                ApplicationArea = All;
            }
        }
    }
}
