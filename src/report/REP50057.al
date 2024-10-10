report 50057 "Listado Albaranes Compra y dev"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Listado Albaranes Compra y dev.rdl';

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("Document Date", "No.")
                                ORDER(Ascending)
                                WHERE("Buy-from Vendor No." = FILTER(<> 'P00040'));
            RequestFilterFields = "No.";
            column(PurchRcptHeader_No; "Purch. Rcpt. Header"."No.")
            {
            }
            column(PurchRcptHeader_DocumentDate; "Purch. Rcpt. Header"."Document Date")
            {
            }
            column(PurchRcptHeader_BuyfromVendorNo; "Purch. Rcpt. Header"."Buy-from Vendor No.")
            {
            }
            column(PurchRcptHeader_BuyfromVendorName; "Purch. Rcpt. Header"."Buy-from Vendor Name")
            {
            }
            column(PurchRcptHeader_Totalalbaran; "Purch. Rcpt. Header"."Total albaran")
            {
            }
            column(PurchRcptHeader_LocationCode; "Purch. Rcpt. Header"."Location Code")
            {
            }
            dataitem("Return Shipment Header"; "Return Shipment Header")
            {
                DataItemTableView = WHERE("Buy-from Vendor No." = FILTER(<> 'P00040'));
                column(ReturnShipmentHeader_No; "Return Shipment Header"."No.")
                {
                }
                column(ReturnShipmentHeader_DocumentDate; "Return Shipment Header"."Document Date")
                {
                }
                column(ReturnShipmentHeader_BuyfromVendorNo; "Return Shipment Header"."Buy-from Vendor No.")
                {
                }
                column(ReturnShipmentHeader_BuyfromVendorName; "Return Shipment Header"."Buy-from Vendor Name")
                {
                }
                column(ReturnShipmentHeader_TotalDevolucion; "Return Shipment Header"."Total Devolucion")
                {
                }
                column(totalAlbaranes; totalAlbaranes)
                {
                }
                column(ReturnShipmentHeader_LocationCode; "Return Shipment Header"."Location Code")
                {
                }

                trigger OnAfterGetRecord()
                var
                    rec6651: Record "6651";
                begin

                    SETFILTER("Posting Date", '%1..%2', startdate, enddate);

                    IF ("Return Shipment Header"."Total Devolucion" = 0) THEN BEGIN
                        rec6651.SETRANGE("Document No.", "No.");
                        IF pendientesFacturar THEN BEGIN
                            rec6651.SETFILTER("Return Qty. Shipped Not Invd.", '>0');
                            IF rec6651.COUNT = 0 THEN CurrReport.SKIP;
                        END;

                        REPEAT
                            "Return Shipment Header"."Total Devolucion" := "Return Shipment Header"."Total Devolucion" + rec6651."Item Charge Base Amount"
                         /*"Total albar´Š¢n" + rec6651.Quantity * rec6651."Unit Cost"
                                            - (((rec6651.Quantity * rec6651."Unit Cost") * rec6651."Line Discount %")/100)
                                            + (((rec6651.Quantity * rec6651."Unit Cost") * rec6651."VAT %")/100);*/

                         UNTIL (rec6651.NEXT = 0);
                    END;

                    totalAlbaranes := totalAlbaranes + "Return Shipment Header"."Total Devolucion";

                end;

                trigger OnPreDataItem()
                begin
                    totalAlbaranes := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                rec121: Record "121";
            begin

                SETFILTER("Posting Date", '%1..%2', startdate, enddate);
                IF ("Purch. Rcpt. Header"."Total albaran" = 0) THEN BEGIN
                    rec121.SETRANGE("Document No.", "No.");
                    IF pendientesFacturar THEN BEGIN
                        rec121.SETFILTER("Qty. Rcd. Not Invoiced", '>0');
                        IF rec121.COUNT = 0 THEN CurrReport.SKIP;
                    END;

                    REPEAT
                        "Purch. Rcpt. Header"."Total albaran" := "Purch. Rcpt. Header"."Total albaran" + rec121."Item Charge Base Amount"
                     /*"Total albar´Š¢n" + rec121.Quantity * rec121."Unit Cost"
                                        - (((rec121.Quantity * rec121."Unit Cost") * rec121."Line Discount %")/100)
                                        + (((rec121.Quantity * rec121."Unit Cost") * rec121."VAT %")/100);*/

                     UNTIL (rec121.NEXT = 0);
                END;

                totalAlbaranes := totalAlbaranes + "Purch. Rcpt. Header"."Total albaran";

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
                group(Opciones)
                {
                    Caption = 'Opciones';
                    field(pendientesFacturar; pendientesFacturar)
                    {
                        Caption = 'Pendientes facturar';
                    }
                    field(startdate; startdate)
                    {
                        Caption = 'Fecha inicial';
                    }
                    field(enddate; enddate)
                    {
                        Caption = 'Fecha final';
                    }
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

    var
        recordCI: Record "79";
        totalAlbaranes: Decimal;
        pendientesFacturar: Boolean;
        startdate: Date;
        enddate: Date;
}

