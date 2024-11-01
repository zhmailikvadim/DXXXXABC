@AbapCatalog.sqlViewName: 'ZHRCCANDIDATHRG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Person Header Consumption'
@Metadata.allowExtensions: true

@VDM.viewType: #CONSUMPTION


@OData.publish: true

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
    draftEnabled: true
}

define view ZHR_C_CANDIDATE_REGS
  as select from zhr_i_candidateheader
  association [0..*] to zhr_c_recruitment_log as _RecruitmentLog on $projection.uuid = _RecruitmentLog.uuid_candidate

{
  key uuid,
      vorna,
      nachn,
      nach2,
      pernr,
      useralias,
      password,
      num01_email,
      factory_name,
      factory_numc,
      is_run_registration,
      zhr_user,
      @Semantics.user.createdBy: true
      created_user,
      created_data,
      created_time,
      @Semantics.systemDate.createdAt:true
      created_tmstmp,
      @Semantics.user.lastChangedBy: true
      changed_user,
      changed_data,
      changed_time,
      @Semantics.systemDate.lastChangedAt:true
      changed_tmstmp,
      zsap_user,
      has_errors,

      _FactoryVH,
      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _RecruitmentLog

} 
 