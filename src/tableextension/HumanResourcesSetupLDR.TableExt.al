tableextension 50004 HumanResourcesSetup_LDR extends "Human Resources Setup"
{
    fields
    {
        field(50000; "Employee Contract Nos."; Code[20])
        {
            Caption = 'Contrato Empleado Nos.';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
            TableRelation = "No. Series";
        }
        field(50001; "Delete employee contracts"; Boolean)
        {
            Caption = 'Eliminar contratos empleado';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50002; "Notificate new Company E-mail"; Boolean)
        {
            Caption = 'Notificar nuevo Email empresa';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50003; "Notification email"; Text[70])
        {
            Caption = 'Email notificación';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50004; "Notification email title"; Text[70])
        {
            Caption = 'Título email notificación';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50005; "Default male path image"; Text[200])
        {

            Caption = 'Ruta imagen variación por defecto';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50006; "Default female path image"; Text[200])
        {
            Caption = 'Ruta imagen mujer por defecto';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
    }
}
