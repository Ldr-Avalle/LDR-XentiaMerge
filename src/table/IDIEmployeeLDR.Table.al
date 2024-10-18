table 50026 "IDI Employee_LDR"
{
    fields
    {
        field(1; "Job No."; Code[20])
        {
            Caption = 'Proyecto';
            DataClassification = ToBeClassified;
        }
        field(2; Employee; Code[20])
        {
            Caption = 'Empleado';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Name; Text[30])
        {
            Caption = 'Nombre';
            Editable = false;
        }
        field(4; "Second Family Name"; Text[30])
        {
            Caption = 'Nombre segunda familia';
            Editable = false;
        }
        field(5; "First Family Name"; Text[30])
        {
            Caption = 'Nombre primera familia';
            Editable = false;
        }
        field(12; County; Text[30])
        {
            Caption = 'Cidudad';
            Editable = false;
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Nº teléfono';
            Editable = false;
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            Caption = 'Nº teléfono móvil';
            Editable = false;
        }
        field(15; "E-Mail"; Text[80])
        {
            Caption = 'Correo electrónico';
            Editable = false;
        }
        field(24; Sex; Option)
        {
            Caption = 'Sexo';
            Editable = false;
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(29; "Employment Date"; Date)
        {
            Caption = 'Fecha contratación';
            Editable = false;
        }
        field(31; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(34; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
            Editable = false;
        }
        field(50; "Company E-Mail"; Text[80])
        {
            Caption = 'Company E-Mail';
            Editable = false;
        }
        field(50001; Department; Code[20])
        {
            Caption = 'Department';
            Editable = false;
        }
        field(50003; Departament; Option)
        {
            Editable = false;
            OptionMembers = " ","Asesor comercial pyme","Asesor comercial residencial","Asesor comercial empresa","Aytdte. dependienta","Dependienta pdv.","Jefe proyecto","Responsable pdv.","Responsable pyme","Jefe secci´Š¢n","Director de Operaciones",Becario;
        }
        field(50008; "First contract date"; Date)
        {
            Caption = 'Fecha primer contrato';
            Editable = false;
        }
        field(50010; "Cotization group"; Integer)
        {
            Editable = false;
            MaxValue = 11;
            MinValue = 1;
        }
        field(50011; "Cost/Hour"; Decimal)
        {
            Caption = 'Coste/Hora';
            Editable = false;
            MaxValue = 50;
            MinValue = 1;
        }
        field(50012; Year; Decimal)
        {
            Caption = 'Año';
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(50013; Month; Option)
        {
            Caption = 'Mes';
            Editable = false;
            OptionMembers = Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        }
        field(50014; "Horas/IDi present."; Decimal)
        {
            Caption = 'Horas/IDi presentadas';
            Editable = false;
        }
        field(50015; "Horas/IDi just."; Decimal)
        {
            Caption = 'Horas/IDi justificadas';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Job No.", Employee)
        {
        }
    }
}