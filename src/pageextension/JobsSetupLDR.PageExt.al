pageextension 50050 "Jobs Setup" extends "Jobs Setup"
{
    layout
    {
        addbefore("Automatic Update Job Item Cost")
        {
            field("Aut. Post Products Usage"; Rec."Aut. Post Products Usage")
            {
                ApplicationArea = All;
            }
            field(NombreSeccionConsolidacionProy; Rec.NombreSeccionConsolidacionProy)
            {
                ApplicationArea = All;
            }
            field(NombreLibroConsolidacion; Rec.NombreLibroConsolidacion)
            {
                ApplicationArea = All;
            }
            field(NombreLibroConsolidacionProy; Rec.NombreLibroConsolidacionProy)
            {
                ApplicationArea = All;
            }
            field(NombreSeccionConsolidacion; Rec.NombreSeccionConsolidacion)
            {
                ApplicationArea = All;
            }
            field(LibroAjusteProy; Rec.LibroAjusteProy)
            {
                ApplicationArea = All;
            }
            field(SeccionAjusteProy; Rec.SeccionAjusteProy)
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Nos.")
        {
            field("Job Posting Group"; Rec."Job Posting Group")
            {
                ApplicationArea = All;
            }
            field("Cost Transfer Account Item"; Rec."Cost Transfer Account Item")
            {
                ApplicationArea = All;
            }
            field("Max. IDI hours per month"; Rec."Max. IDI hours per month")
            {
                ApplicationArea = All;
            }
        }
    }
}
