tableextension 50215 Dimension_LDR extends Dimension
{
    fields
    {
        field(50000; "Use Dimension"; Option)
        {
            Caption = 'Use Dimension';
            Description = 'SERCABLE';
            OptionCaption = ' ,Sales,Purchase,Both';
            OptionMembers = " ",Sales,Purchase,Both;
        }
    }
}