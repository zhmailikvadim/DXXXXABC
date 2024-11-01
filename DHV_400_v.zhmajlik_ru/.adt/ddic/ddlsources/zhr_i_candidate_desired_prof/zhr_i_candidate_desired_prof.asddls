@AbapCatalog.sqlViewName: 'ZHRIDESIREPROF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Желаемая профессия'

@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHR_CANDESPRD',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
   writeDraftPersistence: 'ZHR_CANDESPRD'
   
}

define view ZHR_I_CANDIDATE_DESIRED_PROF
  as select from zhr_candespr
  association [1..1] to zhr_i_candidateheader   as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
  association [0..1] to ZHR_I_DESIRED_PROFES_VH as _DesiredProfVH   on $projection.name_profess = _DesiredProfVH.stext

{

  key  uuid           as uuid,
       uuid_candidate as uuid_candidate,
       name_profess   as name_profess,
       id_profess     as id_profess,
       comment_prof   as comment_prof,
       ready_study    as ready_study,
       @ObjectModel.readOnly: true
       cast( 'https://hr.belorusneft.by/application/profession' as abap.char( 255 ) ) as url, 
       @ObjectModel.readOnly: true
       cast( 'Подать заявку на обучение'  as abap.char( 30 ) )  as link_study,
       req_study_added,
       last_changed_at,
       changed_by,
       @ObjectModel.association: {
       type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
       _CandidateHeader,
       _DesiredProfVH
} 
 