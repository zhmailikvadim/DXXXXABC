@AbapCatalog.sqlViewName: 'zmmcreservehead'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reserve Header Consumption'
@Metadata.allowExtensions: true

@OData.publish: true
@VDM.viewType: #CONSUMPTION


@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true

}
define view ZMM_C_RESERVE_HEADER
  as select from ZMM_I_RESERVE_HEADER
  association [0..*] to ZMM_C_RESERVE_ITEM as _ReserveItem on $projection.uuid = _ReserveItem.uuid_header
  association [0..*] to ZMM_C_RESERVE_ERROR as _ReserveError on $projection.uuid = _ReserveError.uuid_header
  association [0..*] to resb as _ReserveStatus on $projection.rsnum = _ReserveStatus.rsnum
{
  key uuid,
      @ObjectModel.foreignKey.association: '_ReserveStatus'
      rsnum,
      werks,
      bdter,
      bwart,
      umwrk,
      umlgo,
      created,
      aufnr,
      has_error,
      error_id,
      error_message,
      error_number,
      saknr,
      kostl,
      /* Associations */
      @ObjectModel.association: {
       type: [ #TO_COMPOSITION_CHILD ]}
      _ReserveItem,
       @ObjectModel.association: {
       type: [ #TO_COMPOSITION_CHILD ]}
      _ReserveError,
      @ObjectModel.readOnly: true
      _ReserveStatus
} 
 