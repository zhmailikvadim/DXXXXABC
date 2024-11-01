@AbapCatalog.sqlViewName: 'ZHRICANDFAM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Семья'

@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHR_FAMILY',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
   writeDraftPersistence: 'ZHR_FAMD'
}

define view ZHR_I_CANDIDATE_FAMILY
  as select from zhr_family
  association [1..1] to zhr_i_candidateheader as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
  association [0..1] to ZHR_I_TYPE_RELAT_VH   as _TypeFamVH     on $projection.relat_degree = _TypeFamVH.Description
{
  key uuid,
      uuid_candidate,
      fio,
      grdate,
      telnr,
      job,
      nachn,
      vorna,
      nach2,
      relat_degree as relat_degree,
      relat_id     as relat_id,
      

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader,
      _TypeFamVH
} 
 