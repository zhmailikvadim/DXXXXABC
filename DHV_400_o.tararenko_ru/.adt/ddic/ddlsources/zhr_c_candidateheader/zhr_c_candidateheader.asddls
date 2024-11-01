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
  as select from ZHR_I_CANDIDATEHEADER
  association [0..*] to ZHR_C_CANDIDATE_EDUCATION as _CandidateEducation on $projection.uuid = _CandidateEducation.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_SEMINAR   as _CandidateSeminar   on $projection.uuid = _CandidateSeminar.uuid_candidate
  association [0..*] to ZHR_C_CANDIDATE_LANGUAGE  as _CandidateLanguage  on $projection.uuid = _CandidateLanguage.uuid_candidate

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
       @Consumption.valueHelp: '_EducTypeVH'
       @ObjectModel.text.element: [ '_EducTypeVH.Description' ]

       //  @ObjectModel.foreignKey.association: '_EducTypeVH'
       //   @ObjectModel.text.association: '_EducTypeVH'


       educ_type_numc as educ_type_numc,

       @Consumption.valueHelp: '_ComputerLevelVH'
       @ObjectModel.text.element: [ '_ComputerLevelVH.Description' ]
       comp_level,
       comp_programs,
       @ObjectModel.association: {
        type: [ #TO_COMPOSITION_CHILD ]}
       _CandidateEducation,
       @ObjectModel.association: {
       type: [ #TO_COMPOSITION_CHILD ]}
       _CandidateSeminar,
       @ObjectModel.association: {
       type: [ #TO_COMPOSITION_CHILD ]}
       _CandidateLanguage,
       _ComputerLevelVH,
       _EducTypeVH

} 
 