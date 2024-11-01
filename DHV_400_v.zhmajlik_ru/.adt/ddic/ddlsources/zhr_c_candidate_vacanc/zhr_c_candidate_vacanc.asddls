@AbapCatalog.sqlViewName: 'ZHRCCANDVACANC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption Vacancies'

@Metadata.allowExtensions: true 


@VDM.viewType: #CONSUMPTION


@ObjectModel:{

    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    writeActivePersistence: 'ZHR_VACANCIES',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZHR_C_CANDIDATE_VACANC as select from ZHR_I_CANDIDATE_VACANCIES
association [1..1] to ZHR_C_CANDIDATEHEADER as CandidateHeader on $projection.uuid_candidate = CandidateHeader.uuid
{
    key uuid,
        uuid_candidate,
        name_vacans,
        address,
        enterprise,
        / Associations /
        @ObjectModel.association: {
         type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
        _CandidateHeader
}