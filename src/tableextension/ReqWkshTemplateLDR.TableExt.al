tableextension 50161 ReqWkshTemplate_LDR extends "Req. Wksh. Template"
{
    fields
    {
        modify("Page ID")
        {
            TableRelation = AllObj."Object ID" where("Object Type" = const(Page));
        }
    }
}