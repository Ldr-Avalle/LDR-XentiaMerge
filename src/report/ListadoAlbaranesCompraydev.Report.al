report 50057 "Listado Albaranes Compra y dev"
{
    ApplicationArea = All;
    Caption = 'Listado Albaranes Compra y dev';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Listado Albaranes Compra y dev.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = sorting("Document Date", "No.") order(ascending) where("Buy-from Vendor No." = filter(<> 'P00040'));
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
            column(PurchRcptHeader_Totalalbaran; "Purch. Rcpt. Header"."Total albarán")
            {
            }
            column(PurchRcptHeader_LocationCode; "Purch. Rcpt. Header"."Location Code")
            {
            }
            dataitem("Return Shipment Header"; "Return Shipment Header")
            {
                DataItemTableView = where("Buy-from Vendor No." = filter(<> 'P00040'));

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
                    rec6651: Record "Return Shipment Line";
                begin

                    SetFilter("Posting Date", '%1..%2', startdate, enddate);

                    if ("Return Shipment Header"."Total Devolucion" = 0) then begin
                        rec6651.SetRange("Document No.", "No.");
                        if pendientesFacturar then begin
                            rec6651.SetFilter("Return Qty. Shipped Not Invd.", '>0');
                            if rec6651.Count = 0 then CurrReport.Skip();
                        end;

                        repeat
                            "Return Shipment Header"."Total Devolucion" := "Return Shipment Header"."Total Devolucion" + rec6651."Item Charge Base Amount"
                        until (rec6651.Next() = 0);
                    end;

                    totalAlbaranes := totalAlbaranes + "Return Shipment Header"."Total Devolucion";

                end;

                trigger OnPreDataItem()
                begin
                    totalAlbaranes := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                rec121: Record "Purch. Rcpt. Line";
            begin

                SetFilter("Posting Date", '%1..%2', startdate, enddate);
                if ("Purch. Rcpt. Header"."Total albarán" = 0) then begin
                    rec121.SetRange("Document No.", "No.");
                    if pendientesFacturar then begin
                        rec121.SetFilter("Qty. Rcd. Not Invoiced", '>0');
                        if rec121.Count = 0 then CurrReport.Skip();
                    end;

                    repeat
                        "Purch. Rcpt. Header"."Total albarán" := "Purch. Rcpt. Header"."Total albarán" + rec121."Item Charge Base Amount"
                    until (rec121.Next() = 0);
                end;

                totalAlbaranes := totalAlbaranes + "Purch. Rcpt. Header"."Total albarán";
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
            area(Content)
            {
                group(Opciones)
                {
                    Caption = 'Opciones', Comment = 'ESP="Opciones"';

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
    }

    trigger OnInitReport()
    begin
        recordCI.CalcFields(Picture);
    end;

    var
        recordCI: Record "Company Information";
        totalAlbaranes: Decimal;
        pendientesFacturar: Boolean;
        startdate: Date;
        enddate: Date;
}