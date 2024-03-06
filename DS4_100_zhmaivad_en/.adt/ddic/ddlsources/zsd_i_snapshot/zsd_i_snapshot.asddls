/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 29.11.2022 | 13444     : [Build] - Stock reconciliati *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.12.2022 | 16311     : [Feature] [Build] - Stock re *
*              |            | DS4K938447                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.04.2023 | 19610     : FB_19610_SD_Feature - DEFECT - Stock Reconciliation *
*              |            | DS4K949060                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 17.04.2023 | 19611     : [Build] - Stock reconciliati *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*
" ZHMAIVAD     | 06.06.2023 | 20960     : [Build] - Stock reconciliati -
"              |            | DS4K951475                               -
----------------------------------------------------------------------*
" ZHMAIVAD     | 21.07.2023 | 22859     : [Build] - Stock reconciliati -
"              |            | DS4K957133                               -
----------------------------------------------------------------------*
* ZHMAIVAD     | 27.02.2024 | 29294     : [Feature] [Build] - Stock re *
*              |            | DS4K980553                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 13.03.2024 | 29314     : [Feature] [Build] - Stock re *
*              |            | DS4K982092                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Bw Snapshot'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_snapshot
  as select from zsd_i_bw_or_sap_snapshot
{
  key WmsSnapshotDate,
  key Plant,
  key StorageLocation,
  key Article,
  key SalesOrderNumber,
  key SalesOrderItem,
      WmsTimeStamp,
      SapTimeStamp,
      Meins,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      case when WmsTimeStamp > 0
      then UnrectrictedWmsStockQuantity
      else cast(0 as zsd_stock_recon_qnt)
      end                                             as UnrectrictedWmsStockQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      case when WmsTimeStamp > 0
      then InQualityInspWmsStockQuantity
      else cast(0 as zsd_stock_recon_qnt)
      end                                             as InQualityInspWmsStockQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      case when WmsTimeStamp > 0
      then BlockedWmsStockQuantity
      else cast(0 as zsd_stock_recon_qnt)
      end                                             as BlockedWmsStockQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      case when SapTimeStamp > 0
      then UnrectrictedSapStockQuantity
      else cast(0 as zsd_stock_recon_qnt)
      end                                             as UnrectrictedSapStockQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      case when SapTimeStamp > 0
      then InQualityInspSapStockQuantity
      else cast(0 as zsd_stock_recon_qnt)
      end                                             as InQualityInspSapStockQuantity,
      @Semantics.quantity.unitOfMeasure : 'Meins'
      case when SapTimeStamp > 0
      then BlockedSapStockQuantity
      else cast(0 as zsd_stock_recon_qnt)
      end                                             as BlockedSapStockQuantity,
      case when WmsTimeStamp > 0
      then cast( 'X'  as boolean preserving type )
      else cast( ''  as boolean preserving type ) end as ExistsInWms,
      case when SapTimeStamp > 0
      then cast( 'X'  as boolean preserving type )
      else cast( ''  as boolean preserving type ) end as ExistsInSap,
      case when $projection.ExistsInWms = 'X' and $projection.ExistsInSap = 'X'
      then cast( 'X'  as boolean preserving type )
      else cast( ''  as boolean preserving type ) end as ExistsInBoth
}
