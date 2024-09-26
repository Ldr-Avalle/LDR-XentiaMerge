tableextension 50007 JobsSetup_LDR extends "Jobs Setup"
{
    fields
    {
        field(50000; "Aut. Post Products Usage"; Boolean)
        {
            Caption = 'Registrar aut. uso de productos';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50001; "Cost Transfer Account"; Code[10])
        {
            Caption = 'Cuenta traspaso de costes';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "G/L Account";
        }
        field(50045; LibroAjusteProy; Code[10])
        {
            Caption = 'Libro ajuste proy';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "Job Journal Template".Name;
        }
        field(50046; SeccionAjusteProy; Code[10])
        {
            Caption = 'Sección ajuste proy';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "Job Journal Batch".Name where("Journal Template Name" = field(LibroAjusteProy));
        }
        field(50047; NombreLibroConsolidacionProy; Code[10])
        {
            Caption = 'Nombre libro consolidación proy';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50048; NombreSeccionConsolidacionProy; Code[10])
        {
            Caption = 'Nombre sección consolidacion proy';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field(NombreLibroConsolidacionProy));
        }
        field(50052; LibroAjuste; Code[10])
        {
            Caption = 'Nombre libro ajustes';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50053; SeccionAjuste; Code[10])
        {
            Caption = 'Nombre sección ajustes';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field(LibroAjuste));
        }
        field(50054; NombreLibroConsolidacion; Code[10])
        {
            Caption = 'Nombre libro consolidación';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50055; NombreSeccionConsolidacion; Code[10])
        {
            Caption = 'Nombre sección consolidacion';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field(NombreLibroConsolidacion));
        }
        field(50056; "Job Posting Group"; Code[10])
        {
            Caption = 'Grupo Contable Proyectos';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "Job Posting Group";
        }
        field(50057; "Cost Transfer Account Item"; Code[10])
        {
            Caption = 'Elemento traspaso de costes';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "G/L Account";
        }
        field(50058; "Max. IDI hours per month"; Decimal)
        {
            Caption = 'Máx. horas IDI por mes';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            MaxValue = 160;
            MinValue = 140;
        }
    }
}
