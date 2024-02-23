/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.01.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZSDESALDSCHEDLLN'
@EndUserText.label: 'Sales Document Schedule Line'
extend view I_SalesDocumentScheduleLine with zsd_e_salesdocumentschedulelin
{
  vbep.zz1_zcsd as ConfirmedShelfDate
}
