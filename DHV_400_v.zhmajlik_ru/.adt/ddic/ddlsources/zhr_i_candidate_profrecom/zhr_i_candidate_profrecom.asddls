@AbapCatalog.sqlViewName: 'ZHRICANDIDPROFRE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Провессиональные рекомендации'

@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHR_PROF_RECOMEN',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
   writeDraftPersistence: 'ZHR_PROF_RECOMD'
}


define view ZHR_I_CANDIDATE_PROFRECOM
  as select from zhr_prof_recomen
  association [1..1] to zhr_i_candidateheader as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
{

  key uuid,
      uuid_candidate,
      fio        as fio,
      place_work as place_work,
      telnr      as telnr,
     agreement  as agreement,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader
} 
 