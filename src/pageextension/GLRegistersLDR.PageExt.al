pageextension 50033 "G/L Registers" extends "G/L Registers"
{
    Editable = true;
    layout
    {
        addafter("To VAT Entry No.")
        {
            field("Fecha registro en Mov cont"; Rec."Fecha registro en Mov cont")
            {
                ApplicationArea = All;
            }
            field("Num Asiento en Mov cont"; Rec."Num Asiento en Mov cont")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(ReverseRegister)
        {
            action(AsignarNAsientoPeriodo)
            {
                Caption = 'Asignar N° Asiento y Periodo';
                ApplicationArea = All;
                RunObject = report 10700;
                Image = NumberSetup;
            }
        }
    }

}
