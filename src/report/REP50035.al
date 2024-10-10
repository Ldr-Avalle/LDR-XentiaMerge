report 50035 "Libro Facturas recibidas"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Libro Facturas recibidas.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("Document Date", "No.")
                                ORDER(Ascending);
            RequestFilterFields = "Posting Date", "Document Date", "Due Date";
            column(recordCI_Picture; recordCI.Picture)
            {
            }
            column(totalBaseFacturas2; totalBaseFacturas2)
            {
            }
            column(totalIvaFacturas2; totalIvaFacturas2)
            {
            }
            column(TotalFacturas2; totalBaseFacturas2 + totalIvaFacturas2)
            {
            }
            column(totalBaseFacturas4; totalBaseFacturas4)
            {
            }
            column(totalIvaFacturas4; totalIvaFacturas4)
            {
            }
            column(TotalFacturas4; totalBaseFacturas4 + totalIvaFacturas4)
            {
            }
            column(totalBaseFacturas3; totalBaseFacturas3)
            {
            }
            column(totalIvaFacturas3; totalIvaFacturas3)
            {
            }
            column(totalBaseFacturas5; totalBaseFacturas5)
            {
            }
            column(totalIvaFacturas5; totalIvaFacturas5)
            {
            }
            column(totalBaseFacturas6; totalBaseFacturas6)
            {
            }
            column(totalIvaFacturas6; totalIvaFacturas6)
            {
            }
            column(totalBaseFacturas7; totalBaseFacturas7)
            {
            }
            column(totalIvaFacturas7; totalIvaFacturas7)
            {
            }
            column(totalBaseFacturas8; totalBaseFacturas8)
            {
            }
            column(totalIvaFacturas8; totalIvaFacturas8)
            {
            }
            column(totalBaseFacturas9; totalBaseFacturas9)
            {
            }
            column(totalIvaFacturas9; totalIvaFacturas9)
            {
            }
            column(totalBaseFacturas; totalBaseFacturas)
            {
            }
            column(totalIvaFacturas; totalIvaFacturas)
            {
            }
            column(recordCI_Name; recordCI.Name)
            {
            }
            column(recordCI_Address; recordCI.Address)
            {
            }
            column(recordCI_Address2; recordCI."Address 2")
            {
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("VAT Prod. Posting Group")
                                    ORDER(Ascending)
                                    WHERE(Type = FILTER(<> ' '));
                RequestFilterFields = "VAT Prod. Posting Group";
                column(PurchInvHeader_No; PurchInvHeader."No.")
                {
                }
                column(PurchInvHeader_DocumentDate; PurchInvHeader."Document Date")
                {
                }
                column(PurchInvHeader_PaytoName; PurchInvHeader."Pay-to Name")
                {
                }
                column(PurchInvLine_VATProdPostingGroup; "Purch. Inv. Line"."VAT Prod. Posting Group")
                {
                }
                column(PurchInvLine_VATBaseAmount; "Purch. Inv. Line"."VAT Base Amount")
                {
                }
                column(TotalIva; (("Purch. Inv. Line"."VAT %" * "Purch. Inv. Line"."VAT Base Amount") / 100))
                {
                }
                column(PurchInvHeader_AmountIncludingVAT; PurchInvHeader."Amount Including VAT")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //esto me sirve para mostrar los datos de la cabecera solo en la primera l´Š¢nea de cada grupo de iva (exento, iva16...)
                    IF ("Document No." <> numeroAnterior) THEN BEGIN
                        PurchInvHeader.GET("Purch. Inv. Line"."Document No.");
                        PurchInvHeader.CALCFIELDS("Amount Including VAT");
                    END ELSE
                        CLEAR(PurchInvHeader);
                    numeroAnterior := "Document No.";

                    totalBaseFacturas := totalBaseFacturas + "VAT Base Amount";
                    totalIvaFacturas := totalIvaFacturas + (("VAT %" * "VAT Base Amount") / 100);
                end;

                trigger OnPostDataItem()
                begin
                    PurchLine.SETFILTER("Document No.", '%1', "Document No.");
                    PurchLine.SETFILTER("VAT Prod. Posting Group", '%1', 'IVA21');
                    IF PurchLine.FINDFIRST THEN
                        REPEAT
                            totalBaseFacturas2 := totalBaseFacturas2 + PurchLine."VAT Base Amount";
                            totalIvaFacturas2 := totalIvaFacturas2 + ((PurchLine."VAT %" * PurchLine."VAT Base Amount") / 100);
                        UNTIL PurchLine.NEXT = 0;


                    PurchLine2.SETFILTER("Document No.", '%1', "Document No.");
                    PurchLine2.SETFILTER("VAT Prod. Posting Group", '%1', 'EXENTO');
                    //PurchLine2.SETFILTER("VAT Base Amount",'>%1',0 );
                    IF PurchLine2.FINDFIRST THEN
                        REPEAT
                            totalBaseFacturas3 := totalBaseFacturas3 + PurchLine2."VAT Base Amount";
                            totalIvaFacturas3 := totalIvaFacturas3 + ((PurchLine2."VAT %" * PurchLine2."VAT Base Amount") / 100);
                        UNTIL PurchLine2.NEXT = 0;

                    PurchLine3.SETFILTER("Document No.", '%1', "Document No.");
                    PurchLine3.SETFILTER("VAT Prod. Posting Group", '%1', 'IVA10');
                    IF PurchLine3.FINDFIRST THEN
                        REPEAT
                            totalBaseFacturas4 := totalBaseFacturas4 + PurchLine3."VAT Base Amount";
                            totalIvaFacturas4 := totalIvaFacturas4 + ((PurchLine3."VAT %" * PurchLine3."VAT Base Amount") / 100);
                        UNTIL PurchLine3.NEXT = 0;


                    PurchLine4.SETFILTER("Document No.", '%1', "Document No.");
                    PurchLine4.SETFILTER("VAT Prod. Posting Group", '%1', 'NO IVA');
                    IF PurchLine4.FINDFIRST THEN
                        REPEAT
                            totalBaseFacturas5 := totalBaseFacturas5 + PurchLine4."VAT Base Amount";
                            totalIvaFacturas5 := totalIvaFacturas5 + ((PurchLine4."VAT %" * PurchLine4."VAT Base Amount") / 100);
                        UNTIL PurchLine4.NEXT = 0;

                    PurchLine5.SETFILTER("Document No.", '%1', "Document No.");
                    PurchLine5.SETFILTER("VAT Prod. Posting Group", '%1', 'BI21');
                    IF PurchLine5.FINDFIRST THEN
                        REPEAT
                            totalBaseFacturas6 := totalBaseFacturas6 + PurchLine5."VAT Base Amount";
                            totalIvaFacturas6 := totalIvaFacturas6 + ((PurchLine5."VAT %" * PurchLine5."VAT Base Amount") / 100);
                        UNTIL PurchLine5.NEXT = 0;


                    PurchLine6.SETFILTER("Document No.", '%1', "Document No.");
                    PurchLine6.SETFILTER("VAT Prod. Posting Group", '%1', 'IVA18');
                    IF PurchLine6.FINDFIRST THEN
                        REPEAT
                            totalBaseFacturas7 := totalBaseFacturas7 + PurchLine6."VAT Base Amount";
                            totalIvaFacturas7 := totalIvaFacturas7 + ((PurchLine6."VAT %" * PurchLine6."VAT Base Amount") / 100);
                        UNTIL PurchLine6.NEXT = 0;

                    PurchLine7.SETFILTER("Document No.", '%1', "Document No.");
                    PurchLine7.SETFILTER("VAT Prod. Posting Group", '%1', 'IVA4');
                    IF PurchLine7.FINDFIRST THEN
                        REPEAT
                            totalBaseFacturas8 := totalBaseFacturas8 + PurchLine7."VAT Base Amount";
                            totalIvaFacturas8 := totalIvaFacturas8 + ((PurchLine7."VAT %" * PurchLine7."VAT Base Amount") / 100);
                        UNTIL PurchLine7.NEXT = 0;

                    PurchLine8.SETFILTER("Document No.", '%1', "Document No.");
                    PurchLine8.SETFILTER("VAT Prod. Posting Group", '%1', 'IVA8');
                    IF PurchLine8.FINDFIRST THEN
                        REPEAT
                            totalBaseFacturas9 := totalBaseFacturas9 + PurchLine8."VAT Base Amount";
                            totalIvaFacturas9 := totalIvaFacturas9 + ((PurchLine8."VAT %" * PurchLine8."VAT Base Amount") / 100);
                        UNTIL PurchLine8.NEXT = 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                totalIvaFacturas := 0;
                totalBaseFacturas := 0;
            end;
        }
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = SORTING("Document Date", "No.")
                                ORDER(Ascending);
            column(totalBaseAbonos2; totalBaseAbonos2)
            {
            }
            column(totalIvaAbonos2; totalIvaAbonos2)
            {
            }
            column(TotalAbonos2; totalBaseAbonos2 + totalIvaAbonos2)
            {
            }
            column(totalBaseAbonos4; totalBaseAbonos4)
            {
            }
            column(totalIvaAbonos4; totalIvaAbonos4)
            {
            }
            column(TotalAbonos4; totalBaseAbonos4 + totalIvaAbonos4)
            {
            }
            column(totalBaseAbonos3; totalBaseAbonos3)
            {
            }
            column(totalIvaAbonos3; totalIvaAbonos3)
            {
            }
            column(totalBaseAbonos5; totalBaseAbonos5)
            {
            }
            column(totalIvaAbonos5; totalIvaAbonos5)
            {
            }
            column(totalBaseAbonos6; totalBaseAbonos6)
            {
            }
            column(totalIvaAbonos6; totalIvaAbonos6)
            {
            }
            column(totalBaseAbonos7; totalBaseAbonos7)
            {
            }
            column(totalIvaAbonos7; totalIvaAbonos7)
            {
            }
            column(totalBaseAbonos8; totalBaseAbonos8)
            {
            }
            column(totalIvaAbonos8; totalIvaAbonos8)
            {
            }
            column(totalBaseAbonos9; totalBaseAbonos9)
            {
            }
            column(totalIvaAbonos9; totalIvaAbonos9)
            {
            }
            column(totalBaseAbonos; totalBaseAbonos)
            {
            }
            column(totalIvaAbonos; totalIvaAbonos)
            {
            }
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("VAT Prod. Posting Group")
                                    ORDER(Ascending)
                                    WHERE(Type = FILTER(<> ' '));
                column(PurchMemoHeader_No; PurchMemoHeader."No.")
                {
                }
                column(PurchMemoHeader_DocumentDate; PurchMemoHeader."Document Date")
                {
                }
                column(PurchMemoHeader_PaytoName; PurchMemoHeader."Pay-to Name")
                {
                }
                column(PurchCrMemoLine_VATProdPostingGroup; "Purch. Cr. Memo Line"."VAT Prod. Posting Group")
                {
                }
                column(PurchCrMemoLine_VATBaseAmount; "Purch. Cr. Memo Line"."VAT Base Amount")
                {
                }
                column(TotalIvaAbonosLin; (("Purch. Cr. Memo Line"."VAT %" * "Purch. Cr. Memo Line"."VAT Base Amount") / 100))
                {
                }
                column(PurchMemoHeader_AmountIncludingVAT; PurchMemoHeader."Amount Including VAT")
                {
                }

                trigger OnPostDataItem()
                begin

                    CRLine.SETFILTER("Document No.", '%1', "Document No.");
                    CRLine.SETFILTER("VAT Prod. Posting Group", '%1', 'IVA21');
                    IF CRLine.FINDFIRST THEN
                        REPEAT
                            totalBaseAbonos2 := totalBaseAbonos2 + CRLine."VAT Base Amount";
                            totalIvaAbonos2 := totalIvaAbonos2 + ((CRLine."VAT %" * CRLine."VAT Base Amount") / 100);
                        UNTIL CRLine.NEXT = 0;


                    CRLine2.SETFILTER("Document No.", '%1', "Document No.");
                    CRLine2.SETFILTER("VAT Prod. Posting Group", '%1', 'EXENTO');
                    //CRLine2.SETFILTER("VAT Base Amount",'>%1',0 );
                    IF CRLine2.FINDFIRST THEN
                        REPEAT
                            totalBaseAbonos3 := totalBaseAbonos3 + CRLine2."VAT Base Amount";
                            totalIvaAbonos3 := totalIvaAbonos3 + ((CRLine2."VAT %" * CRLine2."VAT Base Amount") / 100);
                        UNTIL CRLine2.NEXT = 0;

                    CRLine3.SETFILTER("Document No.", '%1', "Document No.");
                    CRLine3.SETFILTER("VAT Prod. Posting Group", '%1', 'IVA10');
                    IF CRLine3.FINDFIRST THEN
                        REPEAT
                            totalBaseAbonos4 := totalBaseAbonos4 + CRLine3."VAT Base Amount";
                            totalIvaAbonos4 := totalIvaAbonos4 + ((CRLine3."VAT %" * CRLine3."VAT Base Amount") / 100);
                        UNTIL CRLine3.NEXT = 0;


                    CRLine4.SETFILTER("Document No.", '%1', "Document No.");
                    CRLine4.SETFILTER("VAT Prod. Posting Group", '%1', 'NO IVA');
                    IF CRLine4.FINDFIRST THEN
                        REPEAT
                            totalBaseAbonos5 := totalBaseAbonos5 + CRLine4."VAT Base Amount";
                            totalIvaAbonos5 := totalIvaAbonos5 + ((CRLine4."VAT %" * CRLine4."VAT Base Amount") / 100);
                        UNTIL CRLine4.NEXT = 0;

                    CRLine5.SETFILTER("Document No.", '%1', "Document No.");
                    CRLine5.SETFILTER("VAT Prod. Posting Group", '%1', 'BI21');
                    IF CRLine5.FINDFIRST THEN
                        REPEAT
                            totalBaseAbonos6 := totalBaseAbonos6 + CRLine5."VAT Base Amount";
                            totalIvaAbonos6 := totalIvaAbonos6 + ((CRLine5."VAT %" * CRLine5."VAT Base Amount") / 100);
                        UNTIL CRLine5.NEXT = 0;


                    CRLine6.SETFILTER("Document No.", '%1', "Document No.");
                    CRLine6.SETFILTER("VAT Prod. Posting Group", '%1', 'IVA18');
                    IF CRLine6.FINDFIRST THEN
                        REPEAT
                            totalBaseAbonos7 := totalBaseAbonos7 + CRLine6."VAT Base Amount";
                            totalIvaAbonos7 := totalIvaAbonos7 + ((CRLine6."VAT %" * CRLine6."VAT Base Amount") / 100);
                        UNTIL CRLine6.NEXT = 0;

                    CRLine7.SETFILTER("Document No.", '%1', "Document No.");
                    CRLine7.SETFILTER("VAT Prod. Posting Group", '%1', 'IVA4');
                    IF CRLine7.FINDFIRST THEN
                        REPEAT
                            totalBaseAbonos8 := totalBaseAbonos8 + CRLine7."VAT Base Amount";
                            totalIvaAbonos8 := totalIvaAbonos8 + ((CRLine7."VAT %" * CRLine7."VAT Base Amount") / 100);
                        UNTIL CRLine7.NEXT = 0;

                    CRLine8.SETFILTER("Document No.", '%1', "Document No.");
                    CRLine8.SETFILTER("VAT Prod. Posting Group", '%1', 'IVA8');
                    IF CRLine8.FINDFIRST THEN
                        REPEAT
                            totalBaseAbonos9 := totalBaseAbonos9 + CRLine8."VAT Base Amount";
                            totalIvaAbonos9 := totalIvaAbonos9 + ((CRLine8."VAT %" * CRLine8."VAT Base Amount") / 100);
                        UNTIL CRLine8.NEXT = 0;
                end;

                trigger OnPreDataItem()
                begin
                    //esto me sirve para mostrar los datos de la cabecera solo en la primera l´Š¢nea de cada grupo de iva (exento, iva16...)
                    IF ("Document No." <> numeroAnterior) THEN BEGIN
                        PurchMemoHeader.GET("Purch. Cr. Memo Line"."Document No.");
                        PurchMemoHeader.CALCFIELDS("Amount Including VAT");
                    END ELSE
                        CLEAR(PurchMemoHeader);
                    numeroAnterior := "Document No.";

                    totalBaseAbonos := totalBaseAbonos + "VAT Base Amount";
                    totalIvaAbonos := totalIvaAbonos + (("VAT %" * "VAT Base Amount") / 100);
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGE;

                totalIvaAbonos := 0;
                totalBaseAbonos := 0;

                "Purch. Inv. Header".COPYFILTER("Posting Date", "Posting Date");
                "Purch. Inv. Header".COPYFILTER("Document Date", "Document Date");
                "Purch. Inv. Header".COPYFILTER("Due Date", "Due Date");
            end;
        }
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
        recordCI.CALCFIELDS(Picture);
    end;

    var
        filtroTipoFecha: Option " ",Registro,"Emisi´Š¢n",Vencimiento;
        fechaDesde: Date;
        fechaHasta: Date;
        recordCI: Record "79";
        totalIvaLinea: Decimal;
        totalIvaFacturas: Decimal;
        totalIvaAbonos: Decimal;
        totalBaseFacturas: Decimal;
        totalBaseAbonos: Decimal;
        numeroAnterior: Code[20];
        PurchInvHeader: Record "122";
        PurchMemoHeader: Record "124";
        PurchLine: Record "123";
        PurchLine2: Record "123";
        PurchLine3: Record "123";
        PurchLine4: Record "123";
        PurchLine5: Record "123";
        CRLine3: Record "125";
        CRLine4: Record "125";
        CRLine5: Record "125";
        CRLine6: Record "125";
        CRLine7: Record "125";
        totalIvaFacturas4: Decimal;
        totalBaseFacturas4: Decimal;
        totalIvaFacturas5: Decimal;
        totalBaseFacturas5: Decimal;
        totalIvaAbonos4: Decimal;
        totalBaseAbonos4: Decimal;
        totalIvaAbonos5: Decimal;
        totalBaseAbonos5: Decimal;
        totalIvaFacturas2: Decimal;
        totalBaseFacturas2: Decimal;
        totalIvaFacturas3: Decimal;
        totalBaseFacturas3: Decimal;
        totalIvaAbonos2: Decimal;
        totalBaseAbonos2: Decimal;
        totalIvaAbonos3: Decimal;
        totalBaseAbonos3: Decimal;
        PurchLine8: Record "123";
        PurchLine9: Record "123";
        CRLine8: Record "125";
        CRLine9: Record "125";
        PurchLine6: Record "123";
        PurchLine7: Record "123";
        CRLine: Record "125";
        CRLine2: Record "125";
        totalIvaFacturas6: Decimal;
        totalBaseFacturas6: Decimal;
        totalIvaFacturas7: Decimal;
        totalBaseFacturas7: Decimal;
        totalIvaAbonos6: Decimal;
        totalBaseAbonos6: Decimal;
        totalIvaAbonos7: Decimal;
        totalBaseAbonos7: Decimal;
        totalIvaFacturas8: Decimal;
        totalBaseFacturas8: Decimal;
        totalIvaFacturas9: Decimal;
        totalBaseFacturas9: Decimal;
        totalIvaAbonos8: Decimal;
        totalBaseAbonos8: Decimal;
        totalIvaAbonos9: Decimal;
        totalBaseAbonos9: Decimal;
}

