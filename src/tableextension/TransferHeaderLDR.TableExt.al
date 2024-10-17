tableextension 50388 TransferHeader_LDR extends "Transfer Header"
{

    DataCaptionFields = Title;
    fields
    {
        modify("Area")
        {
            Caption = 'Cód. provincia';
        }

        field(50000; Title; Option)
        {
            Description = 'SERCABLE';
            OptionMembers = ," ";
        }
    }

    local procedure ConfirmResvDateConflict()
    var
        ResvEngMgt: Codeunit "99000831";
    begin
        IF ResvEngMgt.ResvExistsForTransHeader(Rec) THEN
            IF NOT CONFIRM(Text005 + Text006, FALSE) THEN
                ERROR('');
    end;

    var
        Text005: Label 'Reservations exist for this order. These reservations will be canceled if a date conflict is caused by this change.\\';
        Text006: Label 'Do you want to continue?';
}
