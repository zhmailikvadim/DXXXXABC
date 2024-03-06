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
----------------------------------------------------------------------*
* ZHMAIVAD     | 13.07.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 27.02.2024 | 29294     : [Feature] [Build] - Stock re *
*              |            | DS4K980553                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 13.03.2024 | 29314     : [Feature] [Build] - Stock re *
*              |            | DS4K982092                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Errors Inb OMNI Shipmet Confirm process'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ] }*/
define view entity zsd_i_errors_omni_shpm_cf_pers
  as select from zsd_t_omni_shpcf
  association to I_Product                   as _Product            on  $projection.Product = _Product.Product
  association to zsd_i_bw_snapshot_last_date as _BwSnapshotLastDate on  $projection.Product         = _BwSnapshotLastDate.Article
                                                                    and $projection.Plant           = _BwSnapshotLastDate.Plant
                                                                    and $projection.StorageLocation = _BwSnapshotLastDate.StorageLocation
{
  key                  werks                                                                                              as Plant,
  key                  lgort                                                                                              as StorageLocation,
  key                  artc_nr                                                                                            as Product,
  key                  clasfr                                                                                             as ShipmentConfirmationClassifier,
  key                  ord_id                                                                                             as SalesOrder,
  key                  track_num                                                                                          as TrackNum,
                       case when clasfr = '0001' then - qty else 0  end                                                   as ErrorsGiEcom,
                       case when clasfr = '0003' then qty else 0  end                                                     as ErrorsGrEcom,
                       rec_id                                                                                             as RecId,
                       wms_dt                                                                                             as WmsDate,
                       cast( substring(cast( _BwSnapshotLastDate.MaxWmsTimeStamp as abap.char( 23 ) ),1,8) as abap.dats ) as MaxWMSDate,
                       cast( substring(cast( _BwSnapshotLastDate.MaxWmsTimeStamp as abap.char( 23 ) ),9,6) as abap.tims ) as MaxWMSTime,
                       wms_tm                                                                                             as WmsTime,
                       _Product.BaseUnit
}
where
        cast( substring(cast( _BwSnapshotLastDate.MaxWmsTimeStamp as abap.char( 23 ) ),1,8) as abap.dats ) >  wms_dt
  or(
        cast( substring(cast( _BwSnapshotLastDate.MaxWmsTimeStamp as abap.char( 23 ) ),1,8) as abap.dats ) =  wms_dt
    and cast( substring(cast( _BwSnapshotLastDate.MaxWmsTimeStamp as abap.char( 23 ) ),9,6) as abap.tims ) >= wms_tm
  )
