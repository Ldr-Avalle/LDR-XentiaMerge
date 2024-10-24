pageextension 50019 "Sales List" extends "Sales List"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    begin
        gbldimensiones.RESET;
        gbldimensiones.SETRANGE(gbldimensiones.Usuario, USERID);
        IF gbldimensiones.FINDFIRST THEN
            rec.SETRANGE("Assigned User ID", USERID);
    end;

    var
        gbldimensiones: Record 50000;
}
