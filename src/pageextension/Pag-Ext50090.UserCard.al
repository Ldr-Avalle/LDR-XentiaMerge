pageextension 50090 "User Card" extends "User Card"
{
    actions
    {
        addafter(ChangeWebServiceAccessKey)
        {
            action(Dimension)
            {
                Caption = 'Dimension';
                RunObject = Page 540;
                RunPageLink = "Table ID" = CONST(2000000120), "No." = field("User Name");
                Image = Dimensions;
            }
        }
    }
}
