tableextension 50119 "Job_LDR" extends "Job"
{
    fields
    {
        field(50000; "Customer Order No."; Text[30])
        {
            Description = 'SERCABLE';
        }
        field(50001; "Payment Terms Code"; Code[10])
        {
            Description = 'SERCABLE';
        }
        field(50002; "Payment Method Code"; Code[10])
        {
            Description = 'SERCABLE';
        }
        field(50004; CosteTotalImputado; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Contract (Invoiced Price)';
            Description = 'SERCABLE';
            Editable = false;
        }
        field(50005; ImporteFacturado; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Contract (Invoiced Price)';
            Description = 'SERCABLE';
            Editable = false;
        }
        field(50006; ImporteVentaImputado; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Contract (Invoiced Price)';
            Description = 'SERCABLE';
            Editable = false;
        }
        field(50007; BudgetCost; Decimal)
        {
        }
        field(50008; BudgetPrice; Decimal)
        {
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
        }
        field(50012; "% Completed"; Decimal)
        {
            Caption = '% Completado';
            Description = 'SERCABLE';
            MaxValue = 100;
            MinValue = 0;
        }
        field(50013; "Año"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'SERCABLE';
        }
        field(50014; Mes; Option)
        {
            Description = 'SERCABLE';
            OptionCaption = '';
            OptionMembers = mes;
        }
        field(50015; "Horas/IDi present."; Decimal)
        {
            Description = 'SERCABLE';
            Editable = false;

        }
        field(50016; "Horas/IDi just."; Decimal)
        {
            Description = 'SERCABLE';
            Editable = false;
        }
        field(50017; "Coste/IDi present."; Decimal)
        {
            Description = 'SERCABLE';
            Editable = false;
        }
        field(50018; "Coste/IDi just."; Decimal)
        {
            Description = 'SERCABLE';
            Editable = false;
        }
    }
}