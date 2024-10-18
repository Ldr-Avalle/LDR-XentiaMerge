tableextension 50119 Job_LDR extends "Job"
{
    fields
    {
        modify("Bill-to Address")
        {
            Description = 'SERCABLE';
        }
        modify("Bill-to Address 2")
        {
            Description = 'SERCABLE';
        }
        field(50000; "Customer Order No."; Text[30])
        {
            Description = 'SERCABLE';
        }
        //todo:creo que hay que eliminarlo
        field(50001; "Payment Terms Code_LDR"; Code[10])
        {
            Description = 'SERCABLE';
            TableRelation = "Payment Terms";
        }
        //todo:creo que hay que eliminarlo
        field(50002; "Payment Method Code_LDR"; Code[10])
        {
            Description = 'SERCABLE';
            TableRelation = "Payment Method";
        }
        field(50004; CosteTotalImputado; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Job Ledger Entry"."Total Cost (LCY)" WHERE("Job No." = FIELD("No."),
                                                                           "Entry Type" = CONST(Usage),
                                                                           "Posting Date" = FIELD("Posting Date Filter")));
            Caption = 'Contract (Invoiced Price)';
            Description = 'SERCABLE';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; ImporteFacturado; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = - Sum("Job Ledger Entry"."Line Amount (LCY)" WHERE("Job No." = FIELD("No."),
                                                                             "Entry Type" = CONST(Sale),
                                                                             "Posting Date" = FIELD("Posting Date Filter")));
            Caption = 'Contract (Invoiced Price)';
            Description = 'SERCABLE';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; ImporteVentaImputado; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Job Ledger Entry"."Line Amount (LCY)" WHERE("Job No." = FIELD("No."),
                                                                            "Entry Type" = CONST(Usage),
                                                                            "Posting Date" = FIELD("Posting Date Filter")));
            Caption = 'Contract (Invoiced Price)';
            Description = 'SERCABLE';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; BudgetCost; Decimal)
        {
            //todo:revisar el error
            /*
              CalcFormula = Sum("Job Planning Line"."Total Cost" WHERE("Job No." = FIELD("No."),
                                                                        "Line Type" = FILTER("Schedule" | "Both Schedule and Contract")));
              Description = 'SERCABLE';
              FieldClass = FlowField;
              */
        }
        field(50008; BudgetPrice; Decimal)
        {
            //todo:revisar el error
            /*
              CalcFormula = Sum("Job Planning Line"."Total Price" WHERE("Job No." = FIELD("No."),
                                                                         "Line Type" = FILTER("Contract" | "Both Schedule and Contract")));
              Description = 'SERCABLE';
              FieldClass = FlowField;
              */
        }
        field(50009; ExcluyeWIP; Boolean)
        {
            Caption = 'Excluye WIP';
            Description = 'SERCABLE';
        }
        field(50010; Maintenance; Boolean)
        {
            Caption = 'Mantenimiento';
            Description = 'SERCABLE';
        }
        field(50011; "Transaction Specification"; Code[10])
        {
            Caption = 'Especificación Transacción';
            Description = 'SERCABLE';
            TableRelation = "Transaction Specification";
        }
        field(50012; "% Completed"; Decimal)
        {
            Caption = '% Completado';
            Description = 'SERCABLE';
            MaxValue = 100;
            MinValue = 0;
            trigger OnValidate()
            var
                Text0001: Label 'Se informaró el % de Ejecución solo a tótulo informativo. Un proyectos que Excluye WIP no se tiene en cuenta para el cólculo de obra en curso y por tanto la ejecución no afectaró a la cuenta de resultados.';
            begin
                IF ExcluyeWIP THEN MESSAGE(Text0001);
            end;
        }
        field(50013; "Año"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'SERCABLE';
            FieldClass = FlowFilter;
        }
        field(50014; Mes; enum Meses)
        {
            Description = 'SERCABLE';
            FieldClass = FlowFilter;
            //OptionMembers = Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        }
        field(50015; "Horas/IDi present."; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum(IDI_LDR."Horas present." WHERE(Proyecto = FIELD("No."),
                                                          Año = FIELD(Año),
                                                          Mes = FIELD(Mes)));
            Description = 'SERCABLE';
            Editable = false;

        }
        field(50016; "Horas/IDi just."; Decimal)
        {
            CalcFormula = Sum(IDI_LDR."Horas just." WHERE(Proyecto = FIELD("No."),
                                                       Año = FIELD(Año),
                                                       Mes = FIELD(Mes)));
            Description = 'SERCABLE';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50017; "Coste/IDi present."; Decimal)
        {
            CalcFormula = Sum(IDI_LDR."Coste horas present." WHERE(Proyecto = FIELD("No."),
                                                                Año = FIELD(Año),
                                                                Mes = FIELD(Mes)));
            Description = 'SERCABLE';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50018; "Coste/IDi just."; Decimal)
        {
            CalcFormula = Sum(IDI_LDR."Coste horas just." WHERE(Proyecto = FIELD("No."),
                                                             Año = FIELD(Año),
                                                             Mes = FIELD(Mes)));
            Description = 'SERCABLE';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    trigger OnAfterInsert()
    var
        JobTask: Record "Job Task";
        JobsSetup: Record "Jobs Setup";
    begin
        "Job Posting Group" := JobsSetup."Job Posting Group";
        JobTask.INIT();
        JobTask."Job No." := "No.";
        JobTask."Job Task No." := '1';
        JobTask.INSERT(FALSE);
    end;

}
