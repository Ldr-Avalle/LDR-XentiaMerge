codeunit 50000 "EventosTablas_LDR"
{
    #region table 13 "Salesperson/Purchaser"
    [EventSubscriber(ObjectType::Table, Database::"Salesperson/Purchaser", 'OnAfterValidateEvent', 'E-Mail', true, true)]
    local procedure OnAfterValidateAddress2(var Rec: Record "Salesperson/Purchaser"; var xRec: Record "Salesperson/Purchaser"; CurrFieldNo: Integer)
    begin
        if (Rec."Search E-Mail" = UpperCase(xRec."E-Mail")) or (Rec."Search E-Mail" = '') then
            Rec."Search E-Mail" := Rec."E-Mail";

        if Rec."E-Mail" <> xRec."E-Mail" then
            Rec."E-Mail 2" := Rec."E-Mail";
    end;
    #endregion

    #region table 14 Location
    [EventSubscriber(ObjectType::Table, Database::Location, 'OnBeforeValidateEvent', 'Require Put-away', true, true)]
    local procedure OnBeforeValidateRequirePutAway(var Rec: Record Location; var xRec: Record Location; CurrFieldNo: Integer)
    var
        WhseActivHeader: Record "Warehouse Activity Header";
        WhseRcptHeader: Record "Warehouse Receipt Header";
        Text008: Label '%1 tiene que ser %2, porque uno o más %3 existen.';
        ErrorRequirePutAway: Label 'No se permite activar [Requiere Almacenamiento] en la validación del campo.';
    begin
        if not Rec."Require Put-away" then begin
            WhseRcptHeader.SetRange("Location Code", Rec.Code);
            if not WhseRcptHeader.IsEmpty() then
                Error(Text008, Rec.FieldCaption("Require Put-away"), xRec."Require Put-away", WhseRcptHeader.TableCaption());

            Rec.TestField("Directed Put-away and Pick", false);
            WhseActivHeader.SetRange(Type, WhseActivHeader.Type::"Put-away");
            WhseActivHeader.SetRange("Location Code", Rec.Code);
            if not WhseActivHeader.IsEmpty() then
                Error(Text008, Rec.FieldCaption("Require Put-away"), true, WhseActivHeader.TableCaption());
            Rec."Use Cross-Docking" := false;
            Rec."Cross-Dock Bin Code" := '';
        end else
            Error(ErrorRequirePutAway);
    end;

    [EventSubscriber(ObjectType::Table, Database::Location, 'OnBeforeValidateEvent', 'Require Receive', true, true)]
    local procedure OnBeforeValidateRequireReceive(var Rec: Record Location; var xRec: Record Location; CurrFieldNo: Integer)
    var
        WhseActivHeader: Record "Warehouse Activity Header";
        WhseRcptHeader: Record "Warehouse Receipt Header";
        Text008: Label '%1 tiene que ser %2, porque uno o más %3 existen.';
        ErrorRequireReceive: Label 'No se permite activar [Requiere Recepción] en la validación del campo.';
    begin
        if not Rec."Require Receive" then begin
            Rec.TestField("Directed Put-away and Pick", false);
            WhseRcptHeader.SetRange("Location Code", Rec.Code);
            if not WhseRcptHeader.IsEmpty() then
                Error(Text008, Rec.FieldCaption("Require Receive"), true, WhseRcptHeader.TableCaption());
            Rec."Receipt Bin Code" := '';
            Rec."Use Cross-Docking" := false;
            Rec."Cross-Dock Bin Code" := '';
        end else
            Error(ErrorRequireReceive);
    end;
    #endregion

    #region table 15 "Sales Line"
    [EventSubscriber(ObjectType::Table, Database::"G/L Account", 'OnAfterValidateEvent', 'Income/Balance', true, true)]
    local procedure OnBeforeValidateIncomeBalance(var Rec: Record "G/L Account"; var xRec: Record "G/L Account"; CurrFieldNo: Integer)
    var
        DefDim: Record "Default Dimension";
        TestNo: Integer;
        Text1100001: Label 'La longitud del nuevo valor no es aceptable, ya que implica un cambio en %1.';
    begin
        if (xRec."No." <> '') then
            if (StrLen(Rec."No.") > 5) <> (StrLen(xRec."No.") > 5) then
                Error(Text1100001, Rec.FieldName("Account Type"));

        Evaluate(TestNo, CopyStr(Rec."No.", 1, 1));

        if TestNo in [6 .. 7] then begin
            DefDim.Init();
            DefDim."Table ID" := 15;
            DefDim."No." := Rec."No.";
            DefDim."Dimension Code" := 'Proyecto';
            DefDim."Value Posting" := DefDim."Value Posting"::"Code Mandatory";
            DefDim.Insert();
        end;
    end;
    #endregion

    #region table 17 "G/L Entry"
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure "G/L Entry_OnAfterCopyGLEntryFromGenJnlLine"(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        //GLEntry.FacturaFin := GenJournalLine.FacturaFin; //TODO: Quitar comentario después de añadir campo a la línea de diario
    end;
    #endregion

    #region table 18 Customer"
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterInsertCustomer(var Rec: Record Customer; RunTrigger: Boolean)
    begin
        Rec.Validate("VAT Registration No.", Rec."No.");
        Rec."Gen. Bus. Posting Group" := 'NACIONAL';
        Rec."VAT Bus. Posting Group" := 'NACIONAL';
        Rec."Customer Posting Group" := 'NAC';
        Rec."Country/Region Code" := 'ES';
        Rec."Payment Terms Code" := 'CON';
        Rec.Validate("Prices Including VAT", true);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeValidateEvent', 'No.', true, true)]
    local procedure OnBeforeValidateNo(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    begin
        if xRec."No." = '0' then
            Rec.FieldError("No.");
        Rec.Validate("VAT Registration No.", Rec."No.");
    end;
    #endregion
}