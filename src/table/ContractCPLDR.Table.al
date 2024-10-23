table 50001 "ContractCP_LDR"
{
    Caption = 'Contrato';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
        }
        field(2; "Sign date"; Date)
        {
            Caption = 'Fecha firma';
            DataClassification = ToBeClassified;
        }
        field(3; Demarcation; Text[50])
        {
            Caption = 'Demarcación';
            DataClassification = ToBeClassified;
        }
        field(4; Segment; Text[50])
        {
            Caption = 'Segmento';
            DataClassification = ToBeClassified;
        }
        field(5; "ID Comercial"; Code[20])
        {
            Caption = 'Id. Comercial';
            DataClassification = ToBeClassified;
        }
        field(6; Comercial; Text[100])
        {
            Caption = 'Comercial';
            DataClassification = ToBeClassified;
        }
        field(7; NIF; Text[10])
        {
            Caption = 'Nif';
            DataClassification = ToBeClassified;
        }
        field(8; Name; Text[70])
        {
            Caption = 'Nombre';
            DataClassification = ToBeClassified;
        }
        field(9; Address; Text[70])
        {
            Caption = 'Dirección';
            DataClassification = ToBeClassified;
        }
        field(10; "Nº"; Text[15])
        {
            Caption = 'Nº';
            DataClassification = ToBeClassified;
        }
        field(11; Floor; Text[15])
        {
            Caption = 'Piso';
            DataClassification = ToBeClassified;
        }
        field(12; CP; Text[6])
        {
            Caption = 'CP';
            DataClassification = ToBeClassified;
        }
        field(13; County; Text[70])
        {
            Caption = 'Población';
            DataClassification = ToBeClassified;
        }
        field(14; "Phone 1"; Text[50])
        {
            Caption = 'Teléfono 1';
            DataClassification = ToBeClassified;
        }
        field(15; "Phone 2"; Text[50])
        {
            Caption = 'Teléfono 2';
            DataClassification = ToBeClassified;
        }
        field(16; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Código Dimensión 1';
            DataClassification = ToBeClassified;
        }
        field(17; "SharePoint ID"; Integer)
        {
            Caption = 'ID SharePoint';
            DataClassification = ToBeClassified;
        }
        field(18; "SharePoint Created"; DateTime)
        {
            Caption = 'Fecha creación SharePoint';
            DataClassification = ToBeClassified;
        }
        field(19; "SharePoint Created by ID"; Code[20])
        {
            Caption = 'ID usuario creado por';
            DataClassification = ToBeClassified;
            Description = 'ID del usuario Creado por';
        }
        field(20; "SharePoint Created by"; Text[100])
        {
            Caption = 'Creado por';
            DataClassification = ToBeClassified;
        }
        field(21; "SharePoint Modified"; DateTime)
        {
            Caption = 'Fecha modificación SharePoint';
            DataClassification = ToBeClassified;
        }
        field(22; "SharePoint Modified by ID"; Code[20])
        {
            Caption = 'ID usuario modificado por SharePoint';
            DataClassification = ToBeClassified;
            Description = 'ID del usuario Modificado por';
        }
        field(23; "SharePoint Modified by"; Text[100])
        {
            Caption = 'Modificado por con SharePoint';
            DataClassification = ToBeClassified;
        }
        field(24; "Creation date"; Date)
        {
            Caption = 'Fecha creación';
            DataClassification = ToBeClassified;
        }
        field(25; "Creation time"; Time)
        {
            Caption = 'Hora creación';
            DataClassification = ToBeClassified;
        }
        field(26; "Modification date"; Date)
        {
            Caption = 'Fecha modificación';
            DataClassification = ToBeClassified;
        }
        field(27; "Modification time"; Time)
        {
            Caption = 'Hora modificación';
            DataClassification = ToBeClassified;
        }
        field(28; "NAV Created by"; Text[100])
        {
            Caption = 'Creado por NAV.';
            DataClassification = ToBeClassified;
        }
        field(29; "NAV Modified by"; Text[100])
        {
            Caption = 'Modificado por NAV.';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "SharePoint ID")
        {
        }
    }
}