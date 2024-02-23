@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Document Flow - Basic'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity zsd_i_sales_document_flow
  as select from mska as _OrderItems
    inner join   vbfa as _Deliveries on  _OrderItems.vbeln   = _Deliveries.vbelv
                                     and _OrderItems.posnr   = _Deliveries.posnv
                                     and _Deliveries.vbtyp_n = 'J'

{
  key  _OrderItems.vbeln as OrderNumber,
  key  _OrderItems.posnr as OrderItemNumber,
  key  _Deliveries.vbeln as DeliveryNumber,
  key  _Deliveries.posnn as DeliveryItemNumber

}
