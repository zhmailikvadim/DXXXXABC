@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Person Header Master Data'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}


define root view entity ZHR_I_CANDIDATEHEADER_RAP
  as select from zhr_pb0002
  composition [0..*] of ZHR_I_CANDIDATE_EDUCATION_RAP as _CandidateEducation
  composition [0..*] of ZHR_I_CANDIDATE_SEMINAR_RAP   as _CandidateSeminar
  composition [0..*] of ZHR_I_CANDIDATE_LANGUAGE_RAP  as _CandidateLanguage
  composition [0..*] of ZHR_I_CANDIDATE_LAST_WORK_RAP as _CandidateLastWork
  composition [0..*] of ZHR_I_CANDIDATE_PROFRECOM_RAP as _CandidateProfRecom
 // composition [0..*] of ZHR_I_DESIRED_PROFESSION_RAP  as _CandidateDesiredProf
  composition [0..*] of ZHR_I_CANDIDATE_DESIRED_PR_RAP  as _CandidateDesiredProf
  composition [0..*] of ZHR_I_CANDIDATE_RELATIVES_RAP as _CandidateRelatives
  composition [0..*] of ZHR_I_CANDIDATE_FAMILY_RAP    as _CandidateFamily

  //  composition [0..*] of ZHR_I_CANDIDATE_RELATIVES as _CandidateRelat     on $projection.uuid = _CandidateRelat.uuid_candidate
  //  composition [0..*] of ZHR_I_CANDIDATE_FAMILY    as _CandidateFamily    on $projection.uuid = _CandidateFamily.uuid_candidate
  //  composition [0..*] of zhr_i_recruitment_log     as _RecruitmentLog     on $projection.uuid = _RecruitmentLog.uuid_candidate
  //association [0..*] to ZHR_I_CANDIDATE_DRIVER    as _CandidateDriver    on $projection.uuid = _CandidateDriver.uuid_candidate
  // association [0..*] to ZHR_I_DESIRED_PROFESSION  as _CandidateDesired   on $projection.uuid = _CandidateDesired.uuid_candidate
  //association [0..*] to ZHR_I_WORKING_CONDITIONS  as _CandidateWorkCond  on $projection.uuid = _CandidateWorkCond.uuid_candidate
  // association [0..*] to ZHR_I_CANDIDATE_TRACTOR   as _CandidateTractor   on $projection.uuid = _CandidateTractor.uuid_candidate

  //Value Helps
  association [0..1] to ZHR_I_COMPUTER_LEVEL_VH_RAP   as _ComputerLevelVHR on $projection.comp_level = _ComputerLevelVHR.Id
  //  association [0..1] to ZHR_I_EDUC_TYPE_VH            as _EducTypeVH      on $projection.educ_type_numc = _EducTypeVH.ID
  association [0..1] to ZHR_I_EDUC_TYPE_VH_RAP        as _EducTypeVHR      on $projection.educ_type_numc = _EducTypeVHR.ID
  association [0..1] to ZHR_I_DEGREE_VH_RAP           as _DegreeVHR        on $projection.academic_degree_id = _DegreeVHR.Id
  association [0..1] to ZHR_I_FAMILY_STAT_VH          as _FamilyStatVH     on $projection.family_stat_id = _FamilyStatVH.id
  //  association [0..1] to ZHR_I_COND_WORK_VH        as _CondWorkVH         on $projection.work_condition_id = _CondWorkVH.EmploymentFract
  association [0..1] to ZHR_I_BUSIN_TRIP_VH           as _BusinTripVH      on $projection.business_trip_id = _BusinTripVH.WorkContract
  association [0..1] to ZHR_I_COUNTRY_VH              as _CountryVH        on $projection.landx = _CountryVH.Landx50
  association [0..1] to ZHR_I_COUNTRY_VH              as _CountryFVH       on $projection.landxf = _CountryFVH.Landx50
  association [0..1] to ZHR_I_REGION_VH               as _RegionVH         on $projection.state_name = _RegionVH.bezei
  association [0..1] to ZHR_I_REGION_VH               as _RegionFVH        on $projection.statef_name = _RegionFVH.bezei
  association [0..1] to ZHR_I_RELOCATION_VH           as _RelocVH          on $projection.business_trip = _RelocVH.Id
  association [0..1] to ZHR_I_SEVER_VH                as _SeverVH          on $projection.business_trip_sever_id = _SeverVH.Id
  association [0..1] to ZHR_I_FACTORY_VH              as _FactoryVH        on $projection.factory_numc = _FactoryVH.ID
  association [0..1] to ZHR_I_TYPECONTRACT_VH         as _ContractVH       on $projection.type_of_contract = _ContractVH.work_contract








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
      landx,
      land1,
      state,
      state_name,
      ort01,
      num01_email,
      num02_phone1,
      @ObjectModel.mandatory: true
      num02_phone2,
      hsnmr,
      land1f,
      @ObjectModel.mandatory: true
      landxf,
      @ObjectModel.mandatory: true
      ort01f,
      statef,
      @ObjectModel.mandatory: true
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
      //@Consumption.valueHelp: '_FamilyStatVH'
      //@ObjectModel.text.element: [ '_FamilyStatVH.description' ]
      @ObjectModel.mandatory: true
      family_stat_id,
      education_type,
      @ObjectModel.mandatory: true
      educ_type_numc,
      factory_numc,
      factory_name,
      comp_level,
      comp_programs,
      useralias,
      password,
      cand_professional,
      work_condition,
      work_condition_id,
      cand_relocate,
      business_trip,
      business_trip_id,
      business_trip_check,
      business_trip_sever,
      business_trip_sever_id,
      academic_degree,
      academic_degree_id,
      tick_tractor,
      type_of_contract,
      wc_vahta,
      wc_flexsched,
      wc_retraining,
      wc_housecompens,
      wc_tripabroad,
      wc_triprb,
      wc_forwhile,
      wc_fullday,
      wc_parttimenot,
      wc_lastsever,
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
      otype,
      objid,
      plvar,
      rsign,
      relat,
      istat,
      priox,
      varyf,
      created_user_reg,
      created_data_reg,
      changed_user_reg,
      changed_data_reg,
      created_time_reg,
      changed_time_reg,
      changed_tmstmp_reg,
      zhr_user,
      zsap_user,
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
      last_changed_at,
      changed_by,

      /* Associations */

      _CandidateEducation,
      _CandidateSeminar,
      _CandidateLanguage,
      _CandidateLastWork,
      _CandidateProfRecom,
      _CandidateDesiredProf,
      _CandidateRelatives,
      _CandidateFamily,


      //      _CandidateSeminar,
      //
      //      _CandidateLanguage,
      //
      //      _CandidateProfRecom,
      //
      //
      //      _CandidateLastWork,
      //
      //      _CandidateRelat,
      //
      //      _CandidateFamily,
      //
      //      _RecruitmentLog,
      //
      //      _CandidateDesired,

      //      _CandidateWorkCond,

      //      @ObjectModel.association: {
      //      type: [ #TO_COMPOSITION_CHILD ]}
      //      _CandidateTractor,



      _ComputerLevelVHR,
      _EducTypeVHR,
      _DegreeVHR,
      //  _EducTypeVH,
      _FactoryVH,
      _FamilyStatVH,
      //  _CondWorkVH,
      _BusinTripVH,
      _CountryVH,
      _RegionVH,
      _CountryFVH,
      _RegionFVH,
      _RelocVH,
      // _DegreeVH,
      _SeverVH,
      _ContractVH

      //   _CategoryVH

}
