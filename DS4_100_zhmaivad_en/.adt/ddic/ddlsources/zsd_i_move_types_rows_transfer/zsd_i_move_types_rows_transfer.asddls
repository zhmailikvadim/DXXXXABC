/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 06.12.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.05.2023 | 20960     : [Feature] [Build] - Stock re *
*              |            | DS4K951475                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Move Types Rows and Transfer'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
define view entity zsd_i_move_types_rows_transfer
  as select from zsd_i_move_types_rows
{
  key StockType                                                                           as StockType,
  key MoveType                                                                            as MoveType,
  key cast( 'X'  as boolean preserving type )                                             as Reverse,
  key cast( case when StockTypeTo <> '' then 'X' else '' end as boolean preserving type ) as MoveGroupIsTransfer
}

union select from zsd_i_move_types_rows
{
  key   StockTypeTo                                                     as StockType,
  key   MoveType,
  key   cast( ''  as boolean preserving type )                          as Reverse,
  key cast( case when StockTypeTo <> '' then 'X' else '' end as boolean preserving type ) as MoveGroupIsTransfer
}
where
  StockTypeTo <> ''
