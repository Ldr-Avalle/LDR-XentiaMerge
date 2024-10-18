tableextension 50220 "SalesHeader_LDR" extends "Sales Header"
{
    DataCaptionFields = "Document Type";

    fields
    {
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                CompanyInfo: Record "Company Information";
                UserDims: Record "User Dimensions_LDR";
            begin
                CompanyInfo.GET();
                "Assigned User ID" := USERID;
                UserDims.SETRANGE(UserDims.Usuario, USERID);
                IF UserDims.FINDFIRST() THEN
                    "Location Code" := UserDims."Location Code";
            end;
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Grupo contable negocio';
        }
        modify("Area")
        {
            Caption = 'Cód. provincia';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Grupo registro IVA neg.';
        }
        modify("Get Shipment Used")
        {
            Caption = 'Obtener método de envío usado';
        }
        field(50009; "Factura Simplificada"; Enum TbaiNS)
        {
            Caption = 'Factura Simplificada';
            Description = 'TBAI_AL_01 factura simplificada';
        }
        field(50099; FacturaFin; Code[20])
        {
        }
        field(50100; SendToTicketBAI; Boolean)
        {
            Caption = 'Enviar Factura a Ticket BAI';
            Description = 'TBAI_AL_01';
        }
    }

    trigger OnAfterInsert()
    var
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.GET();
        "Assigned User ID" := UserId;
        Rec.Validate("Prices Including VAT", true);
    end;

    trigger OnAfterModify()
    var
        UserDims: Record "User Dimensions_LDR";
    begin
        IF UserDims.existsUser(USERID) THEN
            TESTFIELD("Assigned User ID", USERID);
    end;

    trigger OnAfterDelete()
    var
        Opp: Record Opportunity;
        TempOpportunityEntry: Record "Opportunity Entry" temporary;
        UserDims: Record "User Dimensions_LDR";
    BEGIN

        IF UserDims.existsUser(USERID) THEN
            TESTFIELD("Assigned User ID", USERID);
    end;
}