page 50025 "Cust Card"
{
    ApplicationArea = All;
    Caption = 'Cust Card', Comment = 'ESP=""';
    SourceTable = Customer;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Primary Contact No."; Rec."Primary Contact No.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';

                    trigger OnDrillDown()
                    var
                        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                        CustLedgEntry: Record "Cust. Ledger Entry";
                    begin
                        DtldCustLedgEntry.SetRange("Customer No.", Rec."No.");
                        Rec.CopyFilter("Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                        Rec.CopyFilter("Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                        Rec.CopyFilter("Currency Filter", DtldCustLedgEntry."Currency Code");
                        CustLedgEntry.DrillDownOnEntries(DtldCustLedgEntry);
                    end;
                }
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Service Zone Code"; Rec."Service Zone Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
#pragma warning disable AL0432
                field("Home Page"; Rec."Home Page")
#pragma warning restore AL0432
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Document Sending Profile"; Rec."Document Sending Profile")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';

                    trigger OnDrillDown()
                    var
                        VATRegistrationLogMgt: Codeunit "VAT Registration Log Mgt.";
                    begin
                        VATRegistrationLogMgt.AssistEditCustomerVATReg(Rec);
                    end;
                }
                field(GLN; Rec.GLN)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Invoice Copies"; Rec."Invoice Copies")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Invoice Disc. Code"; Rec."Invoice Disc. Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    NotBlank = true;
                }
                field("Copy Sell-to Addr. to Qte From"; Rec."Copy Sell-to Addr. to Qte From")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    ShowMandatory = true;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Prices Including VAT"; Rec."Prices Including VAT")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Partner Type"; Rec."Partner Type")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                    ShowMandatory = true;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
                field("Payment Days Code"; Rec."Payment Days Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Non-Paymt. Periods Code"; Rec."Non-Paymt. Periods Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Reminder Terms Code"; Rec."Reminder Terms Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
                field("Fin. Charge Terms Code"; Rec."Fin. Charge Terms Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
                field("Cash Flow Payment Terms Code"; Rec."Cash Flow Payment Terms Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Print Statements"; Rec."Print Statements")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Last Statement No."; Rec."Last Statement No.")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Block Payment Tolerance"; Rec."Block Payment Tolerance")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Preferred Bank Account"; Rec."Preferred Bank Account Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
                field("Combine Shipments"; Rec."Combine Shipments")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Shipping Advice"; Rec."Shipping Advice")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
                field("Shipment Method Code"; Rec."Shipment Method Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
                field("Shipping Agent Service Code"; Rec."Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Shipping Time"; Rec."Shipping Time")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    DrillDown = false;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                    Importance = Promoted;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    ToolTip = 'Especifica';
                }
            }
        }
        area(FactBoxes)
        {
            part("CRM Statistics FactBox"; "CRM Statistics FactBox")
            {
                SubPageLink = "No." = field("No.");
            }
            // part(; 875)//TODO: PAGE 875 Y 876 PREGUNTAR SI EXISTEN
            // {
            //     SubPageLink = "Source Type" = const(Customer), "Source No." = field("No.");
            // }
            // part(; 876)
            // {
            //     SubPageLink = Source fieldType=CONST(Customer),
            //                   Source No.=field(No.);
            //                                  UpdatePropagation = Both;
            // }
            part("Sales Hist. Sell-to FactBox"; "Sales Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = field("No."),
                              "Currency Filter" = field("Currency Filter"),
                              "Date Filter" = field("Date Filter"),
                              "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                Visible = true;
            }
            part("Sales Hist. Bill-to FactBox"; "Sales Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = field("No."),
                              "Currency Filter" = field("Currency Filter"),
                              "Date Filter" = field("Date Filter"),
                              "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                Visible = false;
            }
            part("Customer Statistics FactBox"; "Customer Statistics FactBox")
            {
                SubPageLink = "No." = field("No."),
                              "Currency Filter" = field("Currency Filter"),
                              "Date Filter" = field("Date Filter"),
                              "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                Visible = true;
            }
            part("Cartera Receiv. Statistics FB"; "Cartera Receiv. Statistics FB")
            {
                SubPageLink = "No." = field("No.");
                Visible = true;
            }
            part("Cartera Fact. Statistics FB"; "Cartera Fact. Statistics FB")
            {
                SubPageLink = "No." = field("No.");
                Visible = true;
            }
            part("Dimensions FactBox"; "Dimensions FactBox")
            {
                SubPageLink = "Table ID" = const(18),
                              "No." = field("No.");
                Visible = false;
            }
            part("Service Hist. Sell-to FactBox"; "Service Hist. Sell-to FactBox")
            {
                SubPageLink = "No." = field("No."),
                              "Currency Filter" = field("Currency Filter"),
                              "Date Filter" = field("Date Filter"),
                              "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                Visible = false;
            }
            part("Service Hist. Bill-to FactBox"; "Service Hist. Bill-to FactBox")
            {
                SubPageLink = "No." = field("No."),
                              "Currency Filter" = field("Currency Filter"),
                              "Date Filter" = field("Date Filter"),
                              "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = field("Global Dimension 2 Filter");
                Visible = false;
            }
            part(WorkflowStatus; "Workflow Status FactBox")
            {
                Editable = false;
                Enabled = false;
                ShowFilter = false;
            }
            systempart(Links; Links)
            {
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                Visible = true;
            }
        }
    }
}