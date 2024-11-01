@AbapCatalog.sqlViewName: 'ZHRCDESIRPROFC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption Желаемая профессия'

@Metadata.allowExtensions: true


@VDM.viewType: #CONSUMPTION


@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    writeActivePersistence: 'ZHR_CANDESPR',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZHR_C_CANDIDATE_DESIRED_PROF
  as select from ZHR_I_CANDIDATE_DESIRED_PROF
  association [1..1] to ZHR_C_CANDIDATEHEADER as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
{
  key uuid,
      uuid_candidate,
      name_profess,

      id_profess,
      comment_prof,
      ready_study,
      link_study,
      url,
      req_study_added,
      last_changed_at,
      changed_by,

      /* Associations */
      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader,
      _DesiredProfVH

} 
 