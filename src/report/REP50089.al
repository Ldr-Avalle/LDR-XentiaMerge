//todo: por ahora el tbai queda exlcluido de la migracion
/*
report 50089 GeneraFacturaTbai
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/GeneraFacturaTbai.rdl';

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(gblNumFactura;gblNumFactura)
                {
                    Caption = 'Nº factura';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        OnAfterPostSalesDoc(gblNumFactura,'');
    end;

    var
        cdu: Codeunit "10700";
        gblNumFactura: Code[20];

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    procedure OnAfterPostSalesDoc(SalesInvHdrNo: Code[20];SalesCrMemoHdrNo: Code[20])
    var
        SalesInvoiceHeader: Record "112";
        SalesCrMemoHeader: Record "114";
    begin
        //IF TBAIActivatedAutomaticSend THEN BEGIN
        //  IF SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice THEN BEGIN
            SalesInvoiceHeader.RESET;
            CLEAR(SalesInvoiceHeader);
            IF SalesInvoiceHeader.GET(SalesInvHdrNo) THEN BEGIN       
                cdu.MakeXMLTicketBAI_FacturaEnvio(SalesInvoiceHeader);//TBAI_AL_01
              END;
        //    END;
        //  END;                

    end;
}
*/
