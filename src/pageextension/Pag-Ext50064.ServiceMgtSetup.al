pageextension 50064 "Service Mgt. Setup" extends "Service Mgt. Setup"
{
    layout
    {
        addafter("Prepaid Posting Document Nos.")
        {
            group(Sercable)
            {
                Caption = 'Sercable';
                field("Contract Nos."; Rec."Contract Nos.")
                {
                    ApplicationArea = All;
                }
                field("Promotion Nos."; Rec."Promotion Nos.")
                {
                    ApplicationArea = All;
                }
                field("County Nos."; Rec."County Nos.")
                {
                    ApplicationArea = All;
                }
                field(lblTelecable; lblTelecable)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("TC Contract List ID"; Rec."TC Contract List ID")
                {
                    ApplicationArea = All;
                }
                field("TC Contract List URL"; Rec."TC Contract List URL")
                {
                    ApplicationArea = All;
                }
                field("TC Cont. Line List ID"; Rec."TC Cont. Line List ID")
                {
                    ApplicationArea = All;
                }
                field("TC Cont. Line List URL"; Rec."TC Cont. Line List URL")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        lblTelecable: Label 'TELECABLE:';
}
