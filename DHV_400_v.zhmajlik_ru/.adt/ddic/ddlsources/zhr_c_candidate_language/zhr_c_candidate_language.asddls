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
  as select from ZHR_I_CANDIDATE_LANGUAGE as CandidateLanguage

  association [1..1] to ZHR_C_CANDIDATEHEADER as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid

{
  key uuid,

      uuid_candidate,
      name_language,
      // @ObjectModel.text.element: [ '_NameLanguVH.Description' ]
      lang_id,
      level_name,


      //  @ObjectModel.readOnly: true
      //  _NameLanguVH.Description as NameLanguDescription,
      // @Consumption.valueHelp: '_EducLanguVH'

      //  @ObjectModel.text.element: [ '_EducLanguVH.Description' ]
      prof_level,

//      @ObjectModel.readOnly: true
//      decription_long,
      @ObjectModel.readOnly: true
      description_long,

      /* Associations */
      @ObjectModel.association.type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]
      _CandidateHeader,

      _EducLanguVH,
      _NameLanguVH
} 
 