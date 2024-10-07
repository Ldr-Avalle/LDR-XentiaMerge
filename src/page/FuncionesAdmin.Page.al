page 50099 "Funciones Admin."
{
    ApplicationArea = All;
    Caption = 'Funciones Admin.', Comment = 'ESP=""';
    PageType = Card;
    SourceTable = Integer;
    UsageCategory = Administration;

    var
        Customer: Record Customer;
        Vendor: Record Vendor;

    procedure concatenar() result: Text[50]
    begin
    end;

    procedure valorMatriz() total: Decimal
    begin
    end;
}