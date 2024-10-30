pageextension 50019 "Sales List_LDR" extends "Sales List"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Posting No._LDR"; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    begin
        gbldimensiones.Reset;
        gbldimensiones.SetRange(gbldimensiones.Usuario, UserId);
        if gbldimensiones.FindFirst then
            Rec.SetRange("Assigned User ID", UserId);
    end;

    var
        gbldimensiones: Record "User Dimensions_LDR";
}
