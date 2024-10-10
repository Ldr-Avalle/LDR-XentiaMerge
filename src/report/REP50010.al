report 50010 "Duplicate Data"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(SourceTable1;Table50)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable1.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable1.GET("Starting Date") THEN BEGIN
                  FromTable1.TRANSFERFIELDS(SourceTable1);
                  FromTable1.INSERT;
                END;
            end;
        }
        dataitem(SourceTable2;Table366)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable2.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable2.GET("Analysis View Code","Budget Name","G/L Account No.","Dimension 1 Value Code","Dimension 2 Value Code","Dimension 3 Value Code","Dimension 4 Value Code") THEN BEGIN
                  FromTable2.TRANSFERFIELDS(SourceTable2);
                  FromTable2.INSERT;
                END;
            end;
        }
        dataitem(SourceTable3;Table5804)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable3.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable3.GET("Item No.","Variant Code","Location Code","Valuation Date") THEN BEGIN
                  FromTable3.TRANSFERFIELDS(SourceTable3);
                  FromTable3.INSERT;
                END;
            end;
        }
        dataitem(SourceTable4;Table271)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable4.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable4.GET("Entry No.") THEN BEGIN
                  FromTable4.TRANSFERFIELDS(SourceTable4);
                  FromTable4.INSERT;
                END;
            end;
        }
        dataitem(SourceTable5;Table7000013)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable5.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable5.GET(Usage,Sequence) THEN BEGIN
                  FromTable5.TRANSFERFIELDS(SourceTable5);
                  FromTable5.INSERT;
                END;
            end;
        }
        dataitem(SourceTable6;Table18)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable6.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable6.GET("No.") THEN BEGIN
                  FromTable6.TRANSFERFIELDS(SourceTable6);
                  FromTable6.INSERT;
                END;
            end;
        }
        dataitem(SourceTable7;Table354)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable7.CHANGECOMPANY('SERCABLE');

                IF NOT FromTable7.GET("Source Code","Table ID") THEN BEGIN
                  FromTable7.TRANSFERFIELDS(SourceTable7);
                  FromTable7.INSERT;
                END;
            end;
        }
        dataitem(SourceTable8;Table348)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable8.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable8.GET(Code) THEN BEGIN
                  FromTable8.TRANSFERFIELDS(SourceTable8);
                  FromTable8.INSERT;
                END;
            end;
        }
        dataitem(SourceTable9;Table349)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable9.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable9.GET("Dimension Code",Code) THEN BEGIN
                  FromTable9.TRANSFERFIELDS(SourceTable9);
                  FromTable9.INSERT;
                END;
            end;
        }
        dataitem(SourceTable10;Table50004)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable10.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable10.GET(Employee,"No.") THEN BEGIN
                  FromTable10.TRANSFERFIELDS(SourceTable10);
                  FromTable10.INSERT;
                END;
            end;
        }
        dataitem(SourceTable11;Table50009)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable11.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable11.GET("Employee No.","Start Date") THEN BEGIN
                  FromTable11.TRANSFERFIELDS(SourceTable11);
                  FromTable11.INSERT;
                END;
            end;
        }
        dataitem(SourceTable12;Table5645)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable12.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable12.GET("FA Date Type No.","FA Date Type Name") THEN BEGIN
                  FromTable12.TRANSFERFIELDS(SourceTable12);
                  FromTable12.INSERT;
                END;
            end;
        }
        dataitem(SourceTable13;Table15)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable13.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable13.GET("No.") THEN BEGIN
                  FromTable13.TRANSFERFIELDS(SourceTable13);
                  FromTable13.INSERT;
                END;
            end;
        }
        dataitem(SourceTable14;Table96)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable14.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable14.GET("Entry No.") THEN BEGIN
                  FromTable14.TRANSFERFIELDS(SourceTable14);
                  FromTable14.INSERT;
                END;
            end;
        }
        dataitem(SourceTable15;Table17)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable15.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable15.GET("Entry No.") THEN BEGIN
                  FromTable15.TRANSFERFIELDS(SourceTable15);
                  FromTable15.INSERT;
                END;
            end;
        }
        dataitem(SourceTable16;Table45)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable16.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable16.GET("No.") THEN BEGIN
                  FromTable16.TRANSFERFIELDS(SourceTable16);
                  FromTable16.INSERT;
                END;
            end;
        }
        dataitem(SourceTable17;Table50026)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable17.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable17.GET("Job No.",Employee) THEN BEGIN
                  FromTable17.TRANSFERFIELDS(SourceTable17);
                  FromTable17.INSERT;
                END;
            end;
        }
        dataitem(SourceTable18;Table120)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable18.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable18.GET("No.") THEN BEGIN
                  FromTable18.TRANSFERFIELDS(SourceTable18);
                  FromTable18.INSERT;
                END;
            end;
        }
        dataitem(SourceTable19;Table5714)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable19.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable19.GET(Code) THEN BEGIN
                  FromTable19.TRANSFERFIELDS(SourceTable19);
                  FromTable19.INSERT;
                END;
            end;
        }
        dataitem(SourceTable20;Table6661)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable20.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable20.GET("Document No.","Line No.") THEN BEGIN
                  FromTable20.TRANSFERFIELDS(SourceTable20);
                  FromTable20.INSERT;
                END;
            end;
        }
        dataitem(SourceTable21;Table110)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable21.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable21.GET("No.") THEN BEGIN
                  FromTable21.TRANSFERFIELDS(SourceTable21);
                  FromTable21.INSERT;
                END;
            end;
        }
        dataitem(SourceTable22;Table10727)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable22.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable22.GET("No.") THEN BEGIN
                  FromTable22.TRANSFERFIELDS(SourceTable22);
                  FromTable22.INSERT;
                END;
            end;
        }
        dataitem(SourceTable23;Table5744)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable23.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable23.GET("No.") THEN BEGIN
                  FromTable23.TRANSFERFIELDS(SourceTable23);
                  FromTable23.INSERT;
                END;
            end;
        }
        dataitem(SourceTable24;Table91)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable24.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable24.GET("User ID") THEN BEGIN
                  FromTable24.TRANSFERFIELDS(SourceTable24);
                  FromTable24.INSERT;
                END;
            end;
        }
        dataitem(SourceTable25;Table25)
        {

            trigger OnAfterGetRecord()
            begin
                FromTable25.CHANGECOMPANY('SERCABLE');
                IF NOT FromTable25.GET("Entry No.") THEN BEGIN
                  FromTable25.TRANSFERFIELDS(SourceTable25);
                  FromTable25.INSERT;
                END;
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

    trigger OnPostReport()
    begin
        MESSAGE('Finish');
    end;

    trigger OnPreReport()
    begin
        MESSAGE('Init');
    end;

    var
        FromTable1: Record "50";
        FromTable2: Record "366";
        FromTable3: Record "5804";
        FromTable4: Record "271";
        FromTable5: Record "7000013";
        FromTable6: Record "18";
        FromTable7: Record "354";
        FromTable8: Record "348";
        FromTable9: Record "349";
        FromTable10: Record "50004";
        FromTable11: Record "50009";
        FromTable12: Record "5645";
        FromTable13: Record "15";
        FromTable14: Record "96";
        FromTable15: Record "17";
        FromTable16: Record "45";
        FromTable17: Record "50026";
        FromTable18: Record "120";
        FromTable19: Record "5714";
        FromTable20: Record "6661";
        FromTable21: Record "110";
        FromTable22: Record "10727";
        FromTable23: Record "5744";
        FromTable24: Record "91";
        FromTable25: Record "25";
}

