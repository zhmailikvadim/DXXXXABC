@AbapCatalog.sqlViewName: 'ZHRICANDIDLANG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Инностранные языки'

@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHR_LANGUAGE',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
   writeDraftPersistence: 'ZHR_LANGUAGED'
}

define view ZHR_I_CANDIDATE_LANGUAGE
  as select from zhr_language
  association [1..1] to zhr_i_candidateheader as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
  association [0..1] to ZHR_I_LEVEL_LANG_VH   as _EducLanguVH     on $projection.level_name = _EducLanguVH.Description
  association [0..1] to ZHR_I_NAME_LANGU      as _NameLanguVH     on $projection.name_language = _NameLanguVH.Description
{
  key uuid,
      uuid_candidate,
      name_language,
      //@ObjectModel.foreignKey.association: '_EducLanguVH'
      //@ObjectModel.readOnly: true
      description_long,      
      prof_level,
      lang_id,
      level_name,


      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader,
      _EducLanguVH,
      _NameLanguVH
} 
 