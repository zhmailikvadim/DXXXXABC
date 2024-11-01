@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AbapCatalog.sqlViewName: 'ZHRCCANDIDATEHEA'

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Person Header Consumption'

@OData.publish: true


@ObjectModel.compositionRoot: true
@ObjectModel.createEnabled: true
@ObjectModel.deleteEnabled: true
@ObjectModel.draftEnabled: true
@ObjectModel.modelCategory: #BUSINESS_OBJECT
@ObjectModel.representativeKey: 'uuid'
@ObjectModel.semanticKey: [ 'uuid' ]
@ObjectModel.transactionalProcessingDelegated: true
@ObjectModel.updateEnabled: true

@VDM.viewType: #CONSUMPTION

define view ZHR_C_CANDIDATEHEADER
  as select from zhr_i_candidateheader

  association [0..*] to ZHR_C_CANDIDATE_EDUCATION    as _CandidateEducation on $projection.uuid = _CandidateEducation.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_SEMINAR      as _CandidateSeminar   on $projection.uuid = _CandidateSeminar.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_LANGUAGE     as _CandidateLanguage  on $projection.uuid = _CandidateLanguage.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_PROFRECOM    as _CandidateProfRecom on $projection.uuid = _CandidateProfRecom.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_LAST_WORK    as _CandidateLastWork  on $projection.uuid = _CandidateLastWork.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_RELATIVES    as _CandidateRelat     on $projection.uuid = _CandidateRelat.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_FAMILY       as _CandidateFamily    on $projection.uuid = _CandidateFamily.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_DESIRED_PROF as _CandidateDesProf   on $projection.uuid = _CandidateDesProf.uuid_candidate
  association [0..*] to zhr_c_recruitment_log        as _RecruitmentLog     on $projection.uuid = _RecruitmentLog.uuid_candidate

{
  key uuid,
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

      @ObjectModel.mandatory: true
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
      landx,
      state,
      state_name,
      ort01,

      num01_email,

      num02_phone1,

      @ObjectModel.mandatory: true
      num02_phone2,

      num02_phone3,
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
      about_you,
      has_errors,
      is_run_registration,

      @ObjectModel.mandatory: true
      family_stat_id,

      education_type,

      @ObjectModel.mandatory: true
      educ_type_numc,

      factory_numc,
      factory_name,
      comp_level,
      comp_programs,
      cand_professional,
      work_condition,
      work_condition_id,
      business_trip,
            business_trip_id,
                  business_trip_sever,
      business_trip_sever_id,
      business_trip_check,

      academic_degree,
      academic_degree_id,
      tick_tractor,
      type_of_contract,
      wc_vahta,
      wc_flexsched,
      wc_housecompens,
      wc_tripabroad,
      wc_triprb,
      wc_forwhile,
      wc_fullday,
      wc_not_fullday,
      wc_parttimenot,
      wc_changeschedule,
      wc_remotework,
      wc_remote_combine_work,
      wc_remote_traveling_work,
      drivcat_a,
      drivcat_am,
      drivcat_b,
      drivcat_be,
      drivcat_c,
      drivcat_ce,
      drivcat_d,
      drivcat_de,
      drivcat_f,
      drivcat_i,
      tractcat_a,
      tractcat_b,
      tractcat_c,
      tractcat_d,
      tractcat_e,
      tractcat_f,


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


      useralias,


      password,


      zhr_user,


      zsap_user,

      @ObjectModel.readOnly: true
      @Semantics.user.createdBy: true
      created_user,

      @ObjectModel.readOnly: true
      created_data,

      @ObjectModel.readOnly: true
      created_time,

      @ObjectModel.readOnly: true
      @Semantics.systemDate.createdAt: true
      created_tmstmp,

      @ObjectModel.readOnly: true
      @Semantics.user.lastChangedBy: true
      changed_user,

      @ObjectModel.readOnly: true
      changed_data,

      @ObjectModel.readOnly: true
      changed_time,

      @ObjectModel.readOnly: true
      @Semantics.systemDate.lastChangedAt: true
      changed_tmstmp,

      /* Associations */
      @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
      _CandidateEducation,

      @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
      _CandidateSeminar,

      @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
      _CandidateLanguage,

      @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
      _CandidateProfRecom,

      @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
      _CandidateLastWork,

      @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
      _CandidateRelat,

      @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
      _CandidateFamily,

      @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
      _RecruitmentLog,

      @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
      _CandidateDesProf,

      _ComputerLevelVH,
      _EducTypeVH,
      _FactoryVH,
      _FamilyStatVH,
      _BusinTripVH,
      _CountryVH,
      _RegionVH,
      _CountryFVH,
      _RegionFVH,
      _RelocVH,
      _DegreeVH,
      _SeverVH,
      _ContractVH
} 
 