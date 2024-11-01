@AbapCatalog.sqlViewName: 'zmmctrreserve'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reserve For PK Transport CONSUMPTION'

@Metadata.allowExtensions: true

@VDM.viewType: #CONSUMPTION

@OData.publish: true
@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true

}
define view ZMM_C_TRANSPORT_RESERVE
  as select from ZMM_I_TRANSPORT_RESERVE
{
  key uuid,
      rsnum,
      rspos,
      matnr,
      werks,
      lgort,
      charg,
      bdter,
      bwart,
      umwrk,
      umlgo,
      @Semantics.quantity.unitOfMeasure : 'meins'
      menge,
      meins,
      created,
      aufnr,
      has_error,
      error_id,
      error_message,
      error_number,
      saknr,
      kostl
} 
 