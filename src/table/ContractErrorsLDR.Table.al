table 50015 "Contract Errors_LDR"
{
    Caption = 'Errores de contrato';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
        }
        field(2; "Err Type"; Option)
        {
            Caption = 'Tipo error';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Contrato, Línea contrato';
            OptionMembers = " ",Contract,"Contract line";
        }
        field(3; "Err Subtype"; Text[50])
        {
            Caption = 'Subtipo error';
            DataClassification = ToBeClassified;
        }
        field(4; Contract; Code[20])
        {
            Caption = 'Contrato';
            DataClassification = ToBeClassified;
        }
        field(5; "Contract line"; Integer)
        {
            Caption = 'Línea contrato';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[100])
        {
            Caption = 'Descripción';
            DataClassification = ToBeClassified;
        }
        field(7; "Creation date"; Date)
        {
            Caption = 'Fecha creación';
            DataClassification = ToBeClassified;
        }
        field(8; "Creation time"; Time)
        {
            Caption = 'Hora creación';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }
}