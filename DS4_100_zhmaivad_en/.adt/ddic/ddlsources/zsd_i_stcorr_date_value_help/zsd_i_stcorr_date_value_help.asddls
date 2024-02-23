/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 19.03.2023 | 18988     : [Build] - Stock reconciliati *
*              |            | DS4K946765                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 17.04.2023 | 19611     : [Build] - Stock reconciliati *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*
" ZHMAIVAD     | 06.06.2023 | 20960     : [Build] - Stock reconciliati -
"              |            | DS4K951475                               -
----------------------------------------------------------------------*
" ZHMAIVAD     | 21.07.2023 | 22859     : [Build] - Stock reconciliati -
"              |            | DS4K957133                               -
----------------------------------------------------------------------*/
@EndUserText.label: 'Value Help For WMS  Dates'
@AccessControl.authorizationCheck: #CHECK
@UI: { presentationVariant: [
                                {
                                    qualifier : 'SortByDate',
                                    sortOrder: [{
                                        by: 'WmsSnapshotDate', direction: #DESC
                                    }]
                                }
                            ]
    }

/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity zsd_i_stcorr_date_value_help
  as select distinct from zsd_i_stock_corr_rprt
{
  key WmsSnapshotDate
}
//where
//  WmsSnapshotDate > dats_add_months($session.system_date,-1,'NULL')
