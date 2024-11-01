@AbapCatalog.sqlViewName: 'ZMMCDOGPART'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Реквезиты контрагента-нерез. по договору'
@Metadata.allowExtensions: true

@UI.presentationVariant: [{id: ''}]


@VDM.viewType: #CONSUMPTION

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    //writeActivePersistence: 'ZMM_DOG_PARTNER',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
    //draftEnabled: true
   // writeDraftPersistence: 'ZMM_DOG_PARTNERD'
}

define view ZMM_C_DOG_PARTNER
  as select from ZMM_I_DOG_PARTNER
  association [0..1] to ZMM_B_DOG_PARTNER as _Partner on $projection.partner = _Partner.partner
  association [1..1] to ZMM_C_DOG_VAL_N   as _DogVal  on $projection.uuid_dog = _DogVal.uuid
{
  key uuid,
      uuid_dog,
//      @UI.hidden: true
//      @ObjectModel.readOnly: true
      typen,
//      dtypen,
      @ObjectModel.mandatory: true  
      partner,
      @ObjectModel.mandatory: true  
      zz_nerez_stn,
      znerez_ei,

      @ObjectModel.readOnly: true
      _Partner.name     as name,
      @ObjectModel.readOnly: true
      _Partner.bu_sort1 as unp,
      @ObjectModel.readOnly: true
      _Partner.country  as country,

//      @ObjectModel.readOnly: true
//      _DogVal.typen,

      _PartnerVH,
      _DogPartStVH,
      _DogPartIeVH,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _DogVal
} 
 