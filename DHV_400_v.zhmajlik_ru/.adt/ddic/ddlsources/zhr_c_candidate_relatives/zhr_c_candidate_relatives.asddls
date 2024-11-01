@AbapCatalog.sqlViewName: 'ZHRCCANDRELAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Родственники Consumption'

@Metadata.allowExtensions: true


@VDM.viewType: #CONSUMPTION

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    writeActivePersistence: 'ZHR_RELATIVES',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
 //   writeDraftPersistence: 'ZHR_PB0022D'
}

define view ZHR_C_CANDIDATE_RELATIVES
  as select from ZHR_I_CANDIDATE_RELATIVES
  association [1..1] to ZHR_C_CANDIDATEHEADER as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
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
      /* Associations */
      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader,
      _TypeRelatVH,
      _EnterPriceVH
} 
 