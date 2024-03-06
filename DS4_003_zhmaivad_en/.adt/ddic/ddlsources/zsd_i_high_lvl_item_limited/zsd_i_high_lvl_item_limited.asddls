/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* HURTSALE     | 11.09.2023 | 23489     : BE: Case Lot -Enhancement app*
*              |            | DS4K963105                                     *
*----------------------------------------------------------------------*
* BATCHVIN     | 19.12.2023 | 27722     : BE: Case Lot -Enhancement    *
*              |            | DS4K974369                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Case Lot - Limited High Level Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_HIGH_LVL_ITEM_LIMITED
  as select from ZSD_I_HIGH_LVL_ITEM_GROUP
{
  key SalesOrder,
  key GenericMaterial,   
  
      min( HigherLevelItem ) as HigherLevelItem
}
group by
  SalesOrder,
  GenericMaterial  
