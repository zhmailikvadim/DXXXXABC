/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 13.07.2023 | 22859     : [Build] - Stock reconciliati *
*              |            | DS4K957133                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Inventory Posting Errors Storage Plus'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_errors_timing_aj_btw_art
  as select from zsd_i_errors_timing_aj_base as Errors
    join         zsd_i_move_types            as MoveTypes on  MoveTypes.MoveTypeDecrease = Errors.GoodsMovementType
                                                          and MoveTypes.MoveNature       = 'A'

{
  key Errors.MaterialDocument,
  key Errors.MaterialDocumentYear,
      Errors.MaterialDocumentItem,
      Errors.Plant,
      Errors.StorageLocation,
      Errors.Article,
      Errors.SalesOrderNumber,
      Errors.SalesOrderItem,
      Errors.StockType,
      Errors.GoodsMovementType,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      Errors.Quantity,
      Errors.ReceivingArticle,
      Errors.BaseUnit
}
