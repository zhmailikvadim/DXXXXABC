@AbapCatalog.sqlViewName: 'zmmidelivshed'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivery Shedule For Kontur'
@Search.searchable: true
define view ZMM_I_delivery_schedule
  as select from I_Purchaserequisitionitem
  association [0..1] to eban                 as _EBAN               on  banfn = I_Purchaserequisitionitem.PurchaseRequisition
                                                                    and bnfpo = I_Purchaserequisitionitem.PurchaseRequisitionItem
  association [0..1] to zlink                as z                   on  z.banfn = I_Purchaserequisitionitem.PurchaseRequisition
                                                                    and z.bnfpo = I_Purchaserequisitionitem.PurchaseRequisitionItem
  association [0..1] to I_MaterialText       as _Text               on  $projection.Material = _Text.Material
  association [0..1] to I_PurchasingDocument as _PurchasingDocument on  I_Purchaserequisitionitem.PurchasingDocument = _PurchasingDocument.PurchasingDocument
{
  key PurchaseRequisition,
  key PurchaseRequisitionItem,
      DeliveryDate,
      Material,
      BaseUnit,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking : #HIGH
      _Text.MaterialName                                                                   as Fullname,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      ( RequestedQuantity - OrderedQuantity )                                              as volume,
      //PurReqnReleaseStatus as Status,
      coalesce(_PurchasingDocument.PurchasingGroup, _PurchasingGroup.PurchasingGroupName ) as PurchasingGroupName,
      case when (_EBAN.zzsrm_sv is not null )
            then 'X'
            else '' end                                                                    as request_status
}
where
  (
       PurchaseRequisition like '3%'
    or PurchaseRequisition like '4%'
  )
  and  _Text.Language      = $session.system_language
  and  z.mandt             is null
  and  IsDeleted           =    '' 
 