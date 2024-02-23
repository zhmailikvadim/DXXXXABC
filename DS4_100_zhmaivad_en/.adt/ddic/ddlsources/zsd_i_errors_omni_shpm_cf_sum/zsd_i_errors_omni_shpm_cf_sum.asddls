/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 19.03.2023 | 18988     : [Build] - Stock reconciliati *
*              |            | DS4K946765                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.04.2023 | 19610     : FB_19610_SD_Feature - DEFECT - Stock Reconciliation *
*              |            | DS4K949060                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 17.04.2023 | 19611     : [Build] - Stock reconciliati *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*
" ZHMAIVAD     | 06.06.2023 | 20960     : [Build] - Stock reconciliati -
"              |            | DS4K951475                               -
----------------------------------------------------------------------*/
@EndUserText.label: 'Errors from Inbound OMNI Shipment Confrm'
@AccessControl.authorizationCheck: #CHECK
define view entity zsd_i_errors_omni_shpm_cf_sum
  as select from zsd_i_errors_omni_shpm_cf_idoc
{
  key Plant,
  key StorageLocation,
  key Product,
  key SalesOrder,
      BaseUnit,
      sum(ErrorsGiEcom) as ErrorsGiEcom,
      sum(ErrorsGiEcom) as ErrorsGrEcom
}
group by
  Plant,
  StorageLocation,
  Product,
  SalesOrder,
  BaseUnit
