@AbapCatalog.sqlViewName: 'ZHRICANDLASTWORK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Прешествующее место работы'
@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHR_LAST_WORK',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
   writeDraftPersistence: 'ZHR_LASTWORKD'
}





define view ZHR_I_CANDIDATE_LAST_WORK
  as select from zhr_last_work
  association [1..1] to zhr_i_candidateheader as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
{
  key uuid,
      uuid_candidate,
      work_period    as work_period,
      work_period_to as work_period_to,
      name_org       as name_org,
      name_job       as name_job,
      last_head      as last_head,
      oruba          as oruba,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader
} 
 