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
            TableRelation = Employee;
        }
        field(3; Name; Text[30])
        {
            CalcFormula = Lookup(Employee.Name where("No." = field(Employee)));
            Caption = 'Nombre';
            Editable = false;
            FieldClass = Flowfield;
        }
        field(4; "Second Family Name"; Text[30])
        {
            CalcFormula = Lookup(Employee."Second Family Name" where("No." = field(Employee)));
            Caption = 'Nombre segunda familia';
            Editable = false;
            FieldClass = Flowfield;
        }
        field(5; "First Family Name"; Text[30])
        {
            CalcFormula = Lookup(Employee."First Family Name" where("No." = field(Employee)));
            Caption = 'Nombre primera familia';
            Editable = false;
            FieldClass = Flowfield;
        }
        field(12; County; Text[30])
        {
            CalcFormula = Lookup(Employee.County where("No." = field(Employee)));
            Caption = 'Cidudad';
            Editable = false;
            FieldClass = Flowfield;
        }
        field(13; "Phone No."; Text[30])
        {
            CalcFormula = Lookup(Employee."Phone No." where("No." = field(Employee)));
            Caption = 'Nº teléfono';
            Editable = false;
            FieldClass = Flowfield;
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            CalcFormula = Lookup(Employee."Mobile Phone No." where("No." = field(Employee)));
            Caption = 'Nº teléfono móvil';
            Editable = false;
            FieldClass = Flowfield;
        }
        field(15; "E-Mail"; Text[80])
        {
            CalcFormula = Lookup(Employee."E-Mail" where("No." = field(Employee)));
            Caption = 'Correo electrónico';
            Editable = false;
            FieldClass = Flowfield;
        }
#pragma warning disable AL0603
        field(24; Sex; Option)
#pragma warning restore AL0603
        {
            CalcFormula = Lookup(Employee.Gender where("No." = field(Employee)));
            Caption = 'Sexo';
            Editable = false;
            FieldClass = Flowfield;
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ",Female,Male;
        }
        field(29; "Employment Date"; Date)
        {
            CalcFormula = Lookup(Employee."Employment Date" where("No." = field(Employee)));
            Caption = 'Fecha contratación';
            Editable = false;
            FieldClass = Flowfield;
        }
#pragma warning disable AL0603
        field(31; Status; Option)
#pragma warning restore AL0603
        {
            CalcFormula = Lookup(Employee.Status where("No." = field(Employee)));
            Caption = 'Status';
            Editable = false;
            FieldClass = Flowfield;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(34; "Termination Date"; Date)
        {
            CalcFormula = Lookup(Employee."Termination Date" where("No." = field(Employee)));
            Caption = 'Termination Date';
            Editable = false;
            FieldClass = Flowfield;
        }
        field(50; "Company E-Mail"; Text[80])
        {
            CalcFormula = Lookup(Employee."Company E-Mail" where("No." = field(Employee)));
            Caption = 'Company E-Mail';
            Editable = false;
            FieldClass = Flowfield;
        }
#pragma warning disable AL0717
        field(50001; Department; Code[20])
#pragma warning restore AL0717
        {
            Caption = 'Department';
            Editable = false;
            FieldClass = Flowfield;
        }
        field(50003; Departament; Option)
        {
            CalcFormula = Lookup(Employee."Work position" where("No." = field(Employee)));
            Editable = false;
            FieldClass = Flowfield;
            OptionMembers = " ","Asesor comercial pyme","Asesor comercial residencial","Asesor comercial empresa","Aytdte. dependienta","Dependienta pdv.","Jefe proyecto","Responsable pdv.","Responsable pyme","Jefe secci´Š¢n","Director de Operaciones",Becario;
            //todo: metería el blocked
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
#pragma warning disable AL0717
        field(50008; "First contract date"; Date)
#pragma warning restore AL0717
        {
            Caption = 'Fecha primer contrato';
            Editable = false;
            FieldClass = Flowfield;
        }
        field(50010; "Cotization group"; Integer)
        {
            CalcFormula = Lookup(Employee."Cotization group" where("No." = field(Employee)));
            Editable = false;
            FieldClass = Flowfield;
            MaxValue = 11;
            MinValue = 1;
        }
        field(50011; "Cost/Hour"; Decimal)
        {
            CalcFormula = Lookup(Employee."Cost/Hour" where("No." = field(Employee)));
            Caption = 'Coste/Hora';
            Editable = false;
            FieldClass = Flowfield;
            MaxValue = 50;
            MinValue = 1;
        }
        field(50012; Year; Decimal)
        {
            Caption = 'Año';
            DecimalPlaces = 0 : 0;
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50013; Month; Option)
        {
            Caption = 'Mes';
            Editable = false;
            FieldClass = FlowFilter;
            OptionMembers = Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        }
        field(50014; "Horas/IDi present."; Decimal)
        {
            CalcFormula = Sum(IDI_LDR."Horas present." where(Proyecto = field("Job No."),
                                                          Employee = field(Employee),
                                                          Año = field(Year),
                                                          Mes = field(Month)));
            Caption = 'Horas/IDi presentadas';
            Editable = false;
            FieldClass = Flowfield;
        }
        field(50015; "Horas/IDi just."; Decimal)
        {
            CalcFormula = Sum(IDI_LDR."Horas just." where(Proyecto = field("Job No."),
                                                       Employee = field(Employee),
                                                       Año = field(Year),
                                                       Mes = field(Month)));
            Caption = 'Horas/IDi justificadas';
            Editable = false;
            FieldClass = Flowfield;
        }
    }

    keys
    {
        key(Key1; "Job No.", Employee)
        {
        }
    }
}

