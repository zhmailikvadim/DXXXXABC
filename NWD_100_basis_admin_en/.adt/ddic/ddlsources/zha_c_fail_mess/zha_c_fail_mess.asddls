@AbapCatalog.sqlViewName: 'ZHA_CQ_FL_MS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZHA_C_FAIL_MESS'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_FAIL_MESS',
    semanticKey: ['message_id'],
    representativeKey: 'message_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

@UI.presentationVariant: [{sortOrder: [{by: 'message_id',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Сообщение об отказе',typeNamePlural: 'Сообщения об отказах'}
@Search.searchable: true

define view ZHA_C_FAIL_MESS
  as select from ZHA_I_T_FAIL_MESSAGE
  //  left outer join ZHA_I_FARMS on ZHA_I_FARMS.farm_id = ZHA_I_T_FAIL_MESSAGE.farm_id
{
      @UI.hidden: true
  key message_id,

      @UI.lineItem: { position: 10, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      @ObjectModel.readOnly: true
      message_number,

      @UI.lineItem: { label: 'Дата возникновения отказа', position: 20, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      date_failure,

      @UI.hidden: false
      @UI.lineItem: { position: 30, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      message_date,

      @UI.hidden: true
      @UI.lineItem: { position: 40, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      client_address,

      @UI.lineItem: { position: 50, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      model,

      @UI.lineItem: { position: 60, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      batch,

      @UI.hidden: true
      farm_id,

      @UI.lineItem: { position: 70, importance: #HIGH }
      @Search.defaultSearchElement: true
      @Search.ranking : #HIGH
      @Consumption.valueHelpDefinition: [{ entity:
          {name: 'ZHA_I_FARM_NAME' , element: 'farm_name' },
           additionalBinding: [{ localElement: 'farm_country', element: 'farm_country' },
              { localElement: 'farm_region', element: 'bezei' }]
          }]
      farm_name,

      @UI.lineItem: { position: 80, importance: #HIGH }
      @Consumption.valueHelpDefinition: [{ entity:
           {name: 'ZHA_I_COUNTRY' , element: 'landx' },
            additionalBinding: [{ localElement: 'farm_name', element: 'farm_name' },
            { localElement: 'farm_region', element: 'bezei' }]
           }]
      farm_country,

      @UI.hidden: true
      bland,

      @UI.lineItem: { position: 90, importance: #HIGH }
      @Consumption.valueHelpDefinition: [{ entity:
             {name: 'ZHA_I_REGION' , element: 'bezei' },
             additionalBinding: [{ localElement: 'farm_country', element: 'landx' }
             ]
             }]
      farm_region,

      @UI.lineItem: {label: 'Описание неисправности', position: 100, importance: #LOW }
      failure_message,

      @UI.lineItem: { position: 110, importance: #HIGH }
      measures,

      @UI.lineItem: { position: 120, importance: #HIGH }
      description,

      @UI.lineItem: { position: 130, importance: #HIGH }
      user_who_changed,

      @UI.lineItem: { position: 140, importance: #HIGH }
      date_changed,

      @UI.lineItem: { position: 150, importance: #HIGH }
      time_changed,
      
      @UI.hidden: true
      malfunc_id
}
