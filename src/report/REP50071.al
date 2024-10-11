report 50071 "Listado Albaranes Compra"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Listado Albaranes Compra.rdl';

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("Document Date", "No.")
                                ORDER(Ascending)
                                WHERE("Buy-from Vendor No." = FILTER(<> 'P00040'));
            RequestFilterFields = "No.", "Order Date", "Posting Date";
            column(recordCI_PhoneNo; recordCI."Phone No.")
            {
            }
            column(recordCI_FaxNo; recordCI."Fax No.")
            {
            }
            column(PurchRcptHeader_No; "Purch. Rcpt. Header"."No.")
            {
            }
            column(PurchRcptHeader_DocumentDate; "Purch. Rcpt. Header"."Document Date")
            {
            }
            column(PurchRcptHeader_BuyfromVendorName; "Purch. Rcpt. Header"."Buy-from Vendor Name")
            {
            }
            column(PurchRcptHeader_Totalalbaran; "Purch. Rcpt. Header"."Total albaran")
            {
            }
            column(totalAlbaranes; totalAlbaranes)
            {
            }

            trigger OnAfterGetRecord()
            var
                rec121: Record "121";
            begin
                //??revisar esto para que actualice el total del albar´Š¢n
                IF ("Total albaran" = 0) THEN BEGIN
                    rec121.SETRANGE("Document No.", "No.");
                    IF pendientesFacturar THEN BEGIN
                        rec121.SETFILTER("Qty. Rcd. Not Invoiced", '>0');
                        IF rec121.COUNT = 0 THEN CurrReport.SKIP;
                    END;

                    REPEAT
                        "Total albaran" := "Total albaran" + rec121.Quantity * rec121."Unit Cost"
                                           - (((rec121.Quantity * rec121."Unit Cost") * rec121."Line Discount %") / 100)
                                           + (((rec121.Quantity * rec121."Unit Cost") * rec121."VAT %") / 100);
                    UNTIL (rec121.NEXT = 0);
                END;

                totalAlbaranes := totalAlbaranes + "Total albaran";
            end;

            trigger OnPreDataItem()
            begin
                totalAlbaranes := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(pendientesFacturar; pendientesFacturar)
                {
                    Caption = 'Pendiente de facturar';
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

    trigger OnInitReport()
    begin
        recordCI.CALCFIELDS(Picture);
    end;

    trigger OnPreReport()
    begin
        /*LogChipbip.INIT;
        LogChipbip.Fecha := CREATEDATETIME(TODAY, TIME);
        LogChipbip.Funcionalidad := 'Report: Listado Albaranes Compra';
        LogChipbip.Usuario := USERID;
        LogChipbip.INSERT; */

    end;

    var
        recordCI: Record "79";
        totalAlbaranes: Decimal;
        pendientesFacturar: Boolean;
}

