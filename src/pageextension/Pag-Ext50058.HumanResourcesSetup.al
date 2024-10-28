pageextension 50058 "Human Resources Setup" extends "Human Resources Setup"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("Employee Contract Nos."; Rec."Employee Contract Nos.")
            {
                ApplicationArea = All;
            }
            field("Delete employee contracts"; Rec."Delete employee contracts")
            {
                ApplicationArea = All;
            }
            field("Notificate new Company E-mail"; Rec."Notificate new Company E-mail")
            {
                ApplicationArea = All;
            }
            field("Notification email"; Rec."Notification email")
            {
                ApplicationArea = All;
            }
            field("Notification email title"; Rec."Notification email title")
            {
                ApplicationArea = All;
            }
            field("Default male path image"; Rec."Default male path image")
            {
                ApplicationArea = All;
            }
            field("Default female path image"; Rec."Default female path image")
            {
                ApplicationArea = All;
            }
        }
    }
}
