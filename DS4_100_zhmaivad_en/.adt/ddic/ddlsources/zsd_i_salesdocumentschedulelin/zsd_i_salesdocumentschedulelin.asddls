@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sales Document Schedule Line'
define view entity zsd_i_salesdocumentschedulelin
  as select from I_SalesDocumentScheduleLine    as ScheduleLine
    inner join   zsd_i_salesdocscheduleline_max as MaxScheduleLine on  ScheduleLine.SalesDocument     = MaxScheduleLine.SalesDocument
                                                                   and ScheduleLine.SalesDocumentItem = MaxScheduleLine.SalesDocumentItem
                                                                   and ScheduleLine.ScheduleLine      = MaxScheduleLine.ScheduleLine
{
  key ScheduleLine.SalesDocument,
  key ScheduleLine.SalesDocumentItem,
      MaxScheduleLine.ScheduleLine,
      ScheduleLine.GoodsIssueDate,
      ScheduleLine.DeliveryDate,
      ScheduleLine.ConfirmedShelfDate,
      ScheduleLine._SalesDocumentItem,
      ScheduleLine._SalesDocument
}
