tableextension 50006 "Employee_LDR" extends "Employee"
{
    fields
    {
        field(50000; "VAT Registration No."; Code[10])
        {
            Caption = 'Nif';
            Description = 'Sercable';
        }
        field(50001; "Bank Acc. No."; Text[30])
        {
            Caption = 'Nº cuenta bancaria';
            Description = 'Sercable';
        }
        field(50002; "Contract active"; Boolean)
        {
            Caption = 'Contrato activo';
            Description = 'Sercable';
            Editable = false;
        }
        field(50003; "Work position"; Option)
        {
            Caption = 'Puesto de trabajo';
            Description = 'Sercable';
            OptionMembers = " ","Asesor comercial pyme","Asesor comercial residencial","Asesor comercial empresa","Aytdte. dependienta","Dependienta pdv.","Jefe proyecto","Responsable pdv.","Responsable pyme","Jefe secci´Š¢n","Director de Operaciones",Becario;
        }
        field(50004; "Absence active"; Boolean)
        {
            Caption = 'Ausencia activa';
            Description = 'Sercable';
            Editable = false;
        }
        field(50005; "Aut. notification date"; Date)
        {
            Caption = 'Fecha notificación automática';
            Description = 'Utilizado enviar email diario con las bajas para quitar permisos';
        }
        field(50006; Proyecto; Code[20])
        {
            Description = 'Sercable';
        }
        field(50007; Provincia; Code[20])
        {
            Description = 'Sercable';
        }
        field(50008; NSS; Text[100])
        {
            Description = 'Sercable';
        }
        field(50009; "Article Info"; Code[20])
        {
            Description = 'Sercable';
            Editable = false;
        }
        field(50010; "Cotization group"; Integer)
        {
            Description = 'Sercable';
            MaxValue = 11;
            MinValue = 1;
        }
        field(50011; "Cost/Hour"; Decimal)
        {
            Caption = 'Coste/Hora';
            Description = 'Sercable';
            MaxValue = 50;
            MinValue = 1;
        }
        field(50012; Year; Decimal)
        {
            Caption = 'Año';
            DecimalPlaces = 0 : 0;
            Description = 'Sercable';
        }
        field(50013; Month; Option)
        {
            Caption = 'Mes';
            Description = 'Sercable';
            OptionCaption = '';
            OptionMembers = mes;
        }
        field(50014; "Horas/IDi present."; Decimal)
        {
            Description = 'Sercable';
            Editable = false;
        }
        field(50015; "Horas/IDi just."; Decimal)
        {
            Description = 'Sercable';
            Editable = false;
        }
        field(50016; Job; Code[20])
        {
            Caption = 'Proyecto';
            Description = 'Sercable';
        }
        field(50017; Usuario; Code[30])
        {
        }
        field(50018; PuestoTrabajo; Text[50])
        {
        }
        field(50019; ProyectoEmpleado; Code[20])
        {
        }
        field(50020; FechaLastContrato; Date)
        {
        }
        field(50021; FechaVencimientoContrato; Date)
        {
        }
        field(50022; ProvinciaProyecto; Code[20])
        {
            Caption = 'Cód. Provincia proyecto';
        }
        field(50023; NombreProvinciaProyecto; Text[100])
        {
            Caption = 'Nombre provincia proyecto';
            Editable = false;
        }
    }
    keys
    {
        // key(Key10; Name, "First Family Name", "Second Family Name")
        // {
        // }
        key(Key2; Usuario)
        {
        }
    }
}