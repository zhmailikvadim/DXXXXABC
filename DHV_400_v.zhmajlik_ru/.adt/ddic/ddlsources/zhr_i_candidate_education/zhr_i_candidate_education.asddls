@AbapCatalog.sqlViewName: 'ZHRICANDIDATEEDU'
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
    writeActivePersistence: 'ZHR_PB0022',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
   writeDraftPersistence: 'ZHR_PB0022D'
   
}
define view ZHR_I_CANDIDATE_EDUCATION
  as select from zhr_pb0022
  association [1..1] to zhr_i_candidateheader as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
{
  key     uuid,
          uuid_candidate,
          begda     as begda,
          endda     as Endda,
          insti     as Insti,
          ftext     as ftext,
          qualiname as qualiname,
           

            @ObjectModel.association: {
            type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
            _CandidateHeader

} 
 