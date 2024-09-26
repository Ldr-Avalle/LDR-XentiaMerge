tableextension 50006 Employee_LDR extends "Employee"
{
    fields
    {
        modify("No.")
        {
            Caption = 'No.';
        }
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
            CalcFormula = Exist("Employee Contract" where(Employee = field("No."),
                                                           "Expiration date" = const()));
            Caption = 'Contrato activo';
            Description = 'Sercable';
            Editable = false;
            fieldClass = Flowfield;
        }
        field(50003; "Work position"; Option)
        {
            Caption = 'Puesto de trabajo';
            Description = 'Sercable';
            OptionMembers = " ","Asesor comercial pyme","Asesor comercial residencial","Asesor comercial empresa","Aytdte. dependienta","Dependienta pdv.","Jefe proyecto","Responsable pdv.","Responsable pyme","Jefe secci´Š¢n","Director de Operaciones",Becario;
        }
        field(50004; "Absence active"; Boolean)
        {
            CalcFormula = Exist("Employee Absence" where("Employee No." = field("No."),
                                                          "To Date" = const()));
            Caption = 'Ausencia activa';
            Description = 'Sercable';
            Editable = false;
            fieldClass = Flowfield;
        }
        field(50005; "Aut. notification date"; Date)
        {
            Caption = 'Fecha notificaci´Š¢n autom´Š¢tica';
            Description = 'Utilizado enviar email diario con las bajas para quitar permisos';
        }
        field(50006; Proyecto; Code[20])
        {
            CalcFormula = Lookup("Employee internal historic_LDR".Project where("Employee No." = field("No.")));
            Description = 'Sercable';
            fieldClass = Flowfield;
        }
        field(50007; Provincia; Code[20])
        {
            CalcFormula = Lookup("Employee internal historic_LDR".County where("Employee No." = field("No.")));
            Description = 'Sercable';
            fieldClass = Flowfield;
        }
        field(50008; NSS; Text[100])
        {
            CalcFormula = Lookup("Confidential Information".Description where("Confidential Code" = const('NSS'), "Employee No." = field("No.")));
            Description = 'Sercable';
            fieldClass = Flowfield;
        }
        field(50009; "Article Info"; Code[20])
        {
            CalcFormula = Max("Misc. Article Information"."Misc. Article Code" where("Employee No." = field("No.")));
            Description = 'Sercable';
            Editable = false;
            fieldClass = Flowfield;
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
            fieldClass = FlowFilter;
        }
        field(50013; Month; Option)
        {
            Caption = 'Mes';
            Description = 'Sercable';
            fieldClass = FlowFilter;
            OptionMembers = Enero,Febrero,Marzo,Abril,Mayo,Junio,Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre;
        }
        field(50014; "Horas/IDi present."; Decimal)
        {
            CalcFormula = Sum(IDI_LDR."Horas present." where(Employee = field("No."),
                                                          Año = field(Year),
                                                          Mes = field(Month),
                                                          Proyecto = field(Job)));
            Description = 'Sercable';
            Editable = false;
            fieldClass = Flowfield;
        }
        field(50015; "Horas/IDi just."; Decimal)
        {
            CalcFormula = Sum(IDI_LDR."Horas just." where(Employee = field("No."),
                                                       Año = field(Year),
                                                       Mes = field(Month),
                                                       Proyecto = field(Job)));
            Description = 'Sercable';
            Editable = false;
            fieldClass = Flowfield;
        }
        field(50016; Job; Code[20])
        {
            Caption = 'Proyecto';
            Description = 'Sercable';
            fieldClass = FlowFilter;
        }
        field(50017; Usuario; Code[30])
        {
            trigger OnValidate()
            begin
                CheckUsuario(Usuario, "No.");
            end;
        }
        field(50018; PuestoTrabajo; Text[50])
        {
            TableRelation = "Job Responsibility".Description;
        }
        field(50019; ProyectoEmpleado; Code[20])
        {
            CalcFormula = Lookup("Default Dimension"."Dimension Value Code" where("Table ID" = const(5200),
                                                                                   "No." = field("No."),
                                                                                   "Dimension Code" = const('PROYECTO')));
            fieldClass = Flowfield;
        }
        field(50020; FechaLastContrato; Date)
        {
            CalcFormula = Max("Employee Contract"."Expiration date" where(Employee = field("No.")));
            fieldClass = Flowfield;
        }
        field(50021; FechaVencimientoContrato; Date)
        {
            CalcFormula = Max("Employee Contract"."Due date" where(Employee = field("No.")));
            fieldClass = Flowfield;
        }
        field(50022; ProvinciaProyecto; Code[20])
        {
            Caption = 'Cód. Provincia proyecto';
            TableRelation = Area;
        }
        field(50023; NombreProvinciaProyecto; Text[100])
        {
            CalcFormula = Lookup(Area.Text where(Code = field(ProvinciaProyecto)));
            Caption = 'Nombre provincia proyecto';
            Editable = false;
            fieldClass = Flowfield;
        }
    }
    keys
    {
        key(Key10; Name, "First Family Name", "Second Family Name")
        {
        }
        key(Key2; Usuario)
        {
        }
    }

    procedure CreateConfidentialTags()
    var
        Confidential: Record Confidential;
        ConfidentialInfo: Record "Confidential Information";
    begin
        if Confidential.FindFirst then
            repeat
                ConfidentialInfo.SetFilter("Employee No.", '%1', "No.");
                ConfidentialInfo.SetFilter("Confidential Code", '%1', Confidential.Code);
                if NOT ConfidentialInfo.FindFirst then begin
                    ConfidentialInfo.Init;
                    ConfidentialInfo."Employee No." := "No.";
                    ConfidentialInfo."Confidential Code" := Confidential.Code;
                    ConfidentialInfo."Line No." := 10000;
                    ConfidentialInfo.Insert();
                end;
            until Confidential.Next() = 0;
    end;

    local procedure CheckUsuario(Usu: Code[30]; Number: Code[20])
    var
        Employee: Record Employee;
        Check: Boolean;
        Finish: Boolean;
        t: Text[250];
    begin
        Check := true;
        t := '';
        Employee.SetCurrentKey(Usuario);
        Employee.SetRange(Usuario, Usu);
        Employee.SetFilter("No.", '<>%1', Number);
        if Employee.FIND('-') then begin
            Check := false;
            Finish := false;
            repeat
                if Employee."No." <> Number then
                    if t = '' then
                        t := Employee."No."
                    else
                        if StrLen(t) + StrLen(Employee."No.") + 5 <= MaxStrLen(t) then
                            t := t + ', ' + Employee."No."
                        else begin
                            t := t + '...';
                            Finish := true;
                        end;
            until (Employee.Next() = 0) or Finish;
        end;

        if (Check = false) and (Employee.Usuario <> '') then
            Message(MensajeUsuarioDuplicado, t);
    end;

    var
        MensajeUsuarioDuplicado: Label 'Este usuario se ha introducido ya para el siguiente empleado:\ %1';
}
