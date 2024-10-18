tableextension 50522 CompanyInformation_LDR extends "Company Information"
{
    fields
    {
        field(50000; "Domain Name"; Text[20])
        {
            Description = 'SERCABLE';
        }
        field(50001; "Reports Image"; Blob)
        {
            Description = 'SERCABLE';
        }
        field(50002; Book; Text[30])
        {
            Caption = 'Libro';
            Description = 'SERCABLE';
        }
        field(50003; "Mercantil register"; Text[30])
        {
            Caption = 'Registro mercantil';
            Description = 'SERCABLE';
        }
        field(50004; Hoja; Text[30])
        {
            Description = 'SERCABLE';
        }
        field(50005; Folio; Text[30])
        {
            Description = 'SERCABLE';
        }
        field(50006; Section; Text[30])
        {
            Caption = 'Sección';
            Description = 'SERCABLE';
        }
        field(50007; Tomo; Text[30])
        {
            Description = 'SERCABLE';
        }
        field(50008; "Other data"; Text[250])
        {
            Caption = 'Otros datos';
            Description = 'SERCABLE';
        }
        field(50009; Entity; Text[30])
        {
            Caption = 'Entidad';
            Description = 'SERCABLE';
        }
        field(50010; "Entity type"; Option)
        {
            Caption = 'Tipo entidad';
            Description = 'SERCABLE';
            OptionCaption = 'Jurídica,Física';
            OptionMembers = "Jurídica","Física";
        }
        field(50011; "Digital Cert. Name"; Text[250])
        {
            Caption = 'Nombre certificado digital';
            Description = 'SERCABLE';
        }
        field(50012; "Facturae Chipbip path"; Text[250])
        {
            Caption = 'Ruta Facturae Chipbip';
            Description = 'SERCABLE';
        }
        field(50013; "XML Files path"; Text[150])
        {
            Caption = 'Ruta archivos XML';
            Description = 'SERCABLE';
        }
        field(50014; "Delete XML file"; Boolean)
        {
            Caption = 'Eliminar fichero XML';
            Description = 'SERCABLE';
        }
        field(50015; "PDF Printer Name"; Text[30])
        {
            Caption = 'PDF Printer Name';
            Description = 'SERCABLE';
        }
        field(50016; "PDF AutoSave Path"; Text[100])
        {
            Caption = 'PDF Autosave Path';
            Description = 'SERCABLE';
        }
        field(50017; "OO Files Path"; Text[250])
        {
            Caption = 'Ruta archivos OO';
            Description = 'SERCABLE';
        }
        field(50018; "CO Files Path"; Text[250])
        {
            Caption = 'Ruta archivos CO';
            Description = 'SERCABLE';
        }
        field(50019; "Bank Code"; Code[10])
        {
            Caption = 'Código Metodo Transferencia';
            Description = 'SERCABLE';
            TableRelation = "Payment Method".Code;
        }
        field(50020; CCC1; Text[24])
        {
            Caption = 'Código CCC1';
            Description = 'SERCABLE';
        }
        field(50021; CCC2; Text[24])
        {
            Caption = 'Código CCC2';
            Description = 'SERCABLE';
        }
        field(50022; CCC3; Text[24])
        {
            Caption = 'Código CCC3';
            Description = 'SERCABLE';
        }
        field(50023; "Logo Idepa"; Blob)
        {
            Description = 'SERCABLE';
        }
        field(50024; "Logo Ministerio"; Blob)
        {
            Description = 'SERCABLE';
        }
        field(50025; "Logo Feder"; Blob)
        {
            Description = 'SERCABLE';
        }
        field(50026; imgReports; Blob)
        {
            Caption = 'Image Reports';
            Description = 'Imagen para mostrar en los formularios para separar secciones';
            Subtype = Bitmap;
        }
    }
}