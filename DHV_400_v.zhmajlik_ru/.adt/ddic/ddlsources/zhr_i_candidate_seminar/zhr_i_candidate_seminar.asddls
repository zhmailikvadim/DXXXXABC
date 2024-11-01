@AbapCatalog.sqlViewName: 'ZHRICANDIDSEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Семинары, курсы'

@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHR_CAND_SEM',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
   writeDraftPersistence: 'ZHR_CAND_SEMD'
}


define view ZHR_I_CANDIDATE_SEMINAR
  as select from zhr_cand_sem
  association [1..1] to zhr_i_candidateheader  as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
  association [0..1] to ZHR_I_TYPEEDUCATION_VH as _TypeEducationVH on $projection.ftext = _TypeEducationVH.name


{
  key uuid,
      uuid_candidate,
      begda           as begda,
      endda_sem       as endda_sem,
      anzkl           as anzkl,
      name            as name,
      ftext           as ftext,
      academic_degree as academic_degree,
      name_univer     as name_univer,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader,
      _TypeEducationVH
} 
 