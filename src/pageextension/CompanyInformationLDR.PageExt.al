pageextension 50000 "Company Information_LDR" extends "Company Information"
{
    layout
    {
        addafter(IBAN)
        {
            field("Bank Code_LDR"; Rec."Bank Code")
            {
                ApplicationArea = All;
            }
            field(CCC1_LDR; Rec.CCC1)
            {
                ApplicationArea = All;
            }
            field(CCC2_LDR; Rec.CCC2)
            {
                ApplicationArea = All;
            }
            field(CCC3_LDR; Rec.CCC3)
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            group(Logos_LDR)
            {

                field("Logo Idepa_LDR"; Rec."Logo Idepa")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Logo Ministerio_LDR"; Rec."Logo Ministerio")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Logo Feder_LDR"; Rec."Logo Feder")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field(imgReports_LDR; Rec.imgReports)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
            }
            field("Domain Name_LDR"; Rec."Domain Name")
            {
                ApplicationArea = All;
            }
            field("Reports Image_LDR"; Rec."Reports Image")
            {
                ApplicationArea = All;
            }
            group(FacturaE_LDR)
            {
                field(Book_LDR; Rec.Book)
                {
                    ApplicationArea = All;
                }
                field("Mercantil register_LDR"; Rec."Mercantil register")
                {
                    ApplicationArea = All;
                }
                field(Hoja_LDR; Rec.Hoja)
                {
                    ApplicationArea = All;
                }
                field(Folio_LDR; Rec.Folio)
                {
                    ApplicationArea = All;
                }
                field(Section_LDR; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field(Tomo_LDR; Rec.Tomo)
                {
                    ApplicationArea = All;
                }
                field("Other data_LDR"; Rec."Other data")
                {
                    ApplicationArea = All;
                }
                field(Entity_LDR; Rec.Entity)
                {
                    ApplicationArea = All;
                }
                field("Entity type_LDR"; Rec."Entity type")
                {
                    ApplicationArea = All;
                }
                field("Digital Cert. Name_LDR"; Rec."Digital Cert. Name")
                {
                    ApplicationArea = All;
                }
                field("Facturae Chipbip path_LDR"; Rec."Facturae Chipbip path")
                {
                    ApplicationArea = All;
                }
                field("XML Files path_LDR"; Rec."XML Files path")
                {
                    ApplicationArea = All;
                }
                field("PDF Printer Name_LDR"; Rec."PDF Printer Name")
                {
                    ApplicationArea = All;
                }
                field("PDF AutoSave Path_LDR"; Rec."PDF AutoSave Path")
                {
                    ApplicationArea = All;
                }
                field("OO Files Path_LDR"; Rec."OO Files Path")
                {
                    ApplicationArea = All;
                }
                field("CO files path_LDR"; Rec."CO Files Path")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}