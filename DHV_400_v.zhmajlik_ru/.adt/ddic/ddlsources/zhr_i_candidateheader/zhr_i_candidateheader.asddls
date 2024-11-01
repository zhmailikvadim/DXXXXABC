@AbapCatalog.sqlViewName: 'ZHRICandidateHea'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Person Header Master Data'

@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHR_PB0002',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
    draftEnabled: true,
    writeDraftPersistence: 'ZHR_PB0002D'
   //lifecycle.enqueue.expiryBehavior: #RELATIVE_TO_ENQUEUE_START,
   //lifecycle.enqueue.expiryInterval: 'PT60M'
}

define view zhr_i_candidateheader
  as select from zhr_pb0002

  association [0..*] to ZHR_I_CANDIDATE_EDUCATION    as _CandidateEducation          on $projection.uuid = _CandidateEducation.uuid_candidate
  association [0..*] to ZHR_I_CANDIDATE_SEMINAR      as _CandidateSeminar            on $projection.uuid = _CandidateSeminar.uuid_candidate
  association [0..*] to ZHR_I_CANDIDATE_LANGUAGE     as _CandidateLanguage           on $projection.uuid = _CandidateLanguage.uuid_candidate
  association [0..*] to ZHR_I_CANDIDATE_PROFRECOM    as _CandidateProfRecom          on $projection.uuid = _CandidateProfRecom.uuid_candidate
  association [0..*] to ZHR_I_CANDIDATE_LAST_WORK    as _CandidateLastWork           on $projection.uuid = _CandidateLastWork.uuid_candidate
  association [0..*] to ZHR_I_CANDIDATE_RELATIVES    as _CandidateRelat              on $projection.uuid = _CandidateRelat.uuid_candidate
  association [0..*] to ZHR_I_CANDIDATE_FAMILY       as _CandidateFamily             on $projection.uuid = _CandidateFamily.uuid_candidate
  association [0..*] to zhr_i_recruitment_log        as _RecruitmentLog              on $projection.uuid = _RecruitmentLog.uuid_candidate
  association [0..*] to ZHR_I_CANDIDATE_DESIRED_PROF as _CandidateDesProf            on $projection.uuid = _CandidateDesProf.uuid_candidate
  association [0..*] to ZHR_I_CANDIDATE_VACANCIES    as _CandidateVacanc             on $projection.uuid = _CandidateVacanc.uuid_candidate

  // Value Helps
  association [0..1] to ZHR_I_COMPUTER_LEVEL_VH      as _ComputerLevelVH             on $projection.comp_level = _ComputerLevelVH.Id
  association [0..1] to ZHR_I_EDUC_TYPE_VH           as _EducTypeVH                  on $projection.educ_type_numc = _EducTypeVH.ID
  association [0..1] to ZHR_I_DEGREE_VH              as _DegreeVH                    on $projection.academic_degree_id = _DegreeVH.Id
  association [0..1] to ZHR_I_FAMILY_STAT_VH         as _FamilyStatVH                on $projection.family_stat_id = _FamilyStatVH.id
  association [0..1] to ZHR_I_BUSIN_TRIP_VH          as _BusinTripVH                 on $projection.business_trip_id = _BusinTripVH.WorkContract
  association [0..1] to ZHR_I_COUNTRY_VH             as _CountryVH                   on $projection.landx = _CountryVH.Landx50
  association [0..1] to ZHR_I_COUNTRY_VH             as _CountryFVH                  on $projection.landxf = _CountryFVH.Landx50
  association [0..1] to ZHR_I_REGION_VH              as _RegionVH                    on $projection.state_name = _RegionVH.bezei
  association [0..1] to ZHR_I_REGION_VH              as _RegionFVH                   on $projection.statef_name = _RegionFVH.bezei
  association [0..1] to ZHR_I_RELOCATION_VH          as _RelocVH                     on $projection.business_trip = _RelocVH.Id
  association [0..1] to ZHR_I_SEVER_VH               as _SeverVH                     on $projection.business_trip_sever_id = _SeverVH.Id
  association [0..1] to ZHR_I_FACTORY_VH             as _FactoryVH                   on $projection.factory_numc = _FactoryVH.ID
  association [0..1] to ZHR_I_TYPECONTRACT_VH        as _ContractVH                  on $projection.type_of_contract = _ContractVH.work_contract
  association [0..1] to ZHR_I_PREF_COM_WAY_VH        as _PrferredCommunicationWay2VH on $projection.num02_phone2_wid = _PrferredCommunicationWay2VH.Id
  association [0..1] to ZHR_I_PREF_COM_WAY_VH        as _PrferredCommunicationWay3VH on $projection.num02_phone3_wid = _PrferredCommunicationWay3VH.Id

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
      landx,
      land1,
      state,
      state_name,
      ort01,
      num01_email,
      num02_phone1,
      @ObjectModel.mandatory: true
      num02_phone2,
      num02_phone3,
      num02_phone2_way,
      num02_phone2_wid,
      num02_phone3_way,
      num02_phone3_wid,
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
      useralias,
      password,
      cand_professional,
      work_condition,
      work_condition_id,
      @ObjectModel.mandatory: true
      business_trip,
      business_trip_id,
      business_trip_check,
      business_trip_sever,
      @ObjectModel.mandatory: true
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

      @Semantics.systemDate.createdAt: true
      created_tmstmp,

      @Semantics.user.lastChangedBy: true
      changed_user,

      changed_data,
      changed_time,

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

      @ObjectModel.association.type: [ #TO_COMPOSITION_CHILD ]
      _CandidateVacanc,

      _ComputerLevelVH,
      _EducTypeVH,
      _FactoryVH,
      _FamilyStatVH,
      //  _CondWorkVH,
      _BusinTripVH,
      _CountryVH,
      _RegionVH,
      _CountryFVH,
      _RegionFVH,
      _RelocVH,
      _DegreeVH,
      _SeverVH,
      _ContractVH,
      _PrferredCommunicationWay2VH,
      _PrferredCommunicationWay3VH

      //   _CategoryVH
} 
 