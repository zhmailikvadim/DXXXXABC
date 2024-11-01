@AbapCatalog.sqlViewName: 'ZHRCCANDIDEDUC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Образование Consumption'
@Metadata.allowExtensions: true

//@OData.publish: true

@VDM.viewType: #CONSUMPTION


@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    writeActivePersistence: 'ZHR_PB0022',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
 //   writeDraftPersistence: 'ZHR_PB0022D'
}

define view ZHR_C_CANDIDATE_EDUCATION
  as select from ZHR_I_CANDIDATE_EDUCATION
  association [1..1] to ZHR_C_CANDIDATEHEADER as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
{
  key     uuid,
          uuid_candidate,
          Begda     as begda,
          Endda     as Endda,
          Insti     as Insti,
          ftext     as ftext,
          qualiname as qualiname,
        //  education_type as education_type,
          @ObjectModel.association: {
          type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
          _CandidateHeader
} 
 