/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.05.2023 | 20960     : [Feature] [Build] - Stock re *
*              |            | DS4K951475                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Move Types Rows'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
define view entity zsd_i_move_types_rows
  as select from zsd_i_move_types
{
  key MoveFrom as StockType,
  key MoveTo as StockTypeTo,
  key MoveTypeIncrease as MoveType
}
where MoveTypeIncrease > ''
union select from zsd_i_move_types
{
  key MoveFrom as StockType,
  key MoveTo as StockTypeTo,
  key MoveTypeDecrease as MoveType
}
where MoveTypeDecrease > ''
