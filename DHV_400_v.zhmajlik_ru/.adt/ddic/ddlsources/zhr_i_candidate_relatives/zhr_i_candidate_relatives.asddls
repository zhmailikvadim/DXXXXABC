@AbapCatalog.sqlViewName: 'ZHRICANDRELAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Родственники'

@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHR_RELATIVES',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
   writeDraftPersistence: 'ZHR_RELATD'
}

define view ZHR_I_CANDIDATE_RELATIVES
  as select from zhr_relatives
  association [1..1] to zhr_i_candidateheader as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
  association [0..1] to ZHR_I_TYPE_RELAT_VH   as _TypeRelatVH     on $projection.relat_degree = _TypeRelatVH.Description
  association [0..1] to ZHR_I_ENTERPRICE_VH   as _EnterPriceVH     on $projection.relat_work = _EnterPriceVH.orgname
{
  key uuid,
      uuid_candidate,
      relat_name,
      relat_otch,
      relat_id,
      relat_degree,
      relat_fio,
      relat_work,
      profession,

      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader,
      _TypeRelatVH,
      _EnterPriceVH
} 
 