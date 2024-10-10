report 50089 GeneraFacturaTbai
{
    DefaultLayout = RDLC;
    RDLCLayout = './GeneraFacturaTbai.rdlc';

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
                    Caption = 'N´Š¢ factura';
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
        /*
              IF SalesHeader.SendToTicketBAI THEN BEGIN
                SalesInvoiceHeader.SendToTicketBAI := SalesHeader.SendToTicketBAI;
                SalesInvoiceHeader."Factura Simplificada" := SalesHeader."Factura Simplificada";
                cdu.NosSeriesTbai(SalesInvoiceHeader.DocNoTBAI,SalesInvoiceHeader."No. SeriesTBAI");
                SalesInvoiceHeader.MODIFY(FALSE);
        */
                cdu.MakeXMLTicketBAI_FacturaEnvio(SalesInvoiceHeader);//TBAI_AL_01
              END;
        //    END;
        //  END;
        
        /*
          IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN BEGIN
            SalesCrMemoHeader.RESET;
            CLEAR(SalesCrMemoHeader);
            SalesInvoiceHeader.RESET;
            CLEAR(SalesInvoiceHeader);
            IF SalesCrMemoHeader.GET(SalesCrMemoHdrNo) THEN BEGIN
              IF SalesHeader.SendToTicketBAI THEN BEGIN
                SalesInvoiceHeader.SendToTicketBAI := SalesHeader.SendToTicketBAI;
                IF SalesCrMemoHeader."Applies-to Doc. Type" = SalesCrMemoHeader."Applies-to Doc. Type"::Invoice THEN BEGIN
                  IF SalesInvoiceHeader.GET(SalesCrMemoHeader."Applies-to Doc. No.") THEN BEGIN
                    SalesInvoiceHeader.TBAI_Sended := FALSE;
                    SalesInvoiceHeader.MODIFY(FALSE);
                    MakeXMLTicketBAI_FacturaAnulacion(SalesInvoiceHeader);//TBAI_AL_01
                    Anulaci´Š¢nPorAbono_ModifyTBAIValues_SalesCrMemoHEADER(SalesCrMemoHeader,SalesInvoiceHeader);
                  END;
                END;
              END;
        
            END;
          END;
        
        
        END;
        */

    end;
}

