page 50018 "Invoice Payment Method"
{
    ApplicationArea = All;
    Caption = 'Invoice Payment Method', Comment = 'ESP=""';
    PageType = Card;
    SourceTable = "Sales Header";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Forma de pago';
                TableRelation = "Payment Method";
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Finalizar)
            {
                ApplicationArea = All;
                Caption = 'Finalizar';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    UserDim: Record "User Dimensions_LDR";
                    PaymentMethod: Record "Payment Method";
                    ApprovalMgt: Codeunit "Approvals Mgmt.";
                    PurchaseHeader: Record "Purchase Header";
                    Proyecto: Code[10];
                    text001: Label '"La forma de pago elegida no es correcta"';
                begin
                    Rec.TestField("Payment Method Code");
                    Commit();

                    Proyecto := UserDim.getProjectDim(UserId);
                    if Proyecto <> '' then begin
                        PaymentMethod.Get(Rec."Payment Method Code");
                        // if PaymentMethod.project <> Proyecto then //TODO:REVISAR
                        //     Message(text001)
                        // else if ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then Codeunit.Run(Codeunit::"Sales-Post + Print", Rec);
                    end;
                    if Proyecto = '' then
                        if ApprovalMgt.PrePostApprovalCheckPurch(PurchaseHeader) then Codeunit.Run(Codeunit::"Sales-Post + Print", Rec);

                    CurrPage.Close();
                end;
            }
        }
    }
}