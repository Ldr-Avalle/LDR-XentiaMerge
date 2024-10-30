pageextension 50090 "User Card_LDR" extends "User Card"
{
    actions
    {
        addafter(ChangeWebServiceAccessKey)
        {
            action(Dimension_LDR)
            {
                Caption = 'Dimension';
                RunObject = page "Default Dimensions";
                RunPageLink = "Table ID" = const(2000000120), "No." = field("User Name");
                Image = Dimensions;
                ApplicationArea = All;
            }
        }
    }
}
