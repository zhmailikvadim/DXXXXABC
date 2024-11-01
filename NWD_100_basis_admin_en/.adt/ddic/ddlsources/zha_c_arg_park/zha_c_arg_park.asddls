@AbapCatalog.sqlViewName: 'ZHA_CQ_ARG_PRK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZHA_I_T_ARG_PARK'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    
    modelCategory:#BUSINESS_OBJECT,
    compositionRoot: true,    
    transactionalProcessingDelegated: true,
//    writeActivePersistence: 'ZHA_D_AGR_PARK',
    semanticKey: ['park_id'],
    representativeKey: 'park_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

@UI.presentationVariant: [{sortOrder: [{by: 'park_id',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Парк сельхозтехники',typeNamePlural: 'Парк сельхозтехники'}
@Search.searchable: true

define view ZHA_C_ARG_PARK
  as select from ZHA_I_T_ARG_PARK
  association [1..1] to ZHA_C_FARMS   as _farmData    on $projection.farm_id = _farmData.farm_id
  association [0..*] to ZRA_C_ADAP    as _itemtData   on $projection.park_id = _itemtData.park_id  
{
      @UI.hidden: true
  key park_id,

      @UI.lineItem: { position: 10, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      park_producer,

      @UI.lineItem: { position: 20, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      model,

      @UI.lineItem: { position: 30, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      batch,

      @UI.lineItem: { position: 40, importance: #HIGH }
      amount,

      @UI.lineItem: { position: 50, importance: #HIGH }
      year_of_issue,
      
      @UI.lineItem: { position: 55, importance: #HIGH }
      data_of_issue,
      
      
      @UI.lineItem: { position: 60, importance: #HIGH }
      model_engine,
      
      @UI.lineItem: { position: 70, importance: #HIGH }
      batch_engine,
      
      @UI.lineItem: { position: 80, importance: #HIGH }
      model_adapter,
      
      @UI.lineItem: { position: 90, importance: #HIGH }
      batch_adapter,

      @UI.hidden: true
      farm_id,

      @UI.hidden: true
      farm_name,

      @UI.lineItem: { position: 100, importance: #HIGH }
      description,
      
      @UI.lineItem: { position: 110, importance: #HIGH }
       @ObjectModel.readOnly: true
 //      @UI.hidden: true 
      user_who_changed,
      
      @UI.lineItem: { position: 120, importance: #HIGH }
       @ObjectModel.readOnly: true
//       @UI.hidden: true
      date_changed,
      
      @UI.lineItem: { position: 130, importance: #HIGH }
       @ObjectModel.readOnly: true
//       @UI.hidden: true
      time_changed,
          
      /* Associations */
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT,#TO_COMPOSITION_ROOT]
      _farmData,
      
       @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _itemtData 
}

