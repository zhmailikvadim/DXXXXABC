/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KHRYSAND     | 26.09.2022 | 13764     : BE: Case Lot - Sales order List Report A *
*              |            | DS4K930674                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Total MSP Case Lot quantity per Sale Order RDD Group'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_total_msp_case_lots_qty
  as select from zsd_t_case_lot_h as header
  association [0..*] to zsd_t_case_lot_i as _item on header.caseloth_uuid = _item.caseloth_uuid
{

  header.vbeln      as SalesOrder,
  header.matnr      as Material,
  header.werks      as Plant,
  header.edatu      as RequestedDelDate,
  header.sounit     as TotalOrderQuantityUnit,
  @Semantics.quantity.unitOfMeasure : 'TotalOrderQuantityUnit'
  sum(_item.kbmeng) as TotalCSQtyMSP
  
} where header.edatu is not initial
group by
  header.vbeln,
  header.matnr,
  header.werks,
  header.edatu,
  header.sounit
