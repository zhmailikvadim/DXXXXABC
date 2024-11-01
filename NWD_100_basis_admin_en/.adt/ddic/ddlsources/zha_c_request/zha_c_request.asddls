@AbapCatalog.sqlViewName: 'ZHA_CQ_RQST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZHA_I_T_REQUEST'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    semanticKey: ['matnr'],
    representativeKey: 'matnr',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true

}

@UI.presentationVariant: [{sortOrder: [{by: 'matnr',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Заявка',typeNamePlural: 'Заявки'}
@Search.searchable: true

define view ZHA_C_REQUEST
  as select from ZHA_I_T_REQUEST
{

      @UI.hidden: true
  key req_id,

      @UI.lineItem: { position: 10, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      @Consumption.valueHelpDefinition: [{ entity:
             {name: 'ZHA_I_MAKT' , element: 'matnr_ext' },
             additionalBinding: [{ localElement: 'maktx', element: 'maktx' },
             { localElement: 'meins', element: 'meins' }
             ]
             }]

      matnr,

      @UI.lineItem: { position: 20, importance: #HIGH }
      @ObjectModel.readOnly: true
      maktx,

      @UI.lineItem: { position: 30, importance: #HIGH }
      qnt,

      @UI.lineItem: { position: 40, importance: #HIGH }
      @ObjectModel.readOnly: true
      meins,

      @UI.lineItem: { position: 50, importance: #HIGH }
      zyear,

      @UI.lineItem: { position: 60, importance: #HIGH }
      zmonth,

      @UI.lineItem: { position: 70, importance: #HIGH }
//      @Consumption.valueHelpDefinition: [{ entity:
//              {name: 'ZHA_I_PARTNERS' , element: 'kunnr' },
//              additionalBinding: [{ localElement: 'name1', element: 'name1' }
//              ]
//              }]
      @ObjectModel.readOnly: true
      kunnr,

      @UI.lineItem: { position: 80, importance: #HIGH }
      @ObjectModel.readOnly: true
      name1,
      
      @UI.lineItem: { position: 90, importance: #HIGH }
      user_who_changed,
      
      @UI.lineItem: { position: 100, importance: #HIGH }
      date_changed,
      
      @UI.lineItem: { position: 110, importance: #HIGH }
      time_changed,

      @UI.hidden: true
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      lower_name1
}
