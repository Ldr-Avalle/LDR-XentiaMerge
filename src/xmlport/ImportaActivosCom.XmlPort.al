xmlport 80014 ImportaActivosCom
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
                textelement(gblPor)
                {
                }
                textelement(gblANOS)
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
        if not Seccion.Get(NombreLibro, NombreSeccion) then begin
            Seccion."Journal Template Name" := NombreLibro;
            Seccion.Name := NombreSeccion;
            Seccion.Insert();
        end;

        LinDiarioAF.Reset();
        LinDiarioAF.SetRange("Journal Template Name", NombreLibro);
        LinDiarioAF.SetRange("Journal Batch Name", NombreSeccion);
        if LinDiarioAF.Find('-') then
            LinDiarioAF.DeleteAll();

        NroLinea := 0;
    end;

    var
        Libro: Record "FA Journal Template";
        Seccion: Record "FA Journal Batch";
        LinDiarioAF: Record "FA Journal Line";
        UpdateContFromCust: Codeunit "CustCont-Update";
        NombreLibro: Code[10];
        NombreSeccion: Code[10];
        NroLinea: Integer;

    procedure CrearRegistro()
    var
        regActivo: Record "Fixed Asset";
        regLibroAmort: Record "FA Depreciation Book";
        regLibroAmortAux: Record "FA Depreciation Book";
        regProv: Record Vendor;
        regFa: Record "FA Ledger Entry";
        fecha: Date;
    begin
        if gblNumero = '' then
            exit;
        gblNumero := RellenaCeros(gblNumero, 8);

        LimpiaRegistro()
    end;

    procedure LimpiaRegistro()
    begin
        gblPor := '';
        gblAmor := '';
        gblNumero := '';
        gblANOS := '';
    end;

    procedure RellenaCeros(numero: Text[250]; long: Integer): Text[250]
    begin
        if StrLen(numero) < long then
            repeat
                numero := '0' + numero;
            until StrLen(numero) = long;
        exit(numero);
    end;
}