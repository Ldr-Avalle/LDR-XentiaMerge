tableextension 50010 "Bill Group_LDR" extends "Bill Group"
{
    //TODO: Sustituir por la función del estandar en donde sea necesario, preguntar a Fran
    procedure ExportToFile_LDR()
    var
        DirectDebitCollection: Record "Direct Debit Collection";
        DirectDebitCollectionEntry: Record "Direct Debit Collection Entry";
        BankAccount: Record "Bank Account";
    begin
        DirectDebitCollection.CreateRecord("No.", "Bank Account No.", "Partner Type");
        DirectDebitCollection."Source Table ID" := Database::"Bill Group";
        DirectDebitCollection.Modify();
        BankAccount.Get("Bank Account No.");
        Commit();
        DirectDebitCollectionEntry.SetRange("Direct Debit Collection No.", DirectDebitCollection."No.");
        RunFileExportCodeunit_LDR(BankAccount.GetDDExportCodeunitID(), DirectDebitCollection."No.", DirectDebitCollectionEntry);
        DeleteDirectDebitCollection_LDR(DirectDebitCollection."No.");
    end;

    procedure RunFileExportCodeunit_LDR(CodeunitID: Integer; DirectDebitCollectionNo: Integer; var DirectDebitCollectionEntry: Record "Direct Debit Collection Entry")
    var
        LastError: Text;
    begin
        if not Codeunit.Run(CodeunitID, DirectDebitCollectionEntry) then begin
            LastError := GetLastErrorText;
            DeleteDirectDebitCollection_LDR(DirectDebitCollectionNo);
            Commit();
            Error(LastError);
        end;
    end;

    procedure DeleteDirectDebitCollection_LDR(DirectDebitCollectionNo: Integer)
    var
        DirectDebitCollection: Record "Direct Debit Collection";
    begin
        if DirectDebitCollection.Get(DirectDebitCollectionNo) then
            DirectDebitCollection.Delete(true);
    end;
}