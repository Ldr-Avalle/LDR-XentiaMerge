xmlport 50099 ImportaActivos
{
    FieldDelimiter = '<None>';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(FileRoot)
        {
            tableelement(Integer; Integer)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                XmlName = 'DummyTable';
                SourceTableView = sorting(Number);
                textelement(gblNumero)
                {
                }
                textelement(gblCoste)
                {
                }
                textelement(gblAmor)
                {
                }

                trigger OnBeforeInsertRecord()
                begin
                    CrearRegistro();
                end;
            }
        }
    }

    trigger OnPreXmlPort()
    begin
        NombreLibro := 'ACTIVOS';
        NombreSeccion := 'GENERICO';
    end;

    var
        Libro: Record "FA Journal Template";
        Seccion: Record "FA Journal Batch";
        LinDiarioAF: Record "FA Journal Line";
        regActivo: Record "Fixed Asset";
        regLibroAmort: Record "FA Depreciation Book";
        regActivoOriginal: Record "Fixed Asset";
        regLibroAmortOrig: Record "FA Depreciation Book";
        NombreLibro: Code[10];
        NombreSeccion: Code[10];
        NroLinea: Integer;

    procedure CrearRegistro()
    begin
        if gblNumero = '' then
            exit;

        regActivoOriginal.ChangeCompany('Actin Soluciones, S.L.');
        regActivoOriginal.Get(gblNumero);
        regLibroAmortOrig.ChangeCompany('Actin Soluciones, S.L.');
        regLibroAmortOrig.Get(gblNumero, 'COMPAÑIA');

        gblNumero := 'AS-' + gblNumero;

        regActivo.Init();
        regActivo.Validate("No.", gblNumero);
        if regActivo.Insert() then;

        regActivo.Validate(Description, regActivoOriginal.Description);
        regActivo.Validate("FA Posting Group", regActivoOriginal."FA Posting Group");
        regActivo."Global Dimension 1 Code" := regActivoOriginal."Global Dimension 1 Code";
        regActivo."Global Dimension 2 Code" := regActivoOriginal."Global Dimension 2 Code";
        regActivo.Modify();
        GestionDimension();

        regLibroAmort.Init();
        regLibroAmort."FA No." := regActivo."No.";
        regLibroAmort."Depreciation Book Code" := 'COMPAÑIA';
        regLibroAmort."FA Posting Group" := regLibroAmortOrig."FA Posting Group";
        regLibroAmort."Depreciation Starting Date" := regLibroAmortOrig."Depreciation Starting Date";
        regLibroAmort."Acquisition Date" := regLibroAmortOrig."Acquisition Date";
        regLibroAmort."Depreciation Method" := regLibroAmortOrig."Depreciation Method"::"Straight-Line";
        regLibroAmort."No. of Depreciation Years" := regLibroAmortOrig."No. of Depreciation Years";
        regLibroAmort."Straight-Line %" := regLibroAmortOrig."Straight-Line %";

        regLibroAmort.Insert(true);

        InsertarCoste();
        InsertarAmortizacion();

        LimpiaRegistro();
    end;

    procedure LimpiaRegistro()
    begin
        gblCoste := '';
        gblAmor := '';
        gblNumero := '';
    end;

    procedure InsertarCoste()
    begin
        NroLinea += 10000;
        LinDiarioAF.Init();
        LinDiarioAF.Validate("Journal Template Name", NombreLibro);
        LinDiarioAF.Validate("Journal Batch Name", NombreSeccion);
        LinDiarioAF.Validate("Line No.", NroLinea);
        LinDiarioAF.Validate("FA Posting Date", regLibroAmortOrig."Depreciation Starting Date");
        LinDiarioAF."Document No." := 'FUSION';
        LinDiarioAF.Validate("FA No.", gblNumero);
        LinDiarioAF.Validate("Depreciation Book Code", 'COMPAÑIA');
        LinDiarioAF.Validate("FA Posting Type", LinDiarioAF."FA Posting Type"::"Acquisition Cost");
        Evaluate(LinDiarioAF.Amount, gblCoste);
        LinDiarioAF.Validate(Amount);
        LinDiarioAF.Insert();
    end;

    procedure InsertarAmortizacion()
    begin
        NroLinea += 10000;
        LinDiarioAF.Init();
        LinDiarioAF.Validate("Journal Template Name", NombreLibro);
        LinDiarioAF.Validate("Journal Batch Name", NombreSeccion);
        LinDiarioAF.Validate("Line No.", NroLinea);
        LinDiarioAF.Validate("FA Posting Date", 20221231D);
        LinDiarioAF."Document No." := 'FUSION';
        LinDiarioAF.Validate("FA No.", gblNumero);
        LinDiarioAF.Validate("Depreciation Book Code", 'COMPAÑIA');
        LinDiarioAF.Validate("FA Posting Type", LinDiarioAF."FA Posting Type"::Depreciation);
        Evaluate(LinDiarioAF.Amount, gblAmor);
        LinDiarioAF.Validate(Amount);
        LinDiarioAF.Insert();
    end;

    procedure GestionDimension(): Code[10]
    var
        regDimen: Record "Default Dimension";
        regDimenOriginal: Record "Default Dimension";
        regDimValue: Record "Dimension Value";
    begin

        regDimenOriginal.Reset();
        regDimenOriginal.ChangeCompany('Actin Soluciones, S.L.');
        regDimenOriginal.SetRange("Table ID", 5600);
        regDimenOriginal.SetRange("No.", regActivoOriginal."No.");
        if regDimenOriginal.FindSet() then
            repeat
                if not regDimValue.Get(regDimenOriginal."Dimension Code", regDimenOriginal."Dimension Value Code") then begin
                    Clear(regDimValue);
                    regDimValue.Validate("Dimension Code", regDimenOriginal."Dimension Code");
                    regDimValue.Validate(Code, regDimenOriginal."Dimension Value Code");
                    regDimValue.Insert();
                end;
                if regDimValue.Blocked then begin
                    regDimValue.Validate(Blocked, false);
                    regDimValue.Modify();
                end;

                Clear(regDimen);
                regDimen.Validate("Table ID", 5600);
                regDimen.Validate("No.", regActivo."No.");
                regDimen.Validate("Dimension Code", regDimenOriginal."Dimension Code");
                regDimen.Validate("Dimension Value Code", regDimenOriginal."Dimension Value Code");
                regDimen.Insert();
            until regDimenOriginal.Next() = 0;
    end;
}