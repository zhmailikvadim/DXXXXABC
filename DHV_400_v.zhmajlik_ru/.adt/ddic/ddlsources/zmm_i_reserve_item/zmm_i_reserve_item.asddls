@AbapCatalog.sqlViewName: 'zmmireserveitem'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item Reserve'
@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZMM_RES_ITEM',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
    writeDraftPersistence: 'ZMM_RES_ITEMD'
}
define view ZMM_I_RESERVE_ITEM
  as select from zmm_res_item
  association [1..1] to ZMM_I_RESERVE_HEADER as _ReserveHeader on $projection.uuid_header = _ReserveHeader.uuid
{
  key uuid,
      uuid_header,
      rsnum,
      rspos,
      matnr,
      lgort,
      charg,
      @Semantics.quantity.unitOfMeasure : 'meins'
      menge,
      meins,
      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _ReserveHeader

} 
 