@AbapCatalog.sqlViewName: 'ZHRCRECRUITLOG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Recruitment Log'

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    writeActivePersistence: 'ZHR_CAND_SEM',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
   //writeDraftPersistence: 'ZHR_RECRUIT_LOGD'
}

define view zhr_c_recruitment_log
  as select from zhr_i_recruitment_log
  association [1..1] to zhr_c_candidateheader as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
{
  key uuid,
      uuid_candidate,
      type,
      id,
      znumber,
      message,
      log_no,
      log_msg_no,
      message_v1,
      message_v2,
      message_v3,
      message_v4,
      zparameter,
      description,
      active,
      /* Associations */
      /* Associations */
      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader
} 
 