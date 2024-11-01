@AbapCatalog.sqlViewName: 'zhripersons'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SAP ABAP Persons'
@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHR_T_PERSONS',
    semanticKey: ['UUID'],
    representativeKey: 'UUID',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view zhr_i_persons
  as select from zhr_t_persons
{
  key    uuid,
         person_id,
         sap_user
} 
 