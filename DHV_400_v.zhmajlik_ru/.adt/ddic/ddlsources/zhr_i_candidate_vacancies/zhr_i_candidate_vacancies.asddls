@AbapCatalog.sqlViewName: 'ZHRICANDVAC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Вакансии'

@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    //transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHR_VACANCIES',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
   writeDraftPersistence: 'ZHR_VACANCIESD'
}
define view ZHR_I_CANDIDATE_VACANCIES
  as select from zhr_vacancies
  association [1..1] to zhr_i_candidateheader as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
  association [0..1] to ZHR_I_VACANC_VH       as _TypeVacancVH    on $projection.name_vacans = _TypeVacancVH.NameVacanc
{
  key uuid           as uuid,
      uuid_candidate as uuid_candidate,
      name_vacans    as name_vacans,
      address        as address,
      enterprise     as enterprise,
      name_id        as name_id,
      city           as City,
      orgname        as orgname,
      hot_job        as hot_job,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader,
      _TypeVacancVH
} 
 