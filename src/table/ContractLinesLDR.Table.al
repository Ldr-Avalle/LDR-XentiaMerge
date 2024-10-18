table 50006 "Contract Lines_LDR"
{
    Caption = 'Líneas de contrato';

    fields
    {
        field(1; Contract; Code[20])
        {
            Caption = 'Contrato';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Nº línea';
            DataClassification = ToBeClassified;
        }
        field(3; Service; Code[20])
        {
            Caption = 'Servicio';
            DataClassification = ToBeClassified;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Cantidad';
            DataClassification = ToBeClassified;
        }
        field(5; "Activation date"; Date)
        {
            Caption = 'Fecha activación';
            DataClassification = ToBeClassified;
            Description = 'Solo para servicios móviles';
        }
        field(6; Promotion; Code[20])
        {
            Caption = 'Campaña';
            DataClassification = ToBeClassified;
        }
        field(7; "Export date"; Date)
        {
            Caption = 'Fecha exportación';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(8; "Clearance date"; Date)
        {
            Caption = 'Fecha liquidación';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(9; "SharePoint ID"; Integer)
        {
            Caption = 'Id. SharePoint';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(10; "SharePoint Created"; DateTime)
        {
            Caption = 'Fecha creación SharePoint';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(11; "SharePoint Created by ID"; Code[20])
        {
            Caption = 'Creado por';
            DataClassification = ToBeClassified;
            Description = 'ID del usuario Creado por';
            Editable = true;
        }
        field(12; "SharePoint Created by"; Text[70])
        {
            Caption = 'Creado por SharePoint';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(13; "SharePoint Modified"; DateTime)
        {
            Caption = 'Fecha modificación SharePoint';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(14; "SharePoint Modified by ID"; Code[20])
        {
            Caption = 'Modificado por';
            DataClassification = ToBeClassified;
            Description = 'ID del usuario Modificado por';
            Editable = true;
        }
        field(15; "SharePoint Modified by"; Text[70])
        {
            Caption = 'Modificado por SharePoint';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(16; "Service name"; Text[100])
        {
            Caption = 'Nombre servicio';
            Editable = false;
        }
        field(17; "Creation date"; Date)
        {
            Caption = 'Fecha creación';
            DataClassification = ToBeClassified;
        }
        field(18; "Creation time"; Time)
        {
            Caption = 'Hora creación';
            DataClassification = ToBeClassified;
        }
        field(19; "Modification date"; Date)
        {
            Caption = 'Fecha modificación';
            DataClassification = ToBeClassified;
        }
        field(20; "Modification time"; Time)
        {
            Caption = 'Hora modificación';
            DataClassification = ToBeClassified;
        }
        field(21; "NAV Created by"; Text[100])
        {
            Caption = 'Creado por Nav.';
            DataClassification = ToBeClassified;
        }
        field(22; "NAV Modified by"; Text[100])
        {
            Caption = 'Modificado por Nav.';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Contract, "Line No.")
        {
        }
        key(Key2; "SharePoint ID")
        {
        }
    }
}