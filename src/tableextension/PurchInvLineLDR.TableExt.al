tableextension 50063 "PurchInvLine_LDR" extends "Purch. Inv. Line"
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
        field(50005; Retenible; Boolean)
        {
            Description = 'Indica si la línea está sujeta a retención o no';
            trigger OnValidate()
            begin
                IF (Type <> Type::"G/L Account") THEN ERROR('Solo pueden estar sujetas a retención las líneas de Cuenta');
            end;
        }
    }
    keys
    {
        key(Key7; "VAT Prod. Posting Group")
        {
        }
    }
    //Unsupported feature: Code Modification on "InitFromPurchLine(PROCEDURE 12)".
    //procedure InitFromPurchLine();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    INIT;
    TRANSFERFIELDS(PurchLine);
    IF ("No." = '') AND (Type IN [Type::"G/L Account"..Type::"Charge (Item)"]) THEN
      Type := Type::" ";
    "Posting Date" := PurchInvHeader."Posting Date";
    "Document No." := PurchInvHeader."No.";
    Quantity := PurchLine."Qty. to Invoice";
    "Quantity (Base)" := PurchLine."Qty. to Invoice (Base)";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    INIT;
    TRANSFERFIELDS(PurchLine);
    #5..8
    */
    //end;
}
