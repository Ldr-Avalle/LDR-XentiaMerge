codeunit 50002 FuncionesGenericas
{
    /*
    TODO: cod 50005
    VAR
        txtFileDialog: Label 'Selecciona el fichero excel de MRW.';
        TxtExtensions: Label 'Los fichero Excel de MRW tienen las extensiones (%1), el fichero "%2" seleccionado tiene la siguiente extensión errónea "%3".';
        ExtensionsAllowed: Label 'xlsx';
        SendNumber_Global: Text;
        MRWPurchInvHeaderTemp: Record 50152 temporary;
        VentanaNotificacion: Dialog;
        Progreso: Integer;
        TotalLine: Integer;
        CurrLine: Integer;
        EsAbono: Boolean;
        Base: Decimal;
        Total: Decimal;
        PuchInvHeader: Record 122;
        ImportXMLVECI: Codeunit 50006;
        CtaGasto: Code[20];
        Proveedor: Code[20];

    PROCEDURE GetExcelForImportMRWExcel_ButtonPurchInv(PathPlusFile_Excel: Text; VisualiceImportedData: Boolean)
    VAR
        FileName: Text;
        SheetName: Text;
        checkExtension: Boolean;
        Path_Excel: Text;
        ExcelBuffer: Record 370;
        ImportacionesMRW: Page 50152;
        MRWPurchInvHeader: Record 50152;
    BEGIN

        IF PathPlusFile_Excel <> '' THEN BEGIN
            SplitFileName(PathPlusFile_Excel, Path_Excel, FileName);
            checkExtension := FALSE;
            IF COPYSTR(FileName, STRLEN(FileName) - 3, 4) = 'xlsx' THEN
                checkExtension := TRUE;
            IF NOT checkExtension THEN
                ERROR(STRSUBSTNO(TxtExtensions,
                ExtensionsAllowed
                , FileName,
                COPYSTR(FileName, STRLEN(FileName) - 3, 4)));
            SheetName := ExcelBuffer.SelectSheetsName(PathPlusFile_Excel);
            //SheetName :='EXCELL';
            ImportMRWExcel(PathPlusFile_Excel, SheetName);
            IF VisualiceImportedData THEN BEGIN
                MRWPurchInvHeader.SETFILTER(SendNumber, SendNumber_Global);
                MRWPurchInvHeader.SETRANGE(Registrado, FALSE);
                IF MRWPurchInvHeader.FINDSET(TRUE, TRUE) THEN BEGIN
                    ImportacionesMRW.SETRECORD(MRWPurchInvHeader);
                    ImportacionesMRW.SETTABLEVIEW(MRWPurchInvHeader);
                    ImportacionesMRW.EDITABLE(TRUE);
                    COMMIT;
                    ImportacionesMRW.RUNMODAL;
                    ImportacionesMRW.GETRECORD(MRWPurchInvHeader);
                END;
            END;

        END;
    END;

    PROCEDURE GetExcelForImportMRWExcel()
    VAR
        FileManagement: Codeunit 419;
        FileName: Text;
        SheetName: Text;
        ExcelBuffer: Record 370;
        PathPlusFile_Excel: Text;
        InStream_Excel: InStream;
        OutStream_Excel: OutStream;
        checkExtension: Boolean;
        Path_Excel: Text;
    BEGIN

        PathPlusFile_Excel := RequestFile(PathPlusFile_Excel);
        IF PathPlusFile_Excel <> '' THEN BEGIN
            SplitFileName(PathPlusFile_Excel, Path_Excel, FileName);
            checkExtension := FALSE;
            IF COPYSTR(FileName, STRLEN(FileName) - 3, 4) = 'xlsx' THEN
                checkExtension := TRUE;
            IF NOT checkExtension THEN
                ERROR(STRSUBSTNO(TxtExtensions,
                ExtensionsAllowed
                , FileName,
                COPYSTR(FileName, STRLEN(FileName) - 3, 4)));

            SheetName := ExcelBuffer.SelectSheetsName(PathPlusFile_Excel);
            ImportMRWExcel(PathPlusFile_Excel, SheetName);
        END;
    END;

    LOCAL PROCEDURE SplitFileName(Filename: Text[250]; VAR Path: Text[250]; VAR Name: Text[250])
    VAR
        Found: Boolean;
        Pos: Integer;
    BEGIN
        Path := '';
        Name := '';
        Filename := DELCHR(Filename, '<>');
        IF (Filename = '') THEN
            EXIT;

        Pos := STRLEN(Filename);
        REPEAT
            Found := (COPYSTR(Filename, Pos, 1) = '\');
            IF NOT Found THEN
                Pos := Pos - 1;
        UNTIL (Pos = 0) OR Found;

        IF Found THEN BEGIN
            Path := COPYSTR(Filename, 1, Pos);
            Name := COPYSTR(Filename, Pos + 1);
        END ELSE BEGIN
            Path := '';
            Name := Filename;
        END;
    END;

    LOCAL PROCEDURE ImportMRWExcel(FileName: Text; Sheet: Text)
    VAR
        ExcelBuffer: Record 370;
        FileManagement: Codeunit 419;
        MyDialog: Dialog;
        ProgressBar: Integer;
        MyNext: Integer;
        Fields: Text;
        TotalFields: Text;
        I: Integer;
        TotalRows: Integer;
        TxtEndProcess: TextConst 'ENU=Importaci¢n MRW del fichero "%1", con "%2 registros", finalizada.;ESN=Importaci¢n MRW del fichero "%1", con "%2 registros", finalizada.';
        Text0002: TextConst 'ESP=Debe seleccionar un fichero';
        Text0004: TextConst 'ESP=Linea %1 importada.';
        Text0003: TextConst 'ENU=Importando datos del fichero. Porfavor espere.ÿ@1@@@@@@@@@@@@@@@@@@;ESP=Importando datos del fichero. Porfavor espere.ÿ@1@@@@@@@@@@@@@@@@@@;ESN=Importando datos del fichero. Porfavor espere.ÿ@1@@@@@@@@@@@@@@@@@@';
    BEGIN
        ExcelBuffer.LOCKTABLE;
        ExcelBuffer.OpenBook(FileName, Sheet);
        ExcelBuffer.ReadSheet;
        TotalRows := ExcelBuffer.COUNT;
        MyDialog.OPEN(Text0003);
        FOR I := 2 TO TotalRows DO BEGIN
            InsertDataExcel(I);
            MyDialog.UPDATE(1, I);
        END;
        ExcelBuffer.DELETEALL;
        SplitFileName(FileName, FileName, FileName);
        MESSAGE(STRSUBSTNO(TxtEndProcess, FileName, TotalRows));
        MyDialog.CLOSE;
    END;

    LOCAL PROCEDURE CreateExcel(ExcelFileName: Text; ExcelSheet: Text; TempExcelBuffer: Record 370)
    VAR
        FileManagement: Codeunit 419;
        FileName: Text;
        FileVar: File;
    BEGIN
        TempExcelBuffer.CreateBookAndOpenExcel('', ExcelSheet, '', COMPANYNAME, USERID);
        TempExcelBuffer.CloseBook;
    END;

    LOCAL PROCEDURE EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; TempExcelBuffer: Record 370)
    BEGIN
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.INSERT;
    END;

    LOCAL PROCEDURE GetValueCell(RoWNo: Integer; ColNo: Integer): Text;
    VAR
        ExcelBuffer: Record 370;
    BEGIN
        IF ExcelBuffer.GET(RoWNo, ColNo) THEN
            IF ExcelBuffer."Cell Value as Text" <> '' THEN
                EXIT(ExcelBuffer."Cell Value as Text")
            ELSE
                EXIT('0');
    END;

    LOCAL PROCEDURE InsertDataExcel(RowNo: Integer);
    VAR
        MRWPurchInvHeader: Record 50152;
        SendNumber_: Code[60];
    BEGIN
        IF GetValueCell(RowNo, 2) <> '' THEN BEGIN

            MRWPurchInvHeader.INIT;
            EVALUATE(SendNumber_, GetValueCell(RowNo, 2));
            IF SendNumber_Global = '' THEN
                SendNumber_Global := SendNumber_;
            IF SendNumber_Global <> SendNumber_ THEN
                SendNumber_Global := SendNumber_Global + '|' + SendNumber_;
            MRWPurchInvHeader.SETRANGE(SendNumber, SendNumber_);

            IF MRWPurchInvHeader.FINDSET(TRUE, TRUE) THEN BEGIN
                REPEAT
                    EVALUATE(MRWPurchInvHeader.SendDate, GetValueCell(RowNo, 1));
                    EVALUATE(MRWPurchInvHeader.SendNumber, GetValueCell(RowNo, 2));
                    EVALUATE(MRWPurchInvHeader.Subscriber, GetValueCell(RowNo, 3));
                    EVALUATE(MRWPurchInvHeader.ClientReference, GetValueCell(RowNo, 4));
                    EVALUATE(MRWPurchInvHeader."Centro de coste", GetValueCell(RowNo, 5));
                    EVALUATE(MRWPurchInvHeader.Name, GetValueCell(RowNo, 6));
                    EVALUATE(MRWPurchInvHeader.Address, GetValueCell(RowNo, 7));
                    EVALUATE(MRWPurchInvHeader.Name2, GetValueCell(RowNo, 8));
                    EVALUATE(MRWPurchInvHeader.Obeservations, GetValueCell(RowNo, 9));
                    EVALUATE(MRWPurchInvHeader.City_iuser, GetValueCell(RowNo, 10));
                    EVALUATE(MRWPurchInvHeader.Province_iuser, GetValueCell(RowNo, 11));
                    EVALUATE(MRWPurchInvHeader.BundlesTotal, GetValueCell(RowNo, 12));
                    EVALUATE(MRWPurchInvHeader.BundleWeight, GetValueCell(RowNo, 13));
                    EVALUATE(MRWPurchInvHeader.ServiceCode, GetValueCell(RowNo, 14));
                    EVALUATE(MRWPurchInvHeader.Taxbase, GetValueCell(RowNo, 15));
                    EVALUATE(MRWPurchInvHeader.Amount, GetValueCell(RowNo, 16));
                    MRWPurchInvHeader.MODIFY;
                UNTIL MRWPurchInvHeader.NEXT = 0

            END ELSE BEGIN
                EVALUATE(MRWPurchInvHeader.SendDate, GetValueCell(RowNo, 1));
                EVALUATE(MRWPurchInvHeader.SendNumber, GetValueCell(RowNo, 2));
                EVALUATE(MRWPurchInvHeader.Subscriber, GetValueCell(RowNo, 3));
                EVALUATE(MRWPurchInvHeader.ClientReference, GetValueCell(RowNo, 4));
                EVALUATE(MRWPurchInvHeader."Centro de coste", GetValueCell(RowNo, 5));
                EVALUATE(MRWPurchInvHeader.Name, GetValueCell(RowNo, 6));
                EVALUATE(MRWPurchInvHeader.Address, GetValueCell(RowNo, 7));
                EVALUATE(MRWPurchInvHeader.Name2, GetValueCell(RowNo, 8));
                EVALUATE(MRWPurchInvHeader.Obeservations, GetValueCell(RowNo, 9));
                EVALUATE(MRWPurchInvHeader.City_iuser, GetValueCell(RowNo, 10));
                EVALUATE(MRWPurchInvHeader.Province_iuser, GetValueCell(RowNo, 11));
                EVALUATE(MRWPurchInvHeader.BundlesTotal, GetValueCell(RowNo, 12));
                EVALUATE(MRWPurchInvHeader.BundleWeight, GetValueCell(RowNo, 13));
                EVALUATE(MRWPurchInvHeader.ServiceCode, GetValueCell(RowNo, 14));
                EVALUATE(MRWPurchInvHeader.Taxbase, GetValueCell(RowNo, 15));
                EVALUATE(MRWPurchInvHeader.Amount, GetValueCell(RowNo, 16));
                MRWPurchInvHeader.INSERT;
            END;
        END;
    END;

    PROCEDURE RequestFile(FileName: Text) ServerFileName: Text;
    VAR
        FileManagement: Codeunit 419;
    BEGIN
        IF FileName <> '' THEN BEGIN
            ServerFileName := FileManagement.UploadFile(txtFileDialog, FileName);
        END ELSE BEGIN
            ServerFileName := FileManagement.UploadFile(txtFileDialog, '.xlsx');
        END;
    END;

    LOCAL PROCEDURE CreatePurchaseHeader();
    VAR
        PurchInvoiceHeaderBuffer: Record 50153;
        PurchaseHeader: Record 38;
    BEGIN
        WITH PurchInvoiceHeaderBuffer DO BEGIN
            RESET;
            SETRANGE(Imported, FALSE);
            SETRANGE(UserIdCode, USERID);
            IF FINDFIRST THEN BEGIN
                REPEAT
                    EsAbono := ImporteTotal < 0;
                    PurchaseHeader.INIT;
                    PurchaseHeader.RESET;
                    IF EsAbono THEN
                        PurchaseHeader.VALIDATE("Document Type", PurchaseHeader."Document Type"::"Credit Memo")
                    ELSE
                        PurchaseHeader.VALIDATE("Document Type", PurchaseHeader."Document Type"::Invoice);
                    IF EsAbono THEN
                        PurchaseHeader.VALIDATE("Vendor Cr. Memo No.", No)
                    ELSE
                        PurchaseHeader.VALIDATE("Vendor Invoice No.", No);

                    PurchaseHeader.VALIDATE("Buy-from Vendor No.", "Vendor No.");
                    PurchaseHeader.VALIDATE("Due Date", FechaDeVto);

                    IF NOT EsAbono THEN BEGIN
                        PurchaseHeader.VALIDATE("No. Series", 'GT');
                        PurchaseHeader.VALIDATE("Posting No. Series", 'GTREG');
                    END;

                    IF PurchaseHeader.INSERT(TRUE) THEN BEGIN
                        IF NOT EsAbono THEN BEGIN
                            PurchaseHeader.VALIDATE("No. Series", 'GT');
                            PurchaseHeader.VALIDATE("Posting No. Series", 'GTREG');
                        END;
                        PurchaseHeader.VALIDATE("Posting Date", FechaDeEmision);
                        //        PurchaseHeader.VALIDATE("Shortcut Dimension 1 Code",GlobalDim1Code);
                        //        PurchaseHeader.VALIDATE("Shortcut Dimension 2 Code",GlobalDim2Code);
                        PurchaseHeader."Shortcut Dimension 1 Code" := GlobalDim1Code;
                        PurchaseHeader."Shortcut Dimension 2 Code" := GlobalDim2Code;
                        //++21/01/21 DMG -- MODIFICACIONES EN LA ESTRUCTURA PARA ABONOS
                        IF EsAbono THEN BEGIN
                            CLEAR(PuchInvHeader);
                            PuchInvHeader.SETRANGE(PuchInvHeader."Buy-from Vendor No.", "Vendor No.");
                            PuchInvHeader.SETRANGE(PuchInvHeader."Vendor Invoice No.", CorrectedInvoiceNo);
                            IF PuchInvHeader.FINDFIRST THEN
                                PurchaseHeader.VALIDATE("Corrected Invoice No.", PuchInvHeader."No.");
                        END;
                        //--21/01/21 DMG -- MODIFICACIONES EN LA ESTRUCTURA PARA ABONOS
                        PurchaseHeader.MODIFY(TRUE);
                        CrearPurchLines(PurchaseHeader."No.", No);
                        PurchaseHeader.CALCFIELDS(Amount);
                        PurchaseHeader.CALCFIELDS("Amount Including VAT");
                        Base := Importe_Base;
                        Total := ImporteTotal;
                        IF EsAbono THEN BEGIN
                            Base := Base * -1;
                            Total := Total * -1;
                        END;
                        IF ABS(PurchaseHeader.Amount - Base) > 0.01 THEN BEGIN
                            MESSAGE('Desviaci¢n de %1° en importe BASE, revisar la factura/Abono', ABS(PurchaseHeader.Amount - Importe_Base));
                        END ELSE
                            IF ABS(PurchaseHeader."Amount Including VAT" - Total) > 0.01 THEN BEGIN
                                MESSAGE('Desviaci¢n de %1° en total con IVA, revisar la factura/Abono', ABS(PurchaseHeader."Amount Including VAT" - ImporteTotal))
                            END;
                        Imported := TRUE;
                        IF MODIFY(TRUE) THEN BEGIN
                            SLEEP(2000);
                            IF EsAbono THEN
                                MESSAGE('Abono %1 Creado', FORMAT(PurchaseHeader."No."))
                            ELSE
                                PAGE.RUN(51, PurchaseHeader);
                            VentanaNotificacion.CLOSE;
                            //FileManagement.MoveAndRenameClientFile(Path + NombreFichero,FORMAT(No) + '.xml.bak',Path); Esta dando error esta funci¢n
                            MESSAGE('Proceso finalizado, documento %1 creado', PurchaseHeader."No.");
                        END;
                    END ELSE
                        ERROR('No se ha podido importar la Factura/Abono');
                UNTIL NEXT = 0;
            END;
        END;
    END;

    LOCAL PROCEDURE CrearPurchLines(InvoiceNo: Code[20]; NoDoc: Code[20]);
    VAR
        PurchInvoiceLineBuffer: Record 50151;
        PurchaseLine: Record 39;
        ImportXMLVECI: Codeunit 50006;
        test: Text;
        PurchInvLinBuffInterface: Record 50149;
    BEGIN
        WITH PurchInvoiceLineBuffer DO BEGIN
            RESET;
            SETRANGE("Doc. No", NoDoc);
            SETRANGE(Imported, FALSE);
            SETRANGE(UserIdCode, USERID);
            TotalLine := COUNT;
            IF FINDSET THEN BEGIN
                CurrLine := 1;
                REPEAT
                    PurchaseLine.INIT;
                    PurchaseLine.RESET;
                    IF EsAbono THEN
                        PurchaseLine.VALIDATE("Document Type", PurchaseLine."Document Type"::"Credit Memo")
                    ELSE
                        PurchaseLine.VALIDATE("Document Type", PurchaseLine."Document Type"::Invoice);
                    PurchaseLine.VALIDATE("Document No.", InvoiceNo);
                    PurchaseLine.VALIDATE("Line No.", "Line No");
                    IF PurchaseLine.INSERT(TRUE) THEN BEGIN
                        PurchaseLine.VALIDATE(Type, PurchaseLine.Type::"G/L Account");
                        CtaGasto := GETCuentaGasto(PurchInvoiceLineBuffer."Descripcion 1");
                        PurchaseLine.VALIDATE("No.", CtaGasto);
                        PurchaseLine.VALIDATE(Quantity, Quantity);
                        PurchaseLine.VALIDATE("Direct Unit Cost", BaseImponible);
                        IF EsAbono THEN
                            PurchaseLine.VALIDATE("Direct Unit Cost", PurchaseLine."Direct Unit Cost" * (-1));
                        //++#0020 DMG 14/10/2020
                        PurchaseLine.VALIDATE("VAT Prod. Posting Group", 'NACIONAL');
                        IF COMPANYNAME = 'IZERTIS' THEN BEGIN
                            //--#0020 DMG 14/10/2020
                            CASE ClaseImpuesto OF
                                'IVA', 'REIVA', 'EXIVA':
                                    CASE "IVA%" OF
                                        21:
                                            PurchaseLine.VALIDATE("VAT Prod. Posting Group", 'IVA21SERV');
                                        10:
                                            PurchaseLine.VALIDATE("VAT Prod. Posting Group", 'IVA10SERV');
                                        0:
                                            PurchaseLine.VALIDATE("VAT Prod. Posting Group", 'EXENTO');
                                    END;
                                'NO SUJETO':
                                    PurchaseLine.VALIDATE("VAT Prod. Posting Group", 'NOSUJETO');
                            END;
                            //++#0020 DMG 14/10/2020
                        END ELSE IF COMPANYNAME = 'IZERTIS CANARIAS' THEN BEGIN
                            CASE ClaseImpuesto OF
                                'IVA', 'REIVA', 'EXIVA', 'IGIC':
                                    CASE "IVA%" OF
                                        15:
                                            PurchaseLine.VALIDATE("VAT Prod. Posting Group", 'IGIC15SER');
                                        7:
                                            PurchaseLine.VALIDATE("VAT Prod. Posting Group", 'IGIC7SER');
                                        0:
                                            PurchaseLine.VALIDATE("VAT Prod. Posting Group", 'EXENTO');
                                    END;
                                'NO SUJETO':
                                    PurchaseLine.VALIDATE("VAT Prod. Posting Group", 'NOSUJETO');
                            END;
                        END;
                        //--#0020 DMG 14/10/2020

                        //PurchaseLine.VALIDATE("Amount Including VAT",PurchInvoiceLineBuffer.ImporteTotal);
                        //<ADM036
                        PurchaseLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
                        //PurchaseLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
                        PurchaseLine.VALIDATE("Job No.", "Job No.");
                        PurchaseLine.VALIDATE("Job Task No.", "Job Task No.");
                        IF PurchaseLine."Shortcut Dimension 1 Code" = '' THEN
                            PurchaseLine."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
                        //ADM036/>

                        PurchaseLine.VALIDATE(Description, COPYSTR("Descripcion 1" + ' ' + NombreViajero, 1, 50));
                        PurchaseLine.VALIDATE("Description 2", "Descripcion 2");

                        IF PurchaseLine.MODIFY(TRUE) THEN BEGIN
                            Imported := TRUE;
                            MODIFY;
                            Progreso := ROUND(CurrLine / TotalLine * 10000, 1);
                            CurrLine += 1;
                            VentanaNotificacion.UPDATE(2, Progreso);
                        END;
                    END;
                UNTIL NEXT = 0;
            END;
        END;
    END;

    LOCAL PROCEDURE GETCuentaGasto(Concepto: Text) Cuenta: Code[20];
    VAR
        CuentaGastosViajes: Code[20];
        CuentaGastosDesplazamiento: Code[20];
        CuentaGastosDiversos: Code[20];
        CuentaGastosOtrosArrendamientos: Code[20];
    BEGIN
        //++#0020 DMG 14/10/2020
        IF COMPANYNAME = 'IZERTIS' THEN BEGIN
            //--#0020 DMG 14/10/2020
            CuentaGastosViajes := '629000002';
            CuentaGastosDesplazamiento := '629000009';
            CuentaGastosDiversos := '629000001';
            CuentaGastosOtrosArrendamientos := '621000005';
            //++#0020 DMG 14/10/2020
        END ELSE IF COMPANYNAME = 'IZERTIS CANARIAS' THEN BEGIN
            CuentaGastosViajes := '629000002';
            CuentaGastosDesplazamiento := '629000013';
            CuentaGastosDiversos := '629000010';
            CuentaGastosOtrosArrendamientos := '621000002';
        END;
        //--#0020 DMG 14/10/2020

        //***Cuenta gastos viajes
        IF (STRPOS(Concepto, 'HTL') <> 0) OR
           (STRPOS(Concepto, 'HOTEL') <> 0) THEN
            EXIT(CuentaGastosViajes);

        //***Cuenta gastos Desplazamientos
        IF (STRPOS(Concepto, 'AVION') <> 0) OR
           (STRPOS(Concepto, 'TREN') <> 0) THEN
            EXIT(CuentaGastosDesplazamiento);

        //***Cuenta gastos Diversos
        IF (STRPOS(Concepto, 'TASAS') <> 0) THEN
            EXIT(CuentaGastosDiversos);

        //***Cuenta gastos viajes
        IF (STRPOS(Concepto, 'ALQUILER') <> 0) OR
           //++#0020 DMG 14/10/2020
           (STRPOS(Concepto, 'ENTERPRISE') <> 0) OR
           //--#0020 DMG 14/10/2020
           (STRPOS(Concepto, 'AVIS') <> 0) OR
           (STRPOS(Concepto, 'EUROPCAR') <> 0) THEN
            EXIT(CuentaGastosOtrosArrendamientos);

        EXIT(CuentaGastosDesplazamiento)
    END;
*/
    PROCEDURE AddPostedSalesDocumentToCRMAccountWall(SalesHeader: Record 36);
    VAR
        Customer: Record 18;
        CRMIntegrationManagement: Codeunit 5330;
        CRMSetupDefaults: Codeunit 5334;
        CRMDocumentHasBeenPostedMsgLbl: Label '%1 ''%2'' se ha registrado.';
    BEGIN
        IF NOT CRMSetupDefaults.GetAddPostedSalesDocumentToCRMAccountWallConfig THEN
            EXIT;
        IF NOT CRMIntegrationManagement.IsCRMIntegrationEnabled THEN
            EXIT;
        IF NOT (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]) THEN
            EXIT;

        Customer.GET(SalesHeader."Sell-to Customer No.");
        AddPostToCRMEntityWall(Customer.RECORDID, STRSUBSTNO(CRMDocumentHasBeenPostedMsgLbl, SalesHeader."Document Type", SalesHeader."No."));
    END;

    PROCEDURE AddPostToCRMEntityWall(TargetRecordID: RecordID; Message: Text);
    VAR
        CRMPost: Record 5344;
        EntityID: GUID;
        EntityTypeName: Text;
    BEGIN
        IF NOT GetCRMEntityIdAndTypeName(TargetRecordID, EntityID, EntityTypeName) THEN
            EXIT;

        CLEAR(CRMPost);
        EVALUATE(CRMPost.RegardingObjectTypeCode, EntityTypeName);
        CRMPost.RegardingObjectId := EntityID;
        CRMPost.Text := COPYSTR(Message, 1, MAXSTRLEN(CRMPost.Text));
        CRMPost.Source := CRMPost.Source::AutoPost;
        CRMPost.Type := CRMPost.Type::Status;
        CRMPost.INSERT;
    END;

    PROCEDURE GetCRMEntityIdAndTypeName(DestinationRecordID: RecordID; VAR EntityID: GUID; VAR EntityTypeName: Text): Boolean;
    VAR
        CRMIntegrationRecord: Record 5331;
    BEGIN
        IF NOT CRMIntegrationRecord.FindIDFromRecordID(DestinationRecordID, EntityID) THEN
            EXIT(FALSE);

        EntityTypeName := GetCRMEntityTypeName(DestinationRecordID.TABLENO);
        EXIT(TRUE);
    END;

    LOCAL PROCEDURE GetCRMEntityTypeName(TableId: Integer): Text;
    VAR
        TempNameValueBuffer: Record 823 temporary;
        CRMSetupDefaults: Codeunit 5334;
        UnableToResolveCRMEntityNameFrmTableIDErrLbl: Label 'La aplicación no est  diseñada para integrar la tabla %1 con Dynamics CRM.';
    BEGIN
        CRMSetupDefaults.GetTableIDCRMEntityNameMapping(TempNameValueBuffer);
        TempNameValueBuffer.SETRANGE(Value, FORMAT(TableId));
        IF TempNameValueBuffer.FINDFIRST THEN
            EXIT(TempNameValueBuffer.Name);
        ERROR(UnableToResolveCRMEntityNameFrmTableIDErrLbl, TableId);
    END;

    PROCEDURE SetCRMSalesOrderStatusToInvoiced(SalesHeader: Record 36);
    VAR
        CRMSalesorder: Record 5353;
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
    BEGIN
        IF NOT CRMIntegrationManagement.IsCRMIntegrationEnabled THEN
            EXIT;

        CRMSalesorder.SETRANGE(OrderNumber, SalesHeader."External Document No.");
        IF CRMSalesorder.FINDFIRST THEN BEGIN
            CRMSalesorder.StateCode := CRMSalesorder.StateCode::Invoiced;
            CRMSalesorder.StatusCode := CRMSalesorder.StatusCode::Invoiced;
            CRMSalesorder.MODIFY;
        END;
    END;
}
