tableextension 50008 "ServiceMgtSetup_LDR" extends "Service Mgt. Setup"
{
    fields
    {
        field(50000; "Contract Nos."; Code[20])
        {
            Caption = 'Serie contratos';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50001; "Promotion Nos."; Code[20])
        {
            Caption = 'Serie promoción';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50002; "TC Contract List ID"; Text[80])
        {
            Caption = 'ID lista contratos TC';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50003; "TC Contract List URL"; Text[80])
        {
            Caption = 'URL lista contratos TC';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50004; "TC Cont. Line List ID"; Text[80])
        {
            Caption = 'ID lista líneas cont. TC';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50005; "TC Cont. Line List URL"; Text[80])
        {
            Caption = 'URL lista líneas cont. TC';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
        field(50006; "County Nos."; Code[20])
        {
            Caption = 'Población Nos.';
            DataClassification = ToBeClassified;
            Description = 'Sercable';
        }
    }
}