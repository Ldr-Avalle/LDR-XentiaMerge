pageextension 50033 "G/L Registers_LDR" extends "G/L Registers"
{
    Editable = true;
    layout
    {
        addafter("To VAT Entry No.")
        {
            field("Fecha registro en Mov cont_LDR"; Rec."Fecha registro en Mov cont")
            {
                ApplicationArea = All;
            }
            field("Num Asiento en Mov cont_LDR"; Rec."Num Asiento en Mov cont")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(ReverseRegister)
        {
            action(AsignarNAsientoPeriodo_LDR)
            {
                Caption = 'Asignar N° Asiento y Periodo';
                ApplicationArea = All;
                RunObject = report "Set Period Trans. Nos.";
                Image = NumberSetup;
            }
        }
    }

}
