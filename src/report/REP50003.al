report 50003 "Get SharePoint Contracts"
{
    ProcessingOnly = true;

    dataset
    {
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

    trigger OnInitReport()
    begin

        OpenMethod := 3; // 1=adOpenKeyset; 2=adOpenDynamic; 3= adOpenStatic
        LockMethod := 2; // 1=dLockreadonly; 2=adLockPessimistic; 3=adLockOptimistic; 4=adLockBatchOptimistic
    end;

    trigger OnPostReport()
    begin

        // Close odbc connector
        AdoRs.Close;
        AdoConn.Close;

        CLEAR(AdoRs);
        CLEAR(AdoConn);
    end;

    trigger OnPreReport()
    var
        ContractLines: Record "50006";
        LastContractLineSpID: Integer;
    begin

        //inicializo y abro conexión
        CLEAR(AdoConn);
        CREATE(AdoConn);
        ConnStr := 'Provider=SQLNCLI10;Server=AFMQUALITY\OFFICESERVERS;Database=intranetSercable;Uid=serviciosbdc; Pwd=1314jckr7@;';
        AdoConn.Open(ConnStr);

        ImportNewContracts();
        ImportNewContractLines();

        //despliego resultados
        MESSAGE('Importaci´Š¢n completada');
    end;

    var
        AdoConn: Automation;
        AdoRs: Automation;
        ConnStr: Text[200];
        OpenMethod: Integer;
        LockMethod: Integer;
        Name: Text[200];
        Str: Text[200];
        Texto: Text[200];

    procedure ImportNewContracts()
    var
        Contract: Record "50005";
        LastContractSpID: Integer;
        "Query": Text[255];
    begin
        //consulto los datos de contratos NAV
        Contract.SETCURRENTKEY("SharePoint ID");
        IF Contract.FINDLAST THEN
            LastContractSpID := Contract."SharePoint ID"
        ELSE
            LastContractSpID := 0;

        //importo los contratos de la intranet
        //hago Select sobre una vista previamente creada con * o la consulta se pasa de 255 chars que admite Text
        CLEAR(AdoRs);
        CREATE(AdoRs);
        Query := 'Select * From ContratosTelecable Where tp_ID > ' + FORMAT(LastContractSpID);
        AdoRs.Open(Query, AdoConn, OpenMethod, LockMethod);

        IF NOT AdoRs.EOF THEN BEGIN
            AdoRs.MoveFirst;
            WHILE AdoRs.EOF = FALSE DO BEGIN
                Contract.INIT;
                Contract.Code := '';
                Contract."Shortcut Dimension 1 Code" := 'TELECABLE';
                Contract."SharePoint ID" := AdoRs.Fields.Item('tp_ID').Value;
                Contract."SharePoint Created by ID" := FORMAT(AdoRs.Fields.Item('tp_Author').Value);
                EVALUATE(Contract."SharePoint Created", FORMAT(AdoRs.Fields.Item('tp_Created').Value));
                Contract."SharePoint Modified by ID" := FORMAT(AdoRs.Fields.Item('tp_Editor').Value);
                EVALUATE(Contract."SharePoint Modified", FORMAT(AdoRs.Fields.Item('tp_Modified').Value));
                Contract.Demarcation := FORMAT(AdoRs.Fields.Item('nvarchar3').Value);
                Contract.Segment := FORMAT(AdoRs.Fields.Item('nvarchar4').Value);
                Contract.NIF := FORMAT(AdoRs.Fields.Item('nvarchar5').Value);
                Contract.Name := FORMAT(AdoRs.Fields.Item('nvarchar6').Value);
                Contract.Address := FORMAT(AdoRs.Fields.Item('nvarchar7').Value);
                Contract."N´Š¢" := FORMAT(AdoRs.Fields.Item('nvarchar13').Value);
                Contract.Floor := FORMAT(AdoRs.Fields.Item('nvarchar14').Value);
                Contract.County := GetCode(FORMAT(AdoRs.Fields.Item('nvarchar11').Value), Contract."SharePoint ID");
                Contract.CP := FORMAT(AdoRs.Fields.Item('float1').Value);
                Contract."Phone 1" := FORMAT(AdoRs.Fields.Item('float2').Value);
                Contract."Phone 2" := FORMAT(AdoRs.Fields.Item('float3').Value);
                EVALUATE(Contract."Sign date", FORMAT(AdoRs.Fields.Item('datetime1').Value));
                Contract."ID Comercial" := FORMAT(AdoRs.Fields.Item('int3').Value);
                Contract.Comercial := FORMAT(AdoRs.Fields.Item('comercial').Value);
                Contract."SharePoint Created by" := FORMAT(AdoRs.Fields.Item('creador').Value);
                Contract."SharePoint Modified by" := FORMAT(AdoRs.Fields.Item('editor').Value);
                Contract.INSERT(TRUE);
                AdoRs.MoveNext
            END;
        END;
    end;

    procedure ImportNewContractLines()
    var
        ContractLines: Record "50006";
        LastContractLineSpID: Integer;
        "Query": Text[255];
        RefDate: Date;
    begin
        //consulto los datos de l´Š¢neas de contratos NAV
        ContractLines.SETCURRENTKEY("SharePoint ID");
        IF ContractLines.FINDLAST THEN
            LastContractLineSpID := ContractLines."SharePoint ID"
        ELSE
            LastContractLineSpID := 0;

        //importo los contratos de la intranet
        //hago Select sobre una vista previamente creada con * o la consulta se pasa de 255 chars que admite Text
        //uso para servicio y cantidad, nvarchar6 y float 2 que son comunes a todos los tipos de contenido y adem´Š¢s nunca tienen NULL
        CLEAR(AdoRs);
        CREATE(AdoRs);
        Query := 'Select * From LineasContratosTelecable Where tp_ID > ' + FORMAT(LastContractLineSpID);
        AdoRs.Open(Query, AdoConn, OpenMethod, LockMethod);

        IF NOT AdoRs.EOF THEN BEGIN
            AdoRs.MoveFirst;
            WHILE AdoRs.EOF = FALSE DO BEGIN
                ContractLines.INIT;
                ContractLines.Contract := GetContractBySharePointId(FORMAT(AdoRs.Fields.Item('int1').Value));
                ContractLines."Line No." := 0;
                ContractLines."SharePoint ID" := AdoRs.Fields.Item('tp_ID').Value;
                ContractLines."SharePoint Created by ID" := FORMAT(AdoRs.Fields.Item('tp_Author').Value);
                EVALUATE(ContractLines."SharePoint Created", FORMAT(AdoRs.Fields.Item('tp_Created').Value));
                ContractLines."SharePoint Modified by ID" := FORMAT(AdoRs.Fields.Item('tp_Editor').Value);
                EVALUATE(ContractLines."SharePoint Modified", FORMAT(AdoRs.Fields.Item('tp_Modified').Value));
                ContractLines."SharePoint Created by" := FORMAT(AdoRs.Fields.Item('creador').Value);
                ContractLines."SharePoint Modified by" := FORMAT(AdoRs.Fields.Item('editor').Value);
                ContractLines.Service := GetCode(FORMAT(AdoRs.Fields.Item('nvarchar6').Value), ContractLines."SharePoint ID");
                EVALUATE(ContractLines.Quantity, FORMAT(AdoRs.Fields.Item('float2').Value));
                EVALUATE(ContractLines."Activation date", FORMAT(AdoRs.Fields.Item('datetime1').Value));
                ContractLines.Promotion := GetPromotion(FORMAT(AdoRs.Fields.Item('nvarchar5').Value), ContractLines."SharePoint ID");

                EVALUATE(RefDate, '01/01/1900');
                IF ContractLines."Activation date" = RefDate THEN ContractLines."Activation date" := 0D;

                ContractLines.INSERT(TRUE);
                AdoRs.MoveNext
            END;
        END;
    end;

    procedure GetCode(String: Text[100]; RecCodeForErrors: Integer) StringCode: Code[20]
    var
        InitCode: Integer;
        EndCode: Integer;
    begin
        //los codigos los almaceno entre par´Š¢ntesis al final de cada nombre (servicio, campa´Š¢a, poblaci´Š¢n, ...)
        InitCode := STRPOS(String, '(') + 1;
        EndCode := STRPOS(String, ')');

        EXIT(COPYSTR(String, InitCode, EndCode - InitCode));
    end;

    procedure GetPromotion(String: Text[70]; RecCodeErrors: Integer) PromoId: Code[20]
    begin
        //los codigos los almaceno entre par´Š¢ntesis al final de cada nombre (servicio, campa´Š¢a, poblaci´Š¢n, ...)
        //las campa´Š¢as tienes por defecto '(ninguna)' porque la columna de SharePoint BdcWss da error si la lista no tiene valores
        IF String = '(ninguna)' THEN
            EXIT('')
        ELSE
            EXIT(GetCode(String, RecCodeErrors));
    end;

    procedure GetContractBySharePointId(SharePointId: Text[20]) ContractId: Code[20]
    var
        Contract: Record "50005";
        IntSpId: Integer;
    begin
        EVALUATE(IntSpId, SharePointId);

        Contract.SETFILTER("SharePoint ID", '%1', IntSpId);
        IF Contract.FINDFIRST THEN EXIT(Contract.Code);
    end;
}

