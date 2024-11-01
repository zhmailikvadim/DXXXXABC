@AbapCatalog.sqlViewName: 'ZHA_CQ_TTRL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZHA_I_TUTORIAL'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_TUTORIALS',
    semanticKey: ['tutorial_id'],
    representativeKey: 'tutorial_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

@UI.presentationVariant: [{sortOrder: [{by: 'tutorial_id',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Руководство',typeNamePlural: 'Руководства'}
@Search.searchable: true

define view ZHA_C_TUTORIAL
  as select from ZHA_I_T_TUTORIAL
{
      @UI.hidden: true
  key tutorial_id,

      @UI.lineItem: [ { position: 10, type: #WITH_URL,url: 'link' } ]
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      tutorial_name,

      @UI.identification:  { position: 20, importance: null}
      @UI.hidden: true
      link,

      @UI.lineItem: { position: 30, importance: #HIGH }
      description,
      
      @UI.lineItem: { position: 40, importance: #HIGH }
      user_who_changed,
      
      @UI.lineItem: { position: 50, importance: #HIGH }
      date_changed,
      
      @UI.lineItem: { position: 60, importance: #HIGH }
      time_changed

}
