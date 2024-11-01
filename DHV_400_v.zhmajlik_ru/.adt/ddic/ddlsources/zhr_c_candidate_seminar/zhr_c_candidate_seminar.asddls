@AbapCatalog.sqlViewName: 'ZHRCCANDIDSEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Семинары, курсы Consumption'

@Metadata.allowExtensions: true


@VDM.viewType: #CONSUMPTION

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    writeActivePersistence: 'ZHR_CAND_SEM',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
 //   writeDraftPersistence: 'ZHR_PB0022D'
}

define view ZHR_C_CANDIDATE_SEMINAR
  as select from ZHR_I_CANDIDATE_SEMINAR
  association [1..1] to ZHR_C_CANDIDATEHEADER as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
{
  key uuid,
      uuid_candidate,
      begda,
      name,
      ftext,
      anzkl,
      academic_degree,
      endda_sem,
      name_univer        as name_univer,
      /* Associations */
      @ObjectModel.association: {
      type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
      _CandidateHeader,
      _TypeEducationVH

} 
 