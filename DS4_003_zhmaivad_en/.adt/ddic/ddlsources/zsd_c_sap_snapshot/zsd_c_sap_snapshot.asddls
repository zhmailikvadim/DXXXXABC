/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.12.2022 | 16311     : [Feature] [Build] - Stock re *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 20.04.2023 | 19611     : [Feature] [Build] - Stock re *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*
" ZHMAIVAD     | 06.06.2023 | 20960     : [Build] - Stock reconciliati -
"              |            | DS4K951475                               -
----------------------------------------------------------------------*/

@EndUserText.label: 'Sap Snapshot - Projection'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define root view entity zsd_c_sap_snapshot
  provider contract transactional_query
  as projection on zsd_i_sap_snapshot
{
  key SapSnapshotDate,
  key Plant,
  key StorageLocation,
  key SalesOrderNumber,
  key SalesOrderItem,
  key Article,
      SapTimestamp,
      UuQty,
      BlQty,
      QiQty,
      UuDiff,
      BlDiff,
      QiDiff,
      UuRealDiff,
      BlRealDiff,
      QiRealDiff,
      UuDiffValue,
      BlDiffValue,
      QiDiffValue,
      ErrorsUuTiming,
      ErrorsBlTiming,
      ErrorsQiTiming,
      ErrorsGrUuQty,
      ErrorsGrQiQty,
      ErrorsGrBlQty,
      ErrorsGiUuQty,
      ErrorGrEcom,
      ErrorGiEcom,
      ErrorsInvpostUuQty,
      ErrorsInvpostBlQty,
      ErrorsInvpostQiQty,
      TotalNetDiff,
      TotalNetDiffAbs,
      TotalDiffValue,
      TotalDiffValueAbs,
      HasDifference,
      Currency,
      UnitOfMeasure,
      CreatedOn,
      CreatedBy,
      ChangedOn,
      ChangedBy
}
