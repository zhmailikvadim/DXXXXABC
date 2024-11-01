@AbapCatalog.sqlViewName: 'ZHRICANDTRACTOR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Категория удостоверения тракториста'

//@VDM: {
//    viewType: #TRANSACTIONAL
//}
//
//@ObjectModel:{
//    modelCategory : #BUSINESS_OBJECT,
//    transactionalProcessingEnabled: true,
//    writeActivePersistence: 'ZHR_TRAC_CATEGOR',
//    semanticKey: ['uuid'],
//    representativeKey: 'uuid',
//    createEnabled: true,
//    updateEnabled: true,
//    deleteEnabled: true,
//   writeDraftPersistence: 'ZHR_TRACCATEGOR'
//}
define view ZHR_I_CANDIDATE_TRACTOR
  as select from zhr_trac_categor
  association [1..1] to zhr_i_candidateheader as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
  association [0..1] to ZHR_I_CANDIDATE_TRACTOR_VH    as _TractorVH     on $projection.name_category = _TractorVH.name
  
  
{

  key uuid           as uuid,
      uuid_candidate as uuid_candidate,
      id_category    as id_category,
      name_category  as name_category,

//      @ObjectModel.association: {
//        type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader,
      _TractorVH
} 
 