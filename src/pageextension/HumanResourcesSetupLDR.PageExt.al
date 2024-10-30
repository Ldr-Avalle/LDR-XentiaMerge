pageextension 50058 "Human Resources Setup_LDR" extends "Human Resources Setup"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("Employee Contract Nos._LDR"; Rec."Employee Contract Nos.")
            {
                ApplicationArea = All;
            }
            field("Delete employee contracts_LDR"; Rec."Delete employee contracts")
            {
                ApplicationArea = All;
            }
            field("Notificate new Company E-mail_LDR"; Rec."Notificate new Company E-mail")
            {
                ApplicationArea = All;
            }
            field("Notification email_LDR"; Rec."Notification email")
            {
                ApplicationArea = All;
            }
            field("Notification email title_LDR"; Rec."Notification email title")
            {
                ApplicationArea = All;
            }
            field("Default male path image_LDR"; Rec."Default male path image")
            {
                ApplicationArea = All;
            }
            field("Default female path image_LDR"; Rec."Default female path image")
            {
                ApplicationArea = All;
            }
        }
    }
}
