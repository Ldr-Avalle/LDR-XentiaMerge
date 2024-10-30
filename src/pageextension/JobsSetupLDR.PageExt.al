pageextension 50050 "Jobs Setup_LDR" extends "Jobs Setup"
{
    layout
    {
        addbefore("Automatic Update Job Item Cost")
        {
            field("Aut. Post Products Usage_LDR"; Rec."Aut. Post Products Usage")
            {
                ApplicationArea = All;
            }
            field(NombreSeccionConsolidacionProy_LDR; Rec.NombreSeccionConsolidacionProy)
            {
                ApplicationArea = All;
            }
            field(NombreLibroConsolidacion_LDR; Rec.NombreLibroConsolidacion)
            {
                ApplicationArea = All;
            }
            field(NombreLibroConsolidacionProy_LDR; Rec.NombreLibroConsolidacionProy)
            {
                ApplicationArea = All;
            }
            field(NombreSeccionConsolidacion_LDR; Rec.NombreSeccionConsolidacion)
            {
                ApplicationArea = All;
            }
            field(LibroAjusteProy_LDR; Rec.LibroAjusteProy)
            {
                ApplicationArea = All;
            }
            field(SeccionAjusteProy_LDR; Rec.SeccionAjusteProy)
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Nos.")
        {
            field("Job Posting Group_LDR"; Rec."Job Posting Group")
            {
                ApplicationArea = All;
            }
            field("Cost Transfer Account Item_LDR"; Rec."Cost Transfer Account Item")
            {
                ApplicationArea = All;
            }
            field("Max. IDI hours per month_LDR"; Rec."Max. IDI hours per month")
            {
                ApplicationArea = All;
            }
        }
    }
}
