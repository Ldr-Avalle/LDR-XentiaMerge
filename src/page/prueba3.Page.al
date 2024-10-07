page 50050 "prueba 3"
{
    ApplicationArea = All;
    Caption = 'prueba 3', Comment = 'ESP=""';
    PageType = RoleCenter;
    UsageCategory = Lists;

    layout
    {
        area(rolecenter)
        {
            group(group)
            {
                part("My Customers"; "My Customers")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                }
                part("My Vendors"; "My Vendors")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                }
            }
            group(group2)
            {
                part("Trailing Sales Orders Chart"; "Trailing Sales Orders Chart")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    Visible = false;
                }
                part("My Job Queue"; "My Job Queue")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    Visible = false;
                }
                part("My Items"; "My Items")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                }
                part("Copy Profile"; "Copy Profile")
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                    Visible = false;
                }
                systempart(MyNotes; MyNotes)
                {
                    ApplicationArea = All;
                    Caption = '', Comment = 'ESP=""';
                }
            }
        }
    }

    // actions //TODO:REVISAR TODOS LOS ACTION, NO PILLA EL ID DE LAS PAGES
    // {
    //     area(sections)
    //     {
    //         group(Documentos)
    //         {
    //             Caption = 'Documentos';
    //             Image = History;
    //             action(Facturas)
    //             {
    //                 Caption = 'Facturas';
    //                 RunObject = Page 45;
    //                 RunPageView = WHERE(Document Type=FILTER(Invoice));
    //             }
    //             action(Abonos)
    //             {
    //                 Caption = 'Abonos';
    //                 RunObject = Page 45;
    //                                 RunPageView = WHERE(Document Type=FILTER(Credit Memo));
    //             }
    //             action("Pedido compra")
    //             {
    //                 Caption = 'Pedido compra';
    //                 RunObject = Page 53;
    //                                 RunPageView = WHERE(Document Type=FILTER(Order));
    //             }
    //         }
    //         group(Fichas)
    //         {
    //             Caption = 'Fichas';
    //             Image = Ledger;
    //             action(Clientes)
    //             {
    //                 Caption = 'Clientes';
    //                 RunObject = Page 22;
    //             }
    //             action(Productos)
    //             {
    //                 Caption = 'Productos';
    //                 RunObject = Page 31;
    //             }
    //             action("Ped. transfe.")
    //             {
    //                 Caption = 'Ped. transfe.';
    //                 RunObject = Page 5742;
    //             }
    //         }
    //         group(Devoluciones)
    //         {
    //             Caption = 'Devoluciones';
    //             Image = Receivables;
    //             action("Devoluci´Š¢n compra")
    //             {
    //                 Caption = 'Devoluci´Š¢n compra';
    //                 RunObject = Page 53;
    //                                 RunPageView = WHERE(Document Type=FILTER(Return Order));
    //             }
    //         }
    //         group(Historial)
    //         {
    //             Caption = 'Historial';
    //             Image = History;
    //             action("Hist´Š¢rico facturas")
    //             {
    //                 Caption = 'Hist´Š¢rico facturas';
    //                 RunObject = Page 143;
    //             }
    //             action("Hist´Š¢rico abonos")
    //             {
    //                 Caption = 'Hist´Š¢rico abonos';
    //                 RunObject = Page 144;
    //             }
    //             action("Hist´Š¢rico albaranes compra")
    //             {
    //                 Caption = 'Hist´Š¢rico albaranes compra';
    //                 RunObject = Page 145;
    //             }
    //         }
    //         group(Cierre)
    //         {
    //             Caption = 'Cierre';
    //             Image = Journals;
    //             action("Anotaciones caja")
    //             {
    //                 Caption = 'Anotaciones caja';
    //                 RunObject = Page 50006;
    //             }
    //             action("Arqueo de caja")
    //             {
    //                 Caption = 'Arqueo de caja';
    //                 RunObject = Page 50019;
    //             }
    //         }
    //     }
    //     area(reporting)
    //     {
    //         action("Seguimiento producto")
    //         {
    //             Caption = 'Seguimiento producto';
    //             Image = Trace;
    //             RunObject = Page 6520;
    //         }
    //         action("Caducidad producto-cantidad")
    //         {
    //             Caption = 'Caducidad producto-cantidad';
    //             Image = ItemTracking;
    //             RunObject = Report 5809;
    //         }
    //         action("Ventas Avenir EUSKALTEL")
    //         {
    //             Caption = 'Ventas Avenir EUSKALTEL';
    //             Image = "Report";
    //             RunObject = Report 50075;
    //         }
    //         action("Entradas Avenir EUSKALTEL")
    //         {
    //             Caption = 'Entradas Avenir EUSKALTEL';
    //             Image = "Report";
    //             RunObject = Report 50077;
    //         }
    //         action("Ventas Avenir TELECABLE")
    //         {
    //             Caption = 'Ventas Avenir TELECABLE';
    //             Image = "Report";
    //             RunObject = Report 50076;
    //         }
    //         action("Entradas Avenir TELECABLE")
    //         {
    //             Caption = 'Entradas Avenir TELECABLE';
    //             Image = "Report";
    //             RunObject = Report 50078;
    //         }
    //     }
    // }
}

