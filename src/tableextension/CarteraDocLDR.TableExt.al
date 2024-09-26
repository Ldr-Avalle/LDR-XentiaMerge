tableextension 50009 "Cartera Doc._LDR" extends "Cartera Doc."
{
    fields
    {
        //TODO: Revisar si se salta el insert al pasar el valor por defecto a este campo, 
        //TODO: Tengo el código implementado en la codeunit de eventos
        field(50000; Type_LDR; Enum "Cartera Document Type")
        {
            DataClassification = ToBeClassified;
        }
    }

    //TODO: Sustituir por la función del estandar en donde sea necesario, preguntar a Fran
    procedure UpdatePaymentMethodCode_LDR(DocumentNo: Code[20]; AccountNo: Code[20]; BillNo: Code[20]; PaymentMethodCode: Code[10])
    var
        CarteraDoc: Record "Cartera Doc.";
    begin
        CarteraDoc.SetRange("Document No.", DocumentNo);
        CarteraDoc.SetRange("Account No.", AccountNo);
        CarteraDoc.SetRange("No.", BillNo);
        if CarteraDoc.FindFirst() and (CarteraDoc."Bill Gr./Pmt. Order No." = '') then begin
            CarteraDoc.Validate("Payment Method Code", PaymentMethodCode);
            CarteraDoc.Modify(true);
        end;
    end;
}