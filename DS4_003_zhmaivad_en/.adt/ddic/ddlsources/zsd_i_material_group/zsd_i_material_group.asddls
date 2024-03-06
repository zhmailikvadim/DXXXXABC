/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SRIKAVEN     | 06.06.2023 | 20611     : BE: Case Lot -Enhancement *
*              |            | DS4K950721                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Group material'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_MATERIAL_GROUP as select from I_SalesDocumentItem  as vbap 
inner join I_SalesDocument as vbak on vbap.SalesDocument = vbak.SalesDocument
 inner join I_SalesDocumentScheduleLine as vbep on vbap.SalesDocument = vbep.SalesDocument
 and vbap.SalesDocumentItem = vbep.SalesDocumentItem
 {
 key vbap.SalesDocument                 as SalesOrder,
  key vbap.SalesDocumentItem            as SalesOrderItem,
  
       case when vbap.PricingReferenceMaterial is not initial
       then vbap.PricingReferenceMaterial
       else vbap.Material
       end as GenericMaterial
    
}where
  vbep.ConfdOrderQtyByMatlAvailCheck is not initial
