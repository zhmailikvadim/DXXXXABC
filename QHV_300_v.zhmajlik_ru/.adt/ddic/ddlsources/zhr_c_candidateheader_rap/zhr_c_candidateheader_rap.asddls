@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true


define root view entity ZHR_C_CANDIDATEHEADER_RAP
  as projection on ZHR_I_CANDIDATEHEADER_RAP
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

  //    @ObjectModel.mandatory: true
      nachn,

      name2,
      nach2,

 //     @ObjectModel.mandatory: true
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

     // @ObjectModel.mandatory: true
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

      @ObjectModel.readOnly: true
      num01_email,

      num02_phone1,

    //  @ObjectModel.mandatory: true
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

  //    @ObjectModel.mandatory: true
      family_stat_id,

      education_type,

     // @ObjectModel.mandatory: true
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element:['DescEduc']
      educ_type_numc,
      _EducTypeVHR.Description as DescEduc,

      factory_numc,
      factory_name,
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element:['Descop']
      comp_level,
      _ComputerLevelVHR.Description as Descop,
      comp_programs,
      cand_professional,
      work_condition,
      work_condition_id,
      business_trip,
            business_trip_id,
                  business_trip_sever,
      business_trip_sever_id,
      business_trip_check,

      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element:['Name']
      academic_degree_id,
      _DegreeVHR.Name as Name,
     
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

      @ObjectModel.readOnly: true
      useralias,

      @ObjectModel.readOnly: true
      password,

      @ObjectModel.readOnly: true
      zhr_user,

      @ObjectModel.readOnly: true
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
      _BusinTripVH,
      _CandidateEducation : redirected to composition child ZHR_C_CANDIDATE_EDUCATION_RAP,
      _CandidateSeminar : redirected to composition child ZHR_C_CANDIDATE_SEMINAR_RAP,
      _CandidateLanguage : redirected to composition child ZHR_C_CANDIDATE_LANGUAGE_RAP,
      _CandidateLastWork : redirected to composition child ZHR_C_CANDIDATE_LAST_WORK_RAP,
      _CandidateProfRecom : redirected to composition child ZHR_C_CANDIDATE_PROFRECOM_RAP,
      //_CandidateDesiredProf : redirected to composition child ZHR_C_DESIRED_PROFESSION_RAP,
      _CandidateDesiredProf : redirected to composition child ZHR_C_CANDIDATE_DESIRED_PR_RAP,
      _CandidateRelatives : redirected to composition child ZHR_C_CANDIDATE_RELATIVES_RAP,
      _CandidateFamily : redirected to composition child ZHR_C_CANDIDATE_FAMILY_RAP,
      _CandidateLog : redirected to composition child ZHR_C_RECRUITMENT_LOG_RAP,
      
      _ComputerLevelVHR,
      _ContractVH,
      _CountryFVH,
      _CountryVH,
      _DegreeVHR,
      _EducTypeVHR,
      _FactoryVH,
      _FamilyStatVH,
      _RegionFVH,
      _RegionVH,
      _RelocVH,
      _SeverVH
}
