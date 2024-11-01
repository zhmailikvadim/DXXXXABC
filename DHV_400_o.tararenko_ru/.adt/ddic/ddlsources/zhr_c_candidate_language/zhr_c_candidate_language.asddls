@AbapCatalog.sqlViewName: 'ZHRCCANDIDLANG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Инностранные языки'

@Metadata.allowExtensions: true


@VDM.viewType: #CONSUMPTION

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    writeActivePersistence: 'ZHR_LANGUAGE',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
 //   writeDraftPersistence: 'ZHR_PB0022D'
}

define view ZHR_C_CANDIDATE_LANGUAGE
  as select from ZHR_I_CANDIDATE_LANGUAGE
  association [1..1] to ZHR_C_CANDIDATEHEADER as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
{
  key uuid,
      uuid_candidate,
      name_language as NameLanguage,
      prof_level    as ProfLevel,
      /* Associations */
      @ObjectModel.association: {
       type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader
} 
 