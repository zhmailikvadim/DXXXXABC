@AbapCatalog.sqlViewName: 'ZHRCCANDIDATEHea'
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

define view ZHR_C_CANDIDATEHEADER
  as select from zhr_i_candidateheader
  association [0..*] to ZHR_C_CANDIDATE_EDUCATION as _CandidateEducation on $projection.uuid = _CandidateEducation.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_SEMINAR   as _CandidateSeminar   on $projection.uuid = _CandidateSeminar.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_LANGUAGE  as _CandidateLanguage  on $projection.uuid = _CandidateLanguage.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_PROFRECOM as _CandidateProfRecom on $projection.uuid = _CandidateProfRecom.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_LAST_WORK as _CandidateLastWork  on $projection.uuid = _CandidateLastWork.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_RELATIVES as _CandidateRelat     on $projection.uuid = _CandidateRelat.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_FAMILY    as _CandidateFamily    on $projection.uuid = _CandidateFamily.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_DRIVER    as _CandidateDriver    on $projection.uuid = _CandidateDriver.uuid_candidate
  association [0..*] to ZHR_C_DESIRED_PROFESSION  as _CandidateDesired   on $projection.uuid = _CandidateDesired.uuid_candidate
  association [0..*] to zhr_c_recruitment_log     as _RecruitmentLog     on $projection.uuid = _RecruitmentLog.uuid_candidate

{
  key uuid,
      @ObjectModel.readOnly: true
      pernr,
      subty,
      objps,
      sprps,
      endda,
      begda,
      seqnr,
      aedtm,
      uname,
      histo,
      itxex,
      refex,
      ordex,
      itbld,
      preas,
      flag1,
      flag2,
      flag3,
      flag4,
      rese1,
      rese2,
      grpvl,
      inits,
      @ObjectModel.mandatory: true
      nachn,
      name2,
      @ObjectModel.mandatory: true
      nach2,
      @ObjectModel.mandatory: true
      vorna,
      cname,
      titel,
      titl2,
      namzu,
      vorsw,
      vors2,
      rufnm,
      midnm,
      knznm,
      anred,
      gesch,
      gbdat,
      gblnd,
      gbdep,
      gbort,
      natio,
      nati2,
      nati3,
      sprsl,
      konfe,
      famst,
      famdt,
      anzkd,
      nacon,
      permo,
      perid,
      gbpas,
      lnamr,
      nabik,
      nabir,
      gbjhr,
      gbmon,
      gbtag,
      nchmc,
      vnamc,
      namz2,
      stras,
      land1,
      //    @Consumption.valueHelp: '_CountryVH'
      //   @ObjectModel.text.element: [ '_CountryVH.Landx50' ]
      landx,
      state,
      state_name,
      ort01,
      @ObjectModel.readOnly: true
      num01_email,
      num02_phone1,
      num02_phone2,
      hsnmr,
      land1f,
      landxf,
      ort01f,
      statef,
      statef_name,
      strasf,
      hsnmrf,
      id_car_category,
      is_car_category,
      is_car_exist,
      is_driver,
      is_arm_force,
      arm_reason,
      min_salary,
      sickness,
      detail_sickness,
      relatives_bn,
      admin_respons,
      crimin_respons,
      admin_respons_text,
      crimin_respons_text,
      hobbies,
      has_errors,
      is_run_registration,
      @Consumption.valueHelp: '_FamilyStatVHVH'
      @ObjectModel.text.element: [ '_FamilyStatVH.description' ]
      family_stat_id,
      education_type,
      educ_type_numc,
      comp_level,
      comp_programs,
      cand_professional,
      work_condition,
      // @Consumption.valueHelp: '_CondWorkVH'
      //  @ObjectModel.text.element: [ '_CondWorkVH.Description' ]
      work_condition_id,
      cand_relocate,
      business_trip,
      //   @Consumption.valueHelp: '_BusinTripVH'
      //   @ObjectModel.text.element: [ '_BusinTripVH.Description' ]
      business_trip_id,
      business_trip_check,
      business_trip_sever,


      /* Technical data */
      rsign,
      @ObjectModel.readOnly: true
      relat,
      @ObjectModel.readOnly: true
      istat,
      @ObjectModel.readOnly: true
      priox,
      @ObjectModel.readOnly: true
      varyf,
      @ObjectModel.readOnly: true
      otype,
      @ObjectModel.readOnly: true
      objid,
      @ObjectModel.readOnly: true
      plvar,
      @ObjectModel.readOnly: true
      created_user_reg,
      @ObjectModel.readOnly: true
      created_data_reg,
      @ObjectModel.readOnly: true
      changed_user_reg,
      @ObjectModel.readOnly: true
      changed_data_reg,
      @ObjectModel.readOnly: true
      created_time_reg,
      @ObjectModel.readOnly: true
      changed_time_reg,
      @ObjectModel.readOnly: true
      changed_tmstmp_reg,
      @ObjectModel.readOnly: true
      useralias,
      @ObjectModel.readOnly: true
      password,
      @ObjectModel.readOnly: true
      zhr_user,
      @ObjectModel.readOnly: true
      zsap_user,
      @Semantics.user.createdBy: true
      @ObjectModel.readOnly: true
      created_user,
      @ObjectModel.readOnly: true
      created_data,
      @ObjectModel.readOnly: true
      created_time,
      @Semantics.systemDate.createdAt:true
      @ObjectModel.readOnly: true
      created_tmstmp,
      @Semantics.user.lastChangedBy: true
      @ObjectModel.readOnly: true
      changed_user,
      @ObjectModel.readOnly: true
      changed_data,
      @ObjectModel.readOnly: true
      changed_time,
      @Semantics.systemDate.lastChangedAt:true
      @ObjectModel.readOnly: true
      changed_tmstmp,

      /* Associations */
      @ObjectModel.association: {
       type: [ #TO_COMPOSITION_CHILD ]}
      _CandidateEducation,
      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _CandidateSeminar,
      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _CandidateLanguage,
      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _CandidateProfRecom,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _CandidateLastWork,
      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _CandidateRelat,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _CandidateFamily,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _RecruitmentLog,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _CandidateDriver,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_CHILD ]}
      _CandidateDesired,

      _ComputerLevelVH,
      _EducTypeVH,
      _FamilyStatVH,
      _CondWorkVH,
      _BusinTripVH,
      _CountryVH,
      _RegionVH,
      _CountryFVH,
      _RegionFVH

      //  _CategoryVH,


} 
 