@AbapCatalog.sqlViewName: 'ZHA_CQ_CNTCT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZHA_I_T_CONTACT'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    semanticKey: ['contact_id'],
    representativeKey: 'contact_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
} 

@UI.presentationVariant: [{sortOrder: [{by: 'contact_id',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Контакт',typeNamePlural: 'Контакты'}
@Search.searchable: true
 
define view ZHA_C_CONTACT
  as select from ZHA_I_T_CONTACT

{
      @UI.hidden: true
  key contact_id,

      @UI.lineItem: { position: 10, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      contact_name,

      @UI.lineItem: { position: 20, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      contact_position,

      @UI.lineItem: { position: 30, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      cont_gr_name,

      @UI.lineItem: { position: 40, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      struct_division,

      @UI.lineItem: { position: 50, importance: #HIGH }
      telephon,

      @UI.lineItem: { position: 60, importance: #HIGH }
      e_mail,

      @UI.lineItem: { position: 70, importance: #HIGH }
      user_who_changed,
      
      @UI.lineItem: { position: 80, importance: #HIGH }
      date_changed,
      
      @UI.lineItem: { position: 90, importance: #HIGH }
      time_changed

}
