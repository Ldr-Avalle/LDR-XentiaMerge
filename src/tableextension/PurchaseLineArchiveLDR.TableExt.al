tableextension 50013 "Purchase Line Archive_LDR" extends "Purchase Line Archive"
{
    //TODO: El código del trigger se ha quitado 
    // Comentar con Fran. Se podrían guardar los datos en tablas auxiliares y luego recuperarlos
    // Se crea un nuevo campo para pasar la información del Descipción2 si fuera necesario
    fields
    {
        field(50000; Description2_LDR; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
}