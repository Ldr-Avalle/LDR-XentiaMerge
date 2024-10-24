report 50003 "Get SharePoint Contracts"
{
    /*
    ApplicationArea = All;
    Caption = 'Get SharePoint Contracts';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    trigger OnInitReport()
    begin
        OpenMethod := 3; 
        LockMethod := 2;
    end;

    trigger OnPostReport()
    begin
        OdbcConnection.Close; //TODO:DotNet
        CLEAR(OdbcConnection);

    end;

    trigger OnPreReport()
    var
        ContractLines: Record "50006";
        LastContractLineSpID: Integer;
    begin
        OdbcConnection := OdbcConnection.OdbcConnection; //TODO:DotNet
        OdbcConnection.ConnectionString := 'Provider=SQLNCLI10;Server=AFMQUALITY\OFFICESERVERS;Database=intranetSercable;Uid=serviciosbdc; Pwd=1314jckr7@;';
        OdbcConnection.Open;



        ImportNewContracts();
        ImportNewContractLines();

        MESSAGE('Importación completada');
    end;

    var        
        AdoConn: Automation;
        AdoRs: Automation;
        OdbcConnection: DotNet : System.Data.Odbc.OdbcConnection.'System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'
Command: DotNet : System.Data.Odbc.OdbcCommand.'System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'
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
        Contract.SETCURRENTKEY("SharePoint ID");
        IF Contract.FINDLAST THEN
            LastContractSpID := Contract."SharePoint ID"
        ELSE
            LastContractSpID := 0;
        
        CLEAR(AdoRs);
        CREATE(AdoRs);
        
        Query := 'Select * From ContratosTelecable Where tp_ID > ' + FORMAT(LastContractSpID);
        AdoRs.Open(Query, AdoConn, OpenMethod, LockMethod);
        Command := Command.OdbcCommand(Query, OdbcConnection);


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
        ContractLines.SETCURRENTKEY("SharePoint ID");
        IF ContractLines.FINDLAST THEN
            LastContractLineSpID := ContractLines."SharePoint ID"
        ELSE
            LastContractLineSpID := 0;

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
        InitCode := STRPOS(String, '(') + 1;
        EndCode := STRPOS(String, ')');

        EXIT(COPYSTR(String, InitCode, EndCode - InitCode));
    end;

    procedure GetPromotion(String: Text[70]; RecCodeErrors: Integer) PromoId: Code[20]
    begin
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
    */
}

