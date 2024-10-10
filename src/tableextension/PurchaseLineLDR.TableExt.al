tableextension 50244 PurchaseLine_LDR extends "Purchase Line"
{
    fields
    {
        modify(Description)
        {
            Description = 'SERCABLE';
        }
        modify("Description 2")
        {
            Description = 'SERCABLE';
        }
        modify("Shortcut Dimension 1 Code")
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        modify("Shortcut Dimension 2 Code")
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Area")
        {
            Caption = 'Area';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'VAT Bus. Posting Group';
        }
        modify("VAT Prod. Posting Group")
        {
            Caption = 'VAT Prod. Posting Group';
        }
        modify("Job Planning Line No.")
        {
            Caption = 'Job Planning Line No.';
        }
        field(50005; Retenible; Boolean)
        {
            Description = 'Indica si la línea está sujeta a retención o no';
            trigger OnValidate()
            begin
                if (Type <> Type::"G/L Account") then
                    Error('Solo pueden estar sujetas a retención las líneas de Cuenta');
            end;
        }
    }
    keys
    {
        key(Key25; "Document Type", "Shortcut Dimension 1 Code", "No.", Type, "Expected Receipt Date")
        {
            SumIndexFields = "Outstanding Qty. (Base)";
        }
    }

    local procedure CheckReservationDateConflict(DateFieldNo: Integer)
    var
        ReservEntry: Record "Reservation Entry";
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
    begin
        if CurrFieldNo = DateFieldNo then
            if PurchLineReserve.FindReservEntry(Rec, ReservEntry) then begin
                ReservEntry.SetFilter("Shipment Date", '<%1', "Expected Receipt Date");
                if not ReservEntry.IsEmpty then
                    if not Confirm(DataConflictQst) then
                        Error('');
            end;
    end;

    var
        gbldimensiones: Record "User Dimensions_LDR";
        DataConflictQst: Label 'The change creates a date conflict with existing reservations. Do you want to continue?';
}