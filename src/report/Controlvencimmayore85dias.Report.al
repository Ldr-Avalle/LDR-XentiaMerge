report 50086 "Control vencim. mayore 85 dias"
{
    ApplicationArea = All;
    Caption = 'Control vencim. mayore 85 dias';
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Control vencim. mayore 85 dias.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = sorting("Vendor No.", Open, Positive, "Due Date", "Currency Code");
            RequestFilterFields = "Vendor No.", "Posting Date", "Due Date";

            column(VendorLedgerEntryVendorNo; "Vendor Ledger Entry"."Vendor No.")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(PageConstFORMATCurrReportPAGENO; PageConst + ' ' + Format(CurrReport.PageNo))
            {
            }

            dataitem(Vendor; Vendor)
            {
                DataItemLink = "No." = field("Vendor No.");

                column(VendorLedgerEntryDocumentType; "Vendor Ledger Entry"."Document Type")
                {
                }
                column(VendorLedgerEntryDocumentNo; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(VendorLedgerEntryName; "Vendor Ledger Entry".Name)
                {
                }
                column(VendorLedgerEntryPostingDate; "Vendor Ledger Entry"."Posting Date")
                {
                }
                column(VendorLedgerEntryAmount; "Vendor Ledger Entry".Amount)
                {
                }
                column(VendorLedgerEntryDueDate; "Vendor Ledger Entry"."Due Date")
                {
                }
                column(total0a85; total0a85)
                {
                }
                column(total86a180; total86a180)
                {
                }
                column(total0a85Mastotal86a180; total0a85 + total86a180)
                {
                }
                column(total0a85Entretotal0a85Mastotal86a180Por100; ((total0a85) / (total0a85 + total86a180)) * 100)
                {
                }
                column(total86a180Entretotal0a85Mastotal86a180Por100; ((total86a180) / (total0a85 + total86a180)) * 100)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                diasDif := "Due Date" - "Posting Date";
                CalcFields(Amount);

                if (diasDif <= 60) then
                    total0a85 := total0a85 + Amount
                else if ((diasDif >= 61) and (diasDif < 2000)) then total86a180 := total86a180 + Amount;
                total := total + Amount;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("Vendor No.");
                LastFieldNo := FieldNo("Entry No.");
                SetFilter("Document Type", '%1|%2', "Document Type"::"Credit Memo", "Document Type"::Invoice);


                total0a85 := 0;
                total86a180 := 0;
                total := 0;
            end;
        }
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        total0a85: Decimal;
        total86a180: Decimal;
        total: Decimal;
        diasDif: Decimal;
        PageConst: Label 'Página';
        TotalFor: Label 'Total para ';
        CompanyInfo: Record "Company Information";
}