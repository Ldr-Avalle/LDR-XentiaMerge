table 50000 "User Dimensions_LDR"
{
    Caption = 'Dimensiones de usuario';

    fields
    {
        field(1; User; Text[250])
        {
            Caption = 'Usuario';
            DataClassification = ToBeClassified;
            TableRelation = User."User Security ID";
        }
        field(2; "Project Dimension Value"; Code[20])
        {
            Caption = 'Valor dimensión proyecto';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROYECTO'));
        }
        field(3; "Provincias Dimension Value"; Code[20])
        {
            Caption = 'Valor dimensión provincias';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('PROVINCIAS'));
        }
        field(4; "Unidades Prod  Dimension Value"; Code[20])
        {
            Caption = 'Valor dimensión unidades producción';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('UNIDADES PRODUCCIÓN'));
        }
        field(5; "Location Code"; Code[10])
        {
            Caption = 'Cód ubicación';
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }
        field(7; "Shop Address"; Text[100])
        {
            Caption = 'Dirección tienda';
            DataClassification = ToBeClassified;
        }
        field(8; "Segmento Dimension Value"; Code[20])
        {
            Caption = 'Valor dimensión segmento';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where("Dimension Code" = const('SEGMENTO'));
        }
        field(9; "Shop Code"; Text[30])
        {
            Caption = 'Cód tienda';
            DataClassification = ToBeClassified;
        }
        field(10; Usuario; Code[50])
        {
            Caption = 'Usuario';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; User)
        {
        }
    }

    var
        WindowsLogin: Record User;
        UserDimensions: Record "User Dimensions_LDR";

    procedure getProjectDim(User: Text[65]) Value: Code[20]
    var
        UserDims: Record "User Dimensions_LDR";
    begin
        WindowsLogin.SetFilter("User Name", '%1|%2|%3', 'CHIPBIP\' + User, 'IZERTIS\' + User, 'SERCABLE\' + User);
        if WindowsLogin.FindFirst then begin
            UserDims.SetFilter(User, '%1', WindowsLogin."User Security ID");
            if UserDims.FindFirst then
                exit(UserDims."Project Dimension Value");
        end;
        exit('');
    end;

    procedure getAreaDim(User: Text[65]) Value: Code[20]
    var
        UserDims: Record "User Dimensions_LDR";
    begin
        WindowsLogin.SetFilter("User Name", '%1|%2|%3', 'CHIPBIP\' + User, 'IZERTIS\' + User, 'SERCABLE\' + User);
        if WindowsLogin.FindFirst then begin
            UserDims.SetFilter(User, '%1', WindowsLogin."User Security ID");
            if UserDims.FindFirst then
                exit(UserDims."Provincias Dimension Value");
        end;
        exit('');
    end;

    procedure getDeptDim(User: Text[65]) Value: Code[20]
    var
        UserDims: Record "User Dimensions_LDR";
    begin
        WindowsLogin.SetFilter("User Name", '%1|%2|%3', 'CHIPBIP\' + User, 'IZERTIS\' + User, 'SERCABLE\' + User);
        if WindowsLogin.FindFirst then begin
            UserDims.SetFilter(User, '%1', WindowsLogin."User Security ID");
            if UserDims.FindFirst then
                exit(UserDims."Unidades Prod  Dimension Value");
        end;
        exit('');
    end;

    procedure getSegmentDim(User: Text[65]) Value: Code[20]
    var
        UserDims: Record "User Dimensions_LDR";
    begin
        WindowsLogin.SetFilter("User Name", '%1|%2|%3', 'CHIPBIP\' + User, 'IZERTIS\' + User, 'SERCABLE\' + User);
        if WindowsLogin.FindFirst then begin
            UserDims.SetFilter(User, '%1', WindowsLogin."User Security ID");
            if UserDims.FindFirst then
                exit(UserDims."Segmento Dimension Value")
        end;
        exit('');
    end;

    procedure getLocationCode(User: Text[65]) Value: Code[10]
    var
        UserDims: Record "User Dimensions_LDR";
    begin
        WindowsLogin.SetFilter("User Name", '%1|%2|%3', 'CHIPBIP\' + User, 'IZERTIS\' + User, 'SERCABLE\' + User);
        if WindowsLogin.FindFirst then begin
            UserDims.SetFilter(User, '%1', WindowsLogin."User Security ID");
            if UserDims.FindFirst then
                exit(UserDims."Location Code");
        end;
        exit('');
    end;

    procedure existsUser(User: Text[65]) Exist: Boolean
    var
        UserDims: Record "User Dimensions_LDR";
        WindowsLogin: Record User;
    begin
        WindowsLogin.SetFilter("User Name", '%1|%2|%3', 'CHIPBIP\' + User, 'IZERTIS\' + User, 'SERCABLE\' + User);
        if WindowsLogin.FindFirst then begin
            UserDims.SetFilter(User, '%1', WindowsLogin."User Security ID");
            exit(UserDims.FindFirst);
        end;
        exit(false);
    end;

    procedure ShopAddress(User: Text[65]) Address: Text[100]
    var
        UserDims: Record "User Dimensions_LDR";
        WindowsLogin: Record User;
    begin
        WindowsLogin.SetFilter("User Name", '%1|%2|%3', 'CHIPBIP\' + User, 'IZERTIS\' + User, 'SERCABLE\' + User);
        if WindowsLogin.FindFirst then begin
            UserDims.SetFilter(User, '%1', WindowsLogin."User Security ID");
            if UserDims.FindFirst then
                exit(UserDims."Shop Address")
        end;
        exit('');
    end;
}

