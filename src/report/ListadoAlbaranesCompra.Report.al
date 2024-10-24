report 50071 "Listado Albaranes Compra"
{
    ApplicationArea = All;
    Caption = 'Listado Albaranes Compra';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Listado Albaranes Compra.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = sorting("Document Date", "No.") order(ascending) where("Buy-from Vendor No." = filter(<> 'P00040'));
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
            column(PurchRcptHeader_Totalalbaran; "Purch. Rcpt. Header"."Total albarán")
            {
            }
            column(totalAlbaranes; totalAlbaranes)
            {
            }

            trigger OnAfterGetRecord()
            var
                rec121: Record "Purch. Rcpt. Line";
            begin
                if ("Total albarán" = 0) then begin
                    rec121.SetRange("Document No.", "No.");
                    if pendientesFacturar then begin
                        rec121.SetFilter("Qty. Rcd. Not Invoiced", '>0');
                        if rec121.Count = 0 then CurrReport.Skip();
                    end;

                    repeat
                        "Total albarán" := "Total albarán" + rec121.Quantity * rec121."Unit Cost" - (((rec121.Quantity * rec121."Unit Cost") * rec121."Line Discount %") / 100) + (((rec121.Quantity * rec121."Unit Cost") * rec121."VAT %") / 100);
                    until (rec121.Next() = 0);
                end;

                totalAlbaranes := totalAlbaranes + "Total albarán";
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
                field(pendientesFacturar; pendientesFacturar)
                {
                    Caption = 'Pendiente de facturar';
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
}