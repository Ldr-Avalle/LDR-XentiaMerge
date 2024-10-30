pageextension 50064 "Service Mgt. Setup_LDR" extends "Service Mgt. Setup"
{
    layout
    {
        addafter("Prepaid Posting Document Nos.")
        {
            group(Sercable_LDR)
            {
                Caption = 'Sercable';
                field("Contract Nos._LDR"; Rec."Contract Nos.")
                {
                    ApplicationArea = All;
                }
                field("Promotion Nos._LDR"; Rec."Promotion Nos.")
                {
                    ApplicationArea = All;
                }
                field("County Nos._LDR"; Rec."County Nos.")
                {
                    ApplicationArea = All;
                }
                field(lblTelecable_LDR; lblTelecable)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("TC Contract List ID_LDR"; Rec."TC Contract List ID")
                {
                    ApplicationArea = All;
                }
                field("TC Contract List URL_LDR"; Rec."TC Contract List URL")
                {
                    ApplicationArea = All;
                }
                field("TC Cont. Line List ID_LDR"; Rec."TC Cont. Line List ID")
                {
                    ApplicationArea = All;
                }
                field("TC Cont. Line List URL_LDR"; Rec."TC Cont. Line List URL")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        lblTelecable: Label 'TELECABLE:';
}
