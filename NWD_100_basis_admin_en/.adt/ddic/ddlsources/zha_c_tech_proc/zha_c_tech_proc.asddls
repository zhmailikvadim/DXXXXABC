@AbapCatalog.sqlViewName: 'ZHA_CQ_TCH_PRC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZHA_I_T_TECH_PROC'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_TECH_PROC',
    semanticKey: ['tech_proc_id'],
    representativeKey: 'tech_proc_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

@UI.presentationVariant: [{sortOrder: [{by: 'tech_proc_id',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Технологический процесс',typeNamePlural: 'Технологические процессы'}
@Search.searchable: true

define view ZHA_C_TECH_PROC
  as select from ZHA_I_T_TECH_PROC
{

      @UI.hidden: true
  key tech_proc_id,

      @UI.lineItem: { position: 10, importance: #HIGH}
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      tech_proc_name,

      @UI.lineItem: [ { position: 20, type: #WITH_URL,url: 'link' } ]
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      model,

      @UI.lineItem: { position: 30, importance: #HIGH }
      tech_proc_date,

      @UI.lineItem: { position: 50, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      tech_proc_number,

      @UI.lineItem: { position: 60, importance: #HIGH }
      description,

      @UI.identification:  { position: 70, importance: null}
      @UI.hidden: true
      link,

      @UI.lineItem: { position: 80, importance: #HIGH }
      user_who_changed,

      @UI.lineItem: { position: 90, importance: #HIGH }
      date_changed,

      @UI.lineItem: { position: 100, importance: #HIGH }
      time_changed

}
