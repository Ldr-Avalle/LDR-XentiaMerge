pageextension 50000 "Company Information" extends "Company Information"
{
    layout
    {
        addafter(IBAN)
        {
            field("Bank Code"; Rec."Bank Code")
            {
                ApplicationArea = All;
            }
            field(CCC1; Rec.CCC1)
            {
                ApplicationArea = All;
            }
            field(CCC2; Rec.CCC2)
            {
                ApplicationArea = All;
            }
            field(CCC3; Rec.CCC3)
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            group(Logos)
            {

                field("Logo Idepa"; Rec."Logo Idepa")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Logo Ministerio"; Rec."Logo Ministerio")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Logo Feder"; Rec."Logo Feder")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field(imgReports; Rec.imgReports)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
            }
            field("Domain Name"; Rec."Domain Name")
            {
                ApplicationArea = all;
            }
            field("Reports Image"; Rec."Reports Image")
            {
                ApplicationArea = all;
            }
            group(FacturaE)
            {
                field(Book; Rec.Book)
                {
                    ApplicationArea = all;
                }
                field("Mercantil register"; Rec."Mercantil register")
                {
                    ApplicationArea = all;
                }
                field(Hoja; Rec.Hoja)
                {
                    ApplicationArea = all;
                }
                field(Folio; Rec.Folio)
                {
                    ApplicationArea = all;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = all;
                }
                field(Tomo; Rec.Tomo)
                {
                    ApplicationArea = all;
                }
                field("Other data"; Rec."Other data")
                {
                    ApplicationArea = all;
                }
                field(Entity; Rec.Entity)
                {
                    ApplicationArea = all;
                }
                field("Entity type"; Rec."Entity type")
                {
                    ApplicationArea = all;
                }
                field("Digital Cert. Name"; Rec."Digital Cert. Name")
                {
                    ApplicationArea = all;
                }
                field("Facturae Chipbip path"; Rec."Facturae Chipbip path")
                {
                    ApplicationArea = All;
                }
                field("XML Files path"; Rec."XML Files path")
                {
                    ApplicationArea = All;
                }
                field("PDF Printer Name"; Rec."PDF Printer Name")
                {
                    ApplicationArea = All;
                }
                field("PDF AutoSave Path"; Rec."PDF AutoSave Path")
                {
                    ApplicationArea = All;
                }
                field("OO Files Path"; Rec."OO Files Path")
                {
                    ApplicationArea = All;
                }
                field("CO files path"; Rec."CO files path")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}