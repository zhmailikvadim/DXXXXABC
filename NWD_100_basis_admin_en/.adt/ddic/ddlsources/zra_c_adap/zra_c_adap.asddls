@AbapCatalog.sqlViewName: 'ZRA_Q_C_ADAP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZRA_I_T_ADAP'

@Metadata.allowExtensions

@ObjectModel:{

    compositionRoot: true,
    modelCategory:#BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    semanticKey: ['cmat_item_uuid'],
    representativeKey: 'cmat_item_uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

@UI.presentationVariant: [{sortOrder: [{by: 'model_adapter',direction:#ASC }]}]
@UI.headerInfo: { typeName: 'Адаптеры',typeNamePlural: 'Адаптеры'}

@Search.searchable: true

define view ZRA_C_ADAP
  as select from ZRA_I_T_ADAP
  association [1..1] to ZHA_C_ARG_PARK as _groupdata1 on $projection.park_id = _groupdata1.park_id
  association [1..1] to ZHA_C_FARMS    as _cmatdata   on $projection.farm_id = _cmatdata.farm_id

{
      @UI.hidden: true
  key cmat_item_uuid,

      @UI.hidden: true
      park_id,

      @UI.hidden: true
      farm_id,

      @UI.lineItem: { position: 60, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      model_adapter,

      @UI.lineItem: { position: 70, importance: #HIGH }
      batch_adapter,

      @UI.lineItem: { position: 80, importance: #HIGH }
      @ObjectModel.readOnly: true
      @UI.hidden: true
      year_of_issue,
      
      @UI.lineItem: { position: 90, importance: #HIGH }
      data_of_issue,

      @UI.lineItem: { position: 100, importance: #HIGH }
      description,

      @UI.lineItem: { position: 110, importance: #HIGH }
       @ObjectModel.readOnly: true
//       @UI.hidden: true
       user_who_changed,

      @UI.lineItem: { position: 120, importance: #HIGH }
       @ObjectModel.readOnly: true
//       @UI.hidden: true
       date_changed,

      @UI.lineItem: { position: 130, importance: #HIGH }
       @ObjectModel.readOnly: true
//       @UI.hidden: true
       time_changed,

       @ObjectModel.association.type: [#TO_COMPOSITION_ROOT]
       _cmatdata,

       @ObjectModel.association.type: [#TO_COMPOSITION_PARENT]
       _groupdata1
}
