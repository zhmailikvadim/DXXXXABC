@AbapCatalog.sqlViewName: 'ZMMCDOGBANK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Реквезиты контрагента-нерез. по договору'

@Metadata.allowExtensions: true

@VDM.viewType: #CONSUMPTION

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    //writeActivePersistence: 'ZMM_DOG_BANK',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
    //draftEnabled: true,
    //writeDraftPersistence: 'ZMM_DOG_PARTNERD'
}

define view ZMM_C_DOG_BANK
  as select from ZMM_I_DOG_BANK_N
  association [1..1] to ZMM_C_DOG_VAL_N as _DogVal on $projection.uuid_dog = _DogVal.uuid
{
  key uuid,
      uuid_dog,
      @ObjectModel.mandatory: true  
      zz_swift,

      _DogBankVH,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _DogVal
} 
 