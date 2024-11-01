@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Desired profession'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZHR_I_DESIRED_PROFESSION_RAP
  as select from zhr_desired_prof
  association to parent ZHR_I_CANDIDATEHEADER_RAP  as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
 // association [0..1] to ZHR_I_DESIRED_PROFES_VH as _DesiredProfVH   on $projection.name_profess = _DesiredProfVH.stext

{

  key  uuid           as uuid,
       uuid_candidate as uuid_candidate,
       name_profess   as name_profess,
       id_profess     as id_profess,
       comment_prof   as comment_prof,
       ready_study    as ready_study,
      
       _CandidateHeader
   //    _DesiredProfVH
} 
 