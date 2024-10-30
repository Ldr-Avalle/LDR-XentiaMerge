pageextension 50030 "Job Card" extends "Job Card"
{
    layout
    {
        modify("Currency Code")
        {
            Editable = CurrencyCodeEditable;
            trigger OnAfterValidate()
            begin
                CurrencyCheck;
            end;
        }
        modify("Invoice Currency Code")
        {
            Editable = InvoiceCurrencyCodeEditable;
            trigger OnAfterValidate()
            begin
                CurrencyCheck;
            end;
        }
    }
    trigger OnOpenPage()
    begin
        CurrencyCodeEditable := TRUE;
        InvoiceCurrencyCodeEditable := TRUE;
    end;

    trigger OnAfterGetRecord()
    begin
        CurrencyCheck;
    end;

    LOCAL PROCEDURE CurrencyCheck();
    BEGIN
        IF rec."Currency Code" <> '' THEN
            InvoiceCurrencyCodeEditable := FALSE
        ELSE
            InvoiceCurrencyCodeEditable := TRUE;

        IF rec."Invoice Currency Code" <> '' THEN
            CurrencyCodeEditable := FALSE
        ELSE
            CurrencyCodeEditable := TRUE;
    END;

    VAR
        InvoiceCurrencyCodeEditable: Boolean;
        CurrencyCodeEditable: Boolean;
}

