@AbapCatalog.sqlViewName: 'zmmireserveerr'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Error log for reserve'
@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZMM_RES_ERROR',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
    writeDraftPersistence: 'ZMM_RES_ERRD'
}
define view ZMM_I_RESERVE_ERROR
  as select from zmm_res_error
  association [1..1] to ZMM_I_RESERVE_HEADER as _ReserveHeader on $projection.uuid_header = _ReserveHeader.uuid
{
  key uuid,
      uuid_header,
      error_id,
      error_number,
      error_message,
      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _ReserveHeader
} 
 