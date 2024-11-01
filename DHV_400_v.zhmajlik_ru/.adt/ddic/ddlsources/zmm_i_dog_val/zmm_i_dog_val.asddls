@AbapCatalog.sqlViewName: 'ZMMIDOGVAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Валютные договора'

@VDM.viewType: #TRANSACTIONAL

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZMM_DOG_VAL',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
    draftEnabled: true,
    writeDraftPersistence: 'ZMM_DOG_VALD'
//    lifecycle.enqueue.expiryBehavior: #RELATIVE_TO_LAST_CHANGE
}

define view ZMM_I_DOG_VAL
  as select from zmm_dog_val
  //Child
  association [0..*] to ZMM_I_DOG_PARTNER    as _DogPartner       on  $projection.uuid = _DogPartner.uuid_dog
  association [0..*] to ZMM_I_DOG_BANK_N     as _DogBank          on  $projection.uuid = _DogBank.uuid_dog
//  association [0..*] to ZMM_I_DOG_BANK_N     as _DogForeignBank   on  $projection.uuid      =  _DogForeignBank.uuid_dog
//                                                                  and _DogForeignBank.banks <> 'BY'
  association [0..*] to ZMM_I_DOG_EXECUT     as _DogExecut        on  $projection.uuid = _DogExecut.uuid_dog
  //  association [0..*] to ZMM_I_DOG_SPEC       as _DogSpec      on  $projection.uuid = _DogSpec.uuid_dog
  //Value Helps
  association [0..1] to ZMM_I_DOG_VH         as _DogVH            on  $projection.zext_key = _DogVH.zext_key
  association [0..1] to ZMM_I_DOG_TYPE_VH    as _DogTypeVH        on  $projection.typen = _DogTypeVH.dtypen
//  association [0..1] to ZMM_I_DOG_BANK_VH    as _DogForeignBankVH on  $projection.foreignbankl = _DogForeignBankVH.bankl
//                                                                  and $projection.foreignbanks = _DogForeignBankVH.banks
  association [0..1] to ZMM_I_DOG_STATUS_VH  as _DogStatusVH      on  $projection.zz_status = _DogStatusVH.status
  association [0..1] to ZMM_I_DOG_SUBTYPE_VH as _DogSubtypeVH     on  $projection.podtp = _DogSubtypeVH.podtp
                                                                  and $projection.typen = _DogSubtypeVH.dtypen
  //Other

{
  key uuid,
      zext_key,
      typen,
      podtp,
      zz_vozvrpro,
      zz_vozvrprod,
      zz_datapost,
      zz_datazach,
      zz_fbank_swift,

//      _DogForeignBank.banks               as foreignBanks,
//      _DogForeignBank.bankl               as foreignBankl,

      zz_nal,
      zz_sogl1,
      zz_sogl2,
      zz_registrar,
      //      @ObjectModel.readOnly: true
      //      _DogUsr.fio as registrar_fio,
      zz_status,
      //      zz_executor,

      case zz_status
       when '01' then 1
       when '02' then 2
       when '03' then 3
      else 0 end                          as criticality,

      cast( (case zz_status
               when '03' then ''
             else 'X' end ) as bapiyesno) as execIsHidden,

      cast( (case zz_status
              when '03' then 'X'
             else '' end ) as bapiyesno)  as regIsHidden,

      _DogVH,
      _DogTypeVH,
      _DogSubtypeVH,
      _DogStatusVH,
//      _DogForeignBankVH,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _DogPartner,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _DogBank,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _DogExecut

      //      @ObjectModel.association: {
      //      type: [ #TO_COMPOSITION_CHILD ]}
      //      _DogSpec
} 
 