report 50086 "Control vencim. mayore 85 d´Š¢as"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Control vencim. mayore 85 d´Š¢as.rdlc';

    dataset
    {
        dataitem(DataItem1000000000;Table25)
        {
            DataItemTableView = SORTING(Vendor No.,Open,Positive,Due Date,Currency Code);
            RequestFilterFields = "Vendor No.","Posting Date","Due Date";
            column(VendorLedgerEntryVendorNo;"Vendor Ledger Entry"."Vendor No.")
            {
            }
            column(CompanyInfoName;CompanyInfo.Name)
            {
            }
            column(PageConstFORMATCurrReportPAGENO;PageConst + ' ' + FORMAT(CurrReport.PAGENO))
            {
            }
            dataitem(DataItem1000000001;Table23)
            {
                DataItemLink = No.=FIELD(Vendor No.);
                column(VendorLedgerEntryDocumentType;"Vendor Ledger Entry"."Document Type")
                {
                }
                column(VendorLedgerEntryDocumentNo;"Vendor Ledger Entry"."Document No.")
                {
                }
                column(VendorLedgerEntryName;"Vendor Ledger Entry".Name)
                {
                }
                column(VendorLedgerEntryPostingDate;"Vendor Ledger Entry"."Posting Date")
                {
                }
                column(VendorLedgerEntryAmount;"Vendor Ledger Entry".Amount)
                {
                }
                column(VendorLedgerEntryDueDate;"Vendor Ledger Entry"."Due Date")
                {
                }
                column(total0a85;total0a85)
                {
                }
                column(total86a180;total86a180)
                {
                }
                column(total0a85Mastotal86a180; total0a85 +total86a180)
                {
                }
                column(total0a85Entretotal0a85Mastotal86a180Por100;((total0a85 )/(total0a85 +total86a180))*100)
                {
                }
                column(total86a180Entretotal0a85Mastotal86a180Por100;((total86a180)/(total0a85 +total86a180))*100)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                diasDif := "Due Date" - "Posting Date";
                CALCFIELDS(Amount);

                          IF (diasDif<= 60) THEN total0a85 := total0a85 + Amount
                         ELSE IF ((diasDif >= 61) AND (diasDif < 2000)) THEN total86a180 := total86a180 + Amount;
                  total := total + Amount;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Vendor No.");
                LastFieldNo := FIELDNO("Entry No.");
                SETFILTER("Document Type", '%1|%2',"Document Type"::"Credit Memo","Document Type"::Invoice);


                total0a85 := 0;
                total86a180 := 0;
                total := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        total0a85: Decimal;
        total86a180: Decimal;
        total: Decimal;
        diasDif: Decimal;
        PageConst: Label 'P´Š¢gina';
        TotalFor: Label 'Total para ';
        CompanyInfo: Record "79";
}

