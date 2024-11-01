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
  //association [0..*] to zhr_c_recruitment_log as _RecruitmentLog on $projection.uuid = _RecruitmentLog.uuid_candidate

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
      nachn,
      name2,
      nach2,
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
      state,
      ort01,
      num01_email,
      num02_phone1,
      num02_phone2,
      hsnmr,
      ort01f,
      statef,
      strasf,
      hsnmrf,
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
      is_run_registration,
      family_stat_id,
      otype,
      objid,
      plvar,
      rsign,
      relat,
      istat,
      priox,
      varyf,
      useralias,
      password,
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
      education_type,
      educ_type_numc,
      factory_numc,
      factory_name,
      comp_level,
      comp_programs,
      zsap_user,
      has_errors,

      _ComputerLevelVH,
      _EducTypeVH,
      _FactoryVH,
      _FamilyStatVH

//      _RecruitmentLog

} 
 