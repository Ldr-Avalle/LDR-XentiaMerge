pageextension 50004 "General Ledger Entries" extends "General Ledger Entries"
{
    layout
    {
        addafter("Document Type")
        {
            field("Transaction No."; Rec."Transaction No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill No.")
        {
            field(Punteado; Rec.Punteado)
            {
                ApplicationArea = All;
            }
        }
        addafter("Document No.")
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field(GetBase; Rec.GetBase)
            {
                ApplicationArea = All;
            }
        }
        modify("External Document No.")
        {
            ApplicationArea = All;
            Visible = true;
        }
    }

    actions
    {
        addafter("Value Entries")
        {
            action(ExportToExcel)
            {
                ApplicationArea = All;
                Caption = 'Export to Excel';
                Image = ExportToExcel;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                VAR
                    Excel: Record 50013;
                    acumulado: Decimal;
                    i: Integer;
                BEGIN
                    Excel.crearExcel(FALSE);
                    Excel.nuevoWorkbook(CurrPage.CAPTION);

                    IF rec.FindSet() THEN BEGIN
                        //cabecera
                        Excel.nuevoValor(CurrPage.CAPTION, 'A1', 'Fecha emisión', TRUE, FALSE, FALSE, 10, 2, 1);
                        Excel.nuevoValor(CurrPage.CAPTION, 'B1', 'Tipo documento', TRUE, FALSE, FALSE, 10, 2, 1);
                        Excel.nuevoValor(CurrPage.CAPTION, 'C1', 'Nõ documento', TRUE, FALSE, FALSE, 10, 2, 1);
                        Excel.nuevoValor(CurrPage.CAPTION, 'D1', 'Descripción', TRUE, FALSE, FALSE, 10, 2, 1);
                        Excel.nuevoValor(CurrPage.CAPTION, 'E1', 'Importe', TRUE, FALSE, FALSE, 10, 2, 1);
                        Excel.nuevoValor(CurrPage.CAPTION, 'F1', 'Saldo acumulado', TRUE, FALSE, FALSE, 10, 2, 1);

                        i := 2;
                        REPEAT //l­neas
                            Excel.nuevoValor(CurrPage.CAPTION, 'A' + FORMAT(i), rec."Document Date", FALSE, FALSE, FALSE, 10, 1, 0);
                            Excel.nuevoValor(CurrPage.CAPTION, 'B' + FORMAT(i), getDocType(rec."Document Type".AsInteger()), FALSE, FALSE, FALSE, 10, 1, 0);
                            Excel.nuevoValor(CurrPage.CAPTION, 'C' + FORMAT(i), rec."Document No.", FALSE, FALSE, FALSE, 10, 1, 0);
                            Excel.nuevoValor(CurrPage.CAPTION, 'D' + FORMAT(i), rec.Description, FALSE, FALSE, FALSE, 10, 1, 0);
                            //CALCFIELDS(Amount);
                            Excel.nuevoValor(CurrPage.CAPTION, 'E' + FORMAT(i), rec.Amount, FALSE, FALSE, FALSE, 10, 1, 0);
                            acumulado += rec.Amount;
                            Excel.nuevoValor(CurrPage.CAPTION, 'F' + FORMAT(i), acumulado, FALSE, FALSE, FALSE, 10, 1, 0);
                            i += 1;
                        UNTIL rec.NEXT = 0;
                    END;
                    Excel.mostrarExcel(TRUE);
                END;
            }
            action(Opciones)
            {
                ApplicationArea = All;
                Caption = 'Opciones';
                trigger OnAction()
                begin
                    CASE Opciones OF
                        Opciones::Punteados:
                            rec.SETRANGE(Punteado, TRUE);
                        Opciones::"No punteados":
                            rec.SETRANGE(Punteado, FALSE);
                        Opciones::Todos:
                            rec.RESET;
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Opciones := Opciones::Todos;
    end;

    PROCEDURE getDocType(docTypeCode: Integer) docType: Text[30];
    BEGIN
        CASE docTypeCode OF
            1:
                EXIT('Pago');
            2:
                EXIT('Factura');
            3:
                EXIT('Abono');
            4:
                EXIT('Docs. inter‚s');
            5:
                EXIT('Recordatorio');
            6:
                EXIT('Reembolso');
            7:
                EXIT('Efecto');
            ELSE
                EXIT('');
        END;
    END;

    PROCEDURE getDocExterno() "no.": Code[20];
    VAR
        PurchInvHead: Record 122;
    BEGIN
        IF PurchInvHead.GET(rec."Document No.") THEN
            EXIT(PurchInvHead."Vendor Invoice No.");

        EXIT('');
    END;

    var
        Opciones: Option "Punteados","No punteados","Todos";
}
