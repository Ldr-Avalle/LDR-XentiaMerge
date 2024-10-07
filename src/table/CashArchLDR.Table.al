table 50003 "Cash Arch_LDR"
{
    Caption = 'Arqueo caja';
    DataCaptionFields = Title;
    LookupPageID = "Cash Arch List";

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'Id. usuario';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Date; Date)
        {
            Caption = 'Fecha';

            trigger OnValidate()
            var
                CashNotes: Record "Cash Notes_LDR";
            begin
                "User ID" := UserId;
                TestField("User ID", UserId);

                "Cash Notes" := 0;
                CashNotes.SetFilter(CashNotes."User ID", '%1', "User ID"); //--> no sirve para 2016
                CashNotes.SetFilter(Date, '%1', Date);
                if CashNotes.FindFirst then
                    repeat
                        "Cash Notes" += CashNotes.Amount;
                    until CashNotes.Next = 0;
                calculateArch;
            end;
        }
        field(3; "Start cash"; Decimal)
        {
            Caption = 'Importe inicial';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                calculateArch;
            end;
        }
        field(4; "end cash"; Decimal)
        {
            Caption = 'Importe final';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Cash Notes"; Decimal)
        {
            Caption = 'Notas caja';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Registered; Boolean)
        {
            Caption = 'Registrado';
            DataClassification = ToBeClassified;
        }
        field(7; "1 cent."; Decimal)
        {
            Caption = '1 cént.';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(8; "2 cent."; Decimal)
        {
            Caption = '2 cént.';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(9; "5 cent."; Decimal)
        {
            Caption = '5 cént.';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(10; "10 cent."; Decimal)
        {
            Caption = '10 cént.';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(11; "20 cent."; Decimal)
        {
            Caption = '20 cént.';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(12; "50 cent."; Decimal)
        {
            Caption = '50 cént.';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(13; "1 euro"; Decimal)
        {
            Caption = '1 euro';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(14; "2 euros"; Decimal)
        {
            Caption = '2 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(15; "5 euros"; Decimal)
        {
            Caption = '5 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(16; "10 euros"; Decimal)
        {
            Caption = '10 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(17; "20 euros"; Decimal)
        {
            Caption = '20 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(18; "50 euros"; Decimal)
        {
            Caption = '50 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(19; "100 euros"; Decimal)
        {
            Caption = '100 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(20; "200 euros"; Decimal)
        {
            Caption = '200 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(21; "500 euros"; Decimal)
        {
            Caption = '500 euros';
            DataClassification = ToBeClassified;
            MinValue = 0;

            trigger OnValidate()
            begin
                calculateendCash;
            end;
        }
        field(22; Discrepancy; Decimal)
        {
            Caption = 'Descuadre';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; Arch; Decimal)
        {
            Caption = 'Arqueo';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(24; "Card Sales"; Decimal)
        {
            Caption = 'Ventas tarjeta';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "POS Amount"; Decimal)
        {
            Caption = 'Importe datáfono';
            DataClassification = ToBeClassified;
        }
        field(26; "Pay-to Bank"; Decimal)
        {
            Caption = 'Ingreso en banco';
            DataClassification = ToBeClassified;
        }
        field(27; Comentarios; Text[250])
        {
            Caption = 'Comentarios';
            DataClassification = ToBeClassified;
        }
        field(28; Sales; Decimal)
        {
            Caption = 'Ventas';
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount where("Posting Date" = field(Date),
                                                                         "User ID" = field("User Id"),
                                                                         "Document Type" = filter(Invoice | "Credit Memo")));
            Editable = false;

        }
        field(29; Title; Option)
        {
            Caption = 'Título';
            OptionMembers = " ";
        }
    }

    keys
    {
        key(Key1; "User ID", Date)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        TestField(Registered, false);
    end;

    trigger OnInsert()
    begin

        "User ID" := UserId;
        if (Date = 0D) then Date := Today;
    end;

    trigger OnModify()
    begin
        TestField(Registered, false);
    end;

    var
        UserDims: Record "User Dimensions_LDR";
        Userid2: Code[20];

    procedure register()
    begin

        TestField(Registered, false);
        TestField(Date);
        TestField("User ID", UserId);
        if (Arch >= 1000) then
            TestField("Pay-to Bank", Arch - 200);

        if Discrepancy <> 0 then begin
            if Comentarios = '' then
                Message('Debes informar las razones del descuadre antes de cerrar la caja')
            else begin
                Registered := true;
                Modify;

                Message('Debería haber %1\Hay %2\Descuadre %3', Arch - "Cash Notes", "end cash", Discrepancy);
            end;
        end else begin
            Registered := true;
            Modify;

            Message('Debería haber %1\Hay %2\Descuadre %3',
                    Arch - "Cash Notes",
                    "end cash",
                    Discrepancy);
        end;
    end;

    procedure calculateendCash()
    begin

        Validate("end cash", ("1 cent." * 0.01) + ("2 cent." * 0.02) + ("5 cent." * 0.05) + ("10 cent." * 0.1) + ("20 cent." * 0.2)
                    + ("50 cent." * 0.5) + ("1 euro" * 1) + ("2 euros" * 2) + ("5 euros" * 5) + ("10 euros" * 10) + ("20 euros" * 20)
                    + ("50 euros" * 50) + ("100 euros" * 100) + ("200 euros" * 200) + ("500 euros" * 500));

        Discrepancy := "end cash" - (Arch - "Cash Notes");
    end;

    procedure calculateArch()
    var
        CustLdgEntry: Record "Cust. Ledger Entry";
        SalesInvHeader: Record "Sales Invoice Header";
        CrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        TestField(Date);
        if UserDims.existsUser(UserId) then
            TestField("User ID", UserId);

        Arch := "Start cash";
        CustLdgEntry.Reset();
        CustLdgEntry.SetFilter("Posting Date", '%1', Date);
        CustLdgEntry.SetFilter("Document Type", '%1|%2', CustLdgEntry."Document Type"::Invoice, CustLdgEntry."Document Type"::"Credit Memo");
        CustLdgEntry.SetFilter("User ID", '%1', "User ID");
        if CustLdgEntry.FindFirst then
            repeat
                if (CustLdgEntry."Document Type" = CustLdgEntry."Document Type"::Invoice) then
                    if SalesInvHeader.Get(CustLdgEntry."Document No.") then
                        if (SalesInvHeader."Payment Method Code" = 'CAJA') OR (SalesInvHeader."Payment Method Code" = 'CAJATEL') then begin
                            CustLdgEntry.Calcfields(Amount);
                            Arch += CustLdgEntry.Amount;
                        end;

                if (CustLdgEntry."Document Type" = CustLdgEntry."Document Type"::"Credit Memo") then
                    if CrMemoHeader.Get(CustLdgEntry."Document No.") then
                        if (CrMemoHeader."Payment Method Code" = 'CAJA') OR (CrMemoHeader."Payment Method Code" = 'CAJATEL') then begin
                            CustLdgEntry.Calcfields(Amount);
                            Arch += CustLdgEntry.Amount;
                        end;
            until CustLdgEntry.Next = 0;
        Discrepancy := "end cash" - (Arch - "Cash Notes");

        "Card Sales" := 0;
        CustLdgEntry.Reset();
        CustLdgEntry.SetFilter("Posting Date", '%1', Date);
        CustLdgEntry.SetFilter("Document Type", '%1|%2', CustLdgEntry."Document Type"::Invoice, CustLdgEntry."Document Type"::"Credit Memo");
        CustLdgEntry.SetFilter("User ID", '%1', "User ID");
        if CustLdgEntry.FindFirst then
            repeat
                if (CustLdgEntry."Document Type" = CustLdgEntry."Document Type"::Invoice) then
                    if SalesInvHeader.Get(CustLdgEntry."Document No.") then
                        if (SalesInvHeader."Payment Method Code" = 'TJTA') OR (SalesInvHeader."Payment Method Code" = 'TJTATEL') then begin
                            CustLdgEntry.Calcfields(Amount);
                            "Card Sales" += CustLdgEntry.Amount;
                        end;

                if (CustLdgEntry."Document Type" = CustLdgEntry."Document Type"::"Credit Memo") then
                    if CrMemoHeader.Get(CustLdgEntry."Document No.") then
                        if (CrMemoHeader."Payment Method Code" = 'TJTA') OR (CrMemoHeader."Payment Method Code" = 'TJTATEL') then begin
                            CustLdgEntry.Calcfields(Amount);
                            "Card Sales" += CustLdgEntry.Amount;
                        end;
            until CustLdgEntry.Next = 0;
    end;
}

