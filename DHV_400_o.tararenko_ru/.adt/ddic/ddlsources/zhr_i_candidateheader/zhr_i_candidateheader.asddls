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
  //  lifecycle.enqueue.expiryBehavior: #RELATIVE_TO_LAST_CHANGE
}

define view ZHR_I_CANDIDATEHEADER
  as select from zhr_pb0002
  association [0..*] to ZHR_I_CANDIDATE_EDUCATION as _CandidateEducation on  $projection.uuid = _CandidateEducation.uuid_candidate
  association [0..*] to ZHR_I_CANDIDATE_SEMINAR   as _CandidateSeminar   on  $projection.uuid = _CandidateSeminar.uuid_candidate
  association [0..*] to ZHR_I_CANDIDATE_LANGUAGE   as _CandidateLanguage on  $projection.uuid = _CandidateLanguage.uuid_candidate
  //Value Helps
  association [0..1] to ZHR_I_COMPUTER_LEVEL_VH   as _ComputerLevelVH    on  $projection.comp_level = _ComputerLevelVH.Id
  association [0..1] to ZHR_I_EDUC_TYPE_VH        as _EducTypeVH         on  $projection.educ_type_numc = _EducTypeVH.ID
                                                                         and _EducTypeVH.langu          = 'R'
{
  key  uuid,
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
       education_type as education_type,
       @ObjectModel.foreignKey.association: '_EducTypeVH'
       educ_type_numc as educ_type_numc,

       @ObjectModel.foreignKey.association: '_ComputerLevelVH'
       comp_level,
       comp_programs,
       @ObjectModel.association: {
          type: [ #TO_COMPOSITION_CHILD ]
       }
       _CandidateEducation,
       @ObjectModel.association: {
       type: [ #TO_COMPOSITION_CHILD ]
       }
       _CandidateSeminar,
       
       @ObjectModel.association: {
       type: [ #TO_COMPOSITION_CHILD ]
       }
       _CandidateLanguage,

       _ComputerLevelVH,
       _EducTypeVH
} 
 