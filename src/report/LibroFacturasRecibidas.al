report 50035 "Libro Facturas recibidas"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/layout/Libro Facturas recibidas.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = sorting("Document Date", "No.")
                                order(ascending);
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
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("VAT Prod. Posting Group")
                                    order(ascending)
                                    where(Type = filter(<> ' '));
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
                    if ("Document No." <> numeroAnterior) then begin
                        PurchInvHeader.Get("Purch. Inv. Line"."Document No.");
                        PurchInvHeader.CalcFields("Amount Including VAT");
                    end else
                        Clear(PurchInvHeader);
                    numeroAnterior := "Document No.";

                    totalBaseFacturas := totalBaseFacturas + "VAT Base Amount";
                    totalIvaFacturas := totalIvaFacturas + (("VAT %" * "VAT Base Amount") / 100);
                end;

                trigger OnPostDataItem()
                begin
                    PurchLine.SetFilter("Document No.", '%1', "Document No.");
                    PurchLine.SetFilter("VAT Prod. Posting Group", '%1', 'IVA21');
                    if PurchLine.FindFirst() then
                        repeat
                            totalBaseFacturas2 := totalBaseFacturas2 + PurchLine."VAT Base Amount";
                            totalIvaFacturas2 := totalIvaFacturas2 + ((PurchLine."VAT %" * PurchLine."VAT Base Amount") / 100);
                        until PurchLine.Next() = 0;


                    PurchLine2.SetFilter("Document No.", '%1', "Document No.");
                    PurchLine2.SetFilter("VAT Prod. Posting Group", '%1', 'EXENTO');
                    //PurchLine2.SETFILTER("VAT Base Amount",'>%1',0 );
                    if PurchLine2.FindFirst() then
                        repeat
                            totalBaseFacturas3 := totalBaseFacturas3 + PurchLine2."VAT Base Amount";
                            totalIvaFacturas3 := totalIvaFacturas3 + ((PurchLine2."VAT %" * PurchLine2."VAT Base Amount") / 100);
                        until PurchLine2.Next() = 0;

                    PurchLine3.SetFilter("Document No.", '%1', "Document No.");
                    PurchLine3.SetFilter("VAT Prod. Posting Group", '%1', 'IVA10');
                    if PurchLine3.FindFirst() then
                        repeat
                            totalBaseFacturas4 := totalBaseFacturas4 + PurchLine3."VAT Base Amount";
                            totalIvaFacturas4 := totalIvaFacturas4 + ((PurchLine3."VAT %" * PurchLine3."VAT Base Amount") / 100);
                        until PurchLine3.Next() = 0;


                    PurchLine4.SetFilter("Document No.", '%1', "Document No.");
                    PurchLine4.SetFilter("VAT Prod. Posting Group", '%1', 'NO IVA');
                    if PurchLine4.FindFirst() then
                        repeat
                            totalBaseFacturas5 := totalBaseFacturas5 + PurchLine4."VAT Base Amount";
                            totalIvaFacturas5 := totalIvaFacturas5 + ((PurchLine4."VAT %" * PurchLine4."VAT Base Amount") / 100);
                        until PurchLine4.Next() = 0;

                    PurchLine5.SetFilter("Document No.", '%1', "Document No.");
                    PurchLine5.SetFilter("VAT Prod. Posting Group", '%1', 'BI21');
                    if PurchLine5.FindFirst() then
                        repeat
                            totalBaseFacturas6 := totalBaseFacturas6 + PurchLine5."VAT Base Amount";
                            totalIvaFacturas6 := totalIvaFacturas6 + ((PurchLine5."VAT %" * PurchLine5."VAT Base Amount") / 100);
                        until PurchLine5.Next() = 0;


                    PurchLine6.SetFilter("Document No.", '%1', "Document No.");
                    PurchLine6.SetFilter("VAT Prod. Posting Group", '%1', 'IVA18');
                    if PurchLine6.FindFirst() then
                        repeat
                            totalBaseFacturas7 := totalBaseFacturas7 + PurchLine6."VAT Base Amount";
                            totalIvaFacturas7 := totalIvaFacturas7 + ((PurchLine6."VAT %" * PurchLine6."VAT Base Amount") / 100);
                        until PurchLine6.Next() = 0;

                    PurchLine7.SetFilter("Document No.", '%1', "Document No.");
                    PurchLine7.SetFilter("VAT Prod. Posting Group", '%1', 'IVA4');
                    if PurchLine7.FindFirst() then
                        repeat
                            totalBaseFacturas8 := totalBaseFacturas8 + PurchLine7."VAT Base Amount";
                            totalIvaFacturas8 := totalIvaFacturas8 + ((PurchLine7."VAT %" * PurchLine7."VAT Base Amount") / 100);
                        until PurchLine7.Next() = 0;

                    PurchLine8.SetFilter("Document No.", '%1', "Document No.");
                    PurchLine8.SetFilter("VAT Prod. Posting Group", '%1', 'IVA8');
                    if PurchLine8.FindFirst() then
                        repeat
                            totalBaseFacturas9 := totalBaseFacturas9 + PurchLine8."VAT Base Amount";
                            totalIvaFacturas9 := totalIvaFacturas9 + ((PurchLine8."VAT %" * PurchLine8."VAT Base Amount") / 100);
                        until PurchLine8.Next() = 0;
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
            DataItemTableView = sorting("Document Date", "No.")
                                order(ascending);
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
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("VAT Prod. Posting Group")
                                    order(ascending)
                                    where(Type = filter(<> ' '));
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

                    CRLine.SetFilter("Document No.", '%1', "Document No.");
                    CRLine.SetFilter("VAT Prod. Posting Group", '%1', 'IVA21');
                    if CRLine.FindFirst() then
                        repeat
                            totalBaseAbonos2 := totalBaseAbonos2 + CRLine."VAT Base Amount";
                            totalIvaAbonos2 := totalIvaAbonos2 + ((CRLine."VAT %" * CRLine."VAT Base Amount") / 100);
                        until CRLine.Next() = 0;


                    CRLine2.SetFilter("Document No.", '%1', "Document No.");
                    CRLine2.SetFilter("VAT Prod. Posting Group", '%1', 'EXENTO');
                    //CRLine2.SETFILTER("VAT Base Amount",'>%1',0 );
                    if CRLine2.FindFirst() then
                        repeat
                            totalBaseAbonos3 := totalBaseAbonos3 + CRLine2."VAT Base Amount";
                            totalIvaAbonos3 := totalIvaAbonos3 + ((CRLine2."VAT %" * CRLine2."VAT Base Amount") / 100);
                        until CRLine2.Next() = 0;

                    CRLine3.SetFilter("Document No.", '%1', "Document No.");
                    CRLine3.SetFilter("VAT Prod. Posting Group", '%1', 'IVA10');
                    if CRLine3.FindFirst() then
                        repeat
                            totalBaseAbonos4 := totalBaseAbonos4 + CRLine3."VAT Base Amount";
                            totalIvaAbonos4 := totalIvaAbonos4 + ((CRLine3."VAT %" * CRLine3."VAT Base Amount") / 100);
                        until CRLine3.Next() = 0;


                    CRLine4.SetFilter("Document No.", '%1', "Document No.");
                    CRLine4.SetFilter("VAT Prod. Posting Group", '%1', 'NO IVA');
                    if CRLine4.FindFirst() then
                        repeat
                            totalBaseAbonos5 := totalBaseAbonos5 + CRLine4."VAT Base Amount";
                            totalIvaAbonos5 := totalIvaAbonos5 + ((CRLine4."VAT %" * CRLine4."VAT Base Amount") / 100);
                        until CRLine4.Next() = 0;

                    CRLine5.SetFilter("Document No.", '%1', "Document No.");
                    CRLine5.SetFilter("VAT Prod. Posting Group", '%1', 'BI21');
                    if CRLine5.FindFirst() then
                        repeat
                            totalBaseAbonos6 := totalBaseAbonos6 + CRLine5."VAT Base Amount";
                            totalIvaAbonos6 := totalIvaAbonos6 + ((CRLine5."VAT %" * CRLine5."VAT Base Amount") / 100);
                        until CRLine5.Next() = 0;


                    CRLine6.SetFilter("Document No.", '%1', "Document No.");
                    CRLine6.SetFilter("VAT Prod. Posting Group", '%1', 'IVA18');
                    if CRLine6.FindFirst() then
                        repeat
                            totalBaseAbonos7 := totalBaseAbonos7 + CRLine6."VAT Base Amount";
                            totalIvaAbonos7 := totalIvaAbonos7 + ((CRLine6."VAT %" * CRLine6."VAT Base Amount") / 100);
                        until CRLine6.Next() = 0;

                    CRLine7.SetFilter("Document No.", '%1', "Document No.");
                    CRLine7.SetFilter("VAT Prod. Posting Group", '%1', 'IVA4');
                    if CRLine7.FindFirst() then
                        repeat
                            totalBaseAbonos8 := totalBaseAbonos8 + CRLine7."VAT Base Amount";
                            totalIvaAbonos8 := totalIvaAbonos8 + ((CRLine7."VAT %" * CRLine7."VAT Base Amount") / 100);
                        until CRLine7.Next() = 0;

                    CRLine8.SetFilter("Document No.", '%1', "Document No.");
                    CRLine8.SetFilter("VAT Prod. Posting Group", '%1', 'IVA8');
                    if CRLine8.FindFirst() then
                        repeat
                            totalBaseAbonos9 := totalBaseAbonos9 + CRLine8."VAT Base Amount";
                            totalIvaAbonos9 := totalIvaAbonos9 + ((CRLine8."VAT %" * CRLine8."VAT Base Amount") / 100);
                        until CRLine8.Next() = 0;
                end;

                trigger OnPreDataItem()
                begin
                    //esto me sirve para mostrar los datos de la cabecera solo en la primera l´Š¢nea de cada grupo de iva (exento, iva16...)
                    if ("Document No." <> numeroAnterior) then begin
                        PurchMemoHeader.Get("Purch. Cr. Memo Line"."Document No.");
                        PurchMemoHeader.CalcFields("Amount Including VAT");
                    end else
                        Clear(PurchMemoHeader);
                    numeroAnterior := "Document No.";

                    totalBaseAbonos := totalBaseAbonos + "VAT Base Amount";
                    totalIvaAbonos := totalIvaAbonos + (("VAT %" * "VAT Base Amount") / 100);
                end;
            }

            trigger OnPreDataItem()
            begin
                CurrReport.NewPage();

                totalIvaAbonos := 0;
                totalBaseAbonos := 0;

                "Purch. Inv. Header".CopyFilter("Posting Date", "Posting Date");
                "Purch. Inv. Header".CopyFilter("Document Date", "Document Date");
                "Purch. Inv. Header".CopyFilter("Due Date", "Due Date");
            end;
        }
    }

    trigger OnInitReport()
    begin
        recordCI.CalcFields(Picture);
    end;

    var
        filtroTipoFecha: Option " ",Registro,"Emisi´Š¢n",Vencimiento;
        fechaDesde: Date;
        fechaHasta: Date;
        recordCI: Record "Company Information";
        totalIvaLinea: Decimal;
        totalIvaFacturas: Decimal;
        totalIvaAbonos: Decimal;
        totalBaseFacturas: Decimal;
        totalBaseAbonos: Decimal;
        numeroAnterior: Code[20];
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchLine: Record "Purch. Inv. Line";
        PurchLine2: Record "Purch. Inv. Line";
        PurchLine3: Record "Purch. Inv. Line";
        PurchLine4: Record "Purch. Inv. Line";
        PurchLine5: Record "Purch. Inv. Line";
        CRLine3: Record "Purch. Cr. Memo Line";
        CRLine4: Record "Purch. Cr. Memo Line";
        CRLine5: Record "Purch. Cr. Memo Line";
        CRLine6: Record "Purch. Cr. Memo Line";
        CRLine7: Record "Purch. Cr. Memo Line";
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
        PurchLine8: Record "Purch. Inv. Line";
        PurchLine9: Record "Purch. Inv. Line";
        CRLine8: Record "Purch. Cr. Memo Line";
        CRLine9: Record "Purch. Cr. Memo Line";
        PurchLine6: Record "Purch. Inv. Line";
        PurchLine7: Record "Purch. Inv. Line";
        CRLine: Record "Purch. Cr. Memo Line";
        CRLine2: Record "Purch. Cr. Memo Line";
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

