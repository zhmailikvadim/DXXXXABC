@AbapCatalog.sqlViewName: 'ZHA_CQ_SD_CRP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZHA_I_T_SEED_CROP'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    transactionalProcessingDelegated: true,
    writeActivePersistence: 'ZHA_D_SEED_CROP',
    semanticKey: ['crop_id'], 
    representativeKey: 'crop_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

@UI.presentationVariant: [{sortOrder: [{by: 'crop_id',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Полевая культура',typeNamePlural: 'Полевые культуры'}
@Search.searchable: true
define view ZHA_C_SEED_CROP
  as select from ZHA_I_T_SEED_CROP
  association [1..1] to ZHA_C_FARMS as _farmsData on $projection.farm_id = _farmsData.farm_id
{
      @UI.hidden: true
  key crop_id,

      @UI.lineItem: { position: 10, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      @Consumption.filter.hidden: true
      crop_name,

      @UI.hidden: true
      farm_id,

      @UI.hidden: true
      farm_name,
      
      @UI.lineItem: { position: 20, importance: #HIGH }
      crop_square,

      @UI.lineItem: { position: 30, importance: #HIGH }
      description,
      
      @UI.lineItem: { position: 40, importance: #HIGH }
      user_who_changed,
      
      @UI.lineItem: { position: 50, importance: #HIGH }
      date_changed,
      
      @UI.lineItem: { position: 60, importance: #HIGH }
      time_changed,

      /* Associations */
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT,#TO_COMPOSITION_ROOT]
      _farmsData
}
