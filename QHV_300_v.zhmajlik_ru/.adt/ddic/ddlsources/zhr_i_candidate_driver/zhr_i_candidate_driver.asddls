@AbapCatalog.sqlViewName: 'ZHRICANDDRIVER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Категория Водительских прав'

//@VDM: {
//    viewType: #TRANSACTIONAL
//}
//
//@ObjectModel:{
//    modelCategory : #BUSINESS_OBJECT,
//    transactionalProcessingEnabled: true,
//    writeActivePersistence: 'ZHR_CAR_CATEGORY',
//    semanticKey: ['uuid'],
//    representativeKey: 'uuid',
//    createEnabled: true,
//    updateEnabled: true,
//    deleteEnabled: true,
//   writeDraftPersistence: 'ZHR_CARCATEGD'
//}
define view ZHR_I_CANDIDATE_DRIVER
  as select from zhr_car_category
  association [1..1] to zhr_i_candidateheader as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
  association [0..1] to ZHR_I_CATEGORY_VH      as _CategoryVH     on $projection.name_category = _CategoryVH.name
{

  key uuid           as uuid,
      uuid_candidate as uuid_candidate,
     // @ObjectModel.foreignKey.association: '_CategoryVH'
      id_category    as id_category,
      name_category  as name_category,
      car_exist      as car_exist,
      dvriver        as dvriver,


//      @ObjectModel.association: {
//      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader,
      _CategoryVH
} 
 