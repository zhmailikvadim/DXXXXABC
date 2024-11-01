@AbapCatalog.sqlViewName: 'ZHRCCANDILAST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Предшествующее место работы Consumption'

@Metadata.allowExtensions: true

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHR_LAST_WORK',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
  // writeDraftPersistence: 'ZHR_LAST_WORKD'
}



@VDM.viewType: #CONSUMPTION


define view ZHR_C_CANDIDATE_LAST_WORK
  as select from ZHR_I_CANDIDATE_LAST_WORK
  association [1..1] to ZHR_C_CANDIDATEHEADER as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
{
  key uuid,
      uuid_candidate,
      work_period,
      work_period_to,
      name_org,
      name_job,
      last_head,
      oruba,
      /* Associations */
      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
     _CandidateHeader
} 
 