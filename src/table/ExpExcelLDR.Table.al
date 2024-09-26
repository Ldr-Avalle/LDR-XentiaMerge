table 50013 "Exp. Excel_LDR"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Código; Code[10])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Código)
        {
            Clustered = true;
        }
    }

    //TODO: Implementar funciones de excel sin .dll
    procedure CrearExcel(MostrarDesdeInicio: Boolean)
    begin

    end;

    procedure AbrirExcel(fileName: Text[250])
    begin

    end;

    procedure NuevoWorkbook(nombreHoja: Text[30])
    begin

    end;

    procedure GuardarComo(fileName: Text[250])
    begin

    end;

    procedure CerrarExcel(Action: Option "Visible","PrintAndQuit","Quit")
    begin

    end;

    procedure NuevaSheet(nombreHoja: Text[30])
    begin

    end;

    procedure NuevoValor(sheetName: Text[30]; cellRef: Text[5]; cellValue: Variant; cellBold: Boolean; cellItalic: Boolean; cellUnderline: Boolean; cellFontSize: Integer; cellFontColor: Integer; cellInteriorColor: Integer)
    begin

    end;

    procedure MostrarExcel(siNo: Boolean)
    begin

    end;

    procedure AjustarColumnas(sheetName: Text[30]; colIndex: Integer; colSize: Integer)
    begin

    end;

    procedure CrearGráfico(sheetName: Text[30]; posX: Integer; posY: Integer; width: Integer; height: Integer; dataOriginSheetName: Text[30]; dataOriginFrom: Text[5]; dataOriginTo: Text[5])
    begin

    end;

}