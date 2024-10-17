enum 50004 Factura3oDest
{
    Extensible = true;
    
    value(0; N)
    {
        Caption = 'No';
    }
    value(1; S)
    {
        Caption = 'Sí';
    }
    value(2; T)
    {
        Caption = 'T Factura emitida por tercero o tercera';
    }
    value(3; D)
    {
        Caption = 'D Factura emitida por el destinatario o la destinataria de la operación';
    }
}
