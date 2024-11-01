@AbapCatalog.sqlViewName: 'ZHA_CQ_CNT_GRP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZHA_I_T_CONT_GROUP'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    semanticKey: ['cont_gr_id'],
    representativeKey: 'cont_gr_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

@UI.presentationVariant: [{sortOrder: [{by: 'cont_gr_id',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Группа контактов',typeNamePlural: 'Группы контактов'}
@Search.searchable: true

define view ZHA_C_CONT_GROUP
  as select from ZHA_I_T_CONT_GROUP
 // association [0..*] to ZHA_C_CONTACT as _contactData on $projection.cont_gr_id = _contactData.cont_gr_id
{

      @UI.hidden: true
  key cont_gr_id,
  
      @UI.lineItem: { position: 10, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      cont_gr_name,
      
       @UI.lineItem: { position: 20, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      struct_division,
      
       @UI.lineItem: { position: 30, importance: #HIGH }
      description
}
