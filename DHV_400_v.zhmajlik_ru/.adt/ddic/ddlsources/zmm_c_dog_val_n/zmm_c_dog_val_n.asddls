@AbapCatalog.sqlViewName: 'ZMMCDOGVALN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@Search.searchable: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Валютные договора'

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
    deleteEnabled: true,
    draftEnabled: true
}

define view ZMM_C_DOG_VAL_N
  as select from ZMM_I_DOG_VAL
  association [0..1] to ZMM_I_DOG               as _Dog         on $projection.zext_key = _Dog.zext_key
  association [0..1] to ZMM_B_DOG_BANK          as _ForeignBank on $projection.zz_fbank_swift = _ForeignBank.swift
  association [0..*] to ZMM_C_DOG_PARTNER       as _DogPartner  on $projection.uuid = _DogPartner.uuid_dog
  association [0..*] to ZMM_C_DOG_BANK          as _DogBank     on $projection.uuid = _DogBank.uuid_dog
  association [0..*] to ZMM_C_DOG_VAL_EXECUTION as _DogValExec  on $projection.uuid = _DogValExec.uuid_dog
//  association [0..1] to ZHR_I_PA0001            as _RegPA0001   on $projection.zz_registrar = _RegPA0001.pernr
//  association [0..1] to ZHR_I_PA0001            as _ExecPA0001  on $projection.zz_executor = _ExecPA0001.pernr
{
  key uuid,
      @ObjectModel.mandatory: true
      @Search.defaultSearchElement : true
      @Search.fuzzinessThreshold : 0.7
      @Search.ranking : #HIGH
      zext_key,
      @ObjectModel.mandatory: true
      typen,
      @ObjectModel.mandatory: true
      podtp,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      zz_vozvrpro,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      zz_vozvrprod,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      zz_datapost,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      zz_datazach,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      zz_fbank_swift,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      zz_nal,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      zz_sogl1,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      zz_sogl2,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      zz_fio,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      zz_phone,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      zz_bukrs,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      zz_status,
      @ObjectModel.readOnly: #('EXTERNAL_CALCULATION')
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      criticality,

      zz_registrar,
//      @ObjectModel.readOnly: true
//      _RegPA0001.bukrs      as zz_regbukrs,

//      zz_executor,
//      @ObjectModel.readOnly: true
//      _ExecPA0001.bukrs     as zz_execbukrs,

      @ObjectModel.readOnly: true
      _ForeignBank.banka    as zz_fbank_name,
      @ObjectModel.readOnly: true
      _ForeignBank.country  as zz_fbank_cntr,
      @ObjectModel.readOnly: true
      _Dog.ps_active_tstart as ps_active_tstart,
      @ObjectModel.readOnly: true
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      _Dog.ps_active_tend   as ps_active_tend,
      @ObjectModel.readOnly: true
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      _Dog.zz_ndoc          as zz_ndoc,
      @ObjectModel.readOnly: true
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      _Dog.zz_zterm         as zz_zterm,
      @ObjectModel.readOnly: true
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      _Dog.zz_waers         as zz_waers,
      @ObjectModel.readOnly: true
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      _Dog.zz_sumdoc        as zz_sumdoc,
      @ObjectModel.readOnly: true
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      _Dog.zz_waers_pay     as zz_waers_pay,
      @ObjectModel.readOnly: true
      @ObjectModel.enabled: #('EXTERNAL_CALCULATION')
      @ObjectModel.mandatory: #('EXTERNAL_CALCULATION')
      _Dog.zz_regnum_wd     as zz_regnum_wd,

      @ObjectModel.readOnly: true
      execIsHidden,
      //@ObjectModel.readOnly: true
      regIsHidden,

      _BankVH,
      _DogVH,
      _DogTypeVH,
      _DogSubtypeVH,
      _BukrsVH,
      _DogStatusVH,
      _PernrVH,
//      _DogRegistrarVH,
//      _DogExecutorVH,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _DogPartner,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _DogBank,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _DogValExec
} 
 