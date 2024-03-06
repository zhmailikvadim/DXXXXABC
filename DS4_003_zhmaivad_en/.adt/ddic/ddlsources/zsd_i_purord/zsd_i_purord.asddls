/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BATCHVIN     | 04.12.2023 | 27069     : BE: Case Lot -Enhancement    *
*              |            | DS4K971200                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sales order related PO'
@ObjectModel.usageType:{
    serviceQuality: #X, 
    sizeCategory: #S,
    dataClass: #MIXED
}
define  root view entity ZSD_I_PurOrd as select distinct from I_PurOrdAccountAssignment
{
    key  PurchaseOrder as PurchaseOrder,
         SalesOrder    as Salesorder,
         _PurchaseOrderItem.Plant as Plant
    
}
