@AbapCatalog.sqlViewName: 'ZHA_CQ_FRMS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZHA_I_T_FARMS'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    modelCategory:#BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    semanticKey: ['farm_id'],
    representativeKey: 'farm_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

@UI.presentationVariant: [{sortOrder: [{by: 'farm_id',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Хозяйство',typeNamePlural: 'Хозяйства'}
@Search.searchable: true


define view ZHA_C_FARMS
  as select from ZHA_I_T_FARMS
  association [0..*] to ZHA_C_ARG_PARK  as _parkData on $projection.farm_id = _parkData.farm_id
  association [0..*] to ZHA_C_SEED_CROP as _cropData on $projection.farm_id = _cropData.farm_id

{
       @UI.hidden: true
  key  farm_id,

       @UI.lineItem: { position: 10, importance: #HIGH }
       @Search.defaultSearchElement: true
       @Search.ranking : #HIGH
       @Consumption.valueHelpDefinition: [{ entity:
              {name: 'ZHA_I_UPPER_FARM_NAME', element: 'Partner'},
              additionalBinding: [{ localElement: 'kunnr', element: 'kunnr' },
              { localElement: 'farm_country', element: 'landx' },
              { localElement: 'farm_city', element: 'ort01' },
              { localElement: 'farm_region', element: 'bezei' },
              { localElement: 'farm_adress', element: 'stras' },
              { localElement: 'telephon', element: 'telf1' },
              { localElement: 'e_mail', element: 'smtp_addr' }
              ]
              }]
       farm_name,

       @UI.lineItem: { position: 20, importance: #HIGH }
       @Consumption.valueHelpDefinition: [{ entity:
             {name: 'ZHA_I_COUNTRY' , element: 'landx' }
             }]
       farm_country,

       @UI.hidden: true
       bland,

       @UI.lineItem: { position: 30, importance: #HIGH }
       @Consumption.valueHelpDefinition: [{ entity:
             {name: 'ZHA_I_REGION' , element: 'bezei' },
             additionalBinding: [{ localElement: 'farm_country', element: 'landx' }
             ]
             }]
       farm_region,

       @UI.lineItem: { position: 40, importance: #HIGH }
       @Consumption.valueHelpDefinition: [{ entity:
             {name: 'ZHA_I_CITY' , element: 'ort01' },
              additionalBinding: [{ localElement: 'farm_country', element: 'landx' }
             ]
             }]
       farm_city,

       @UI.lineItem: { position: 50, importance: #HIGH }
       farm_adress,


       @UI.lineItem: { position: 60, importance: #HIGH }
       telephon,

       @UI.lineItem: { position: 70, importance: #HIGH }
       e_mail,

       @UI.lineItem: { position: 80, importance: #HIGH }
       @Consumption.valueHelpDefinition: [{ entity:
               {name: 'ZHA_I_UPPER_FARM_NAME' , element: 'kunnr' },
               additionalBinding: [{ localElement: 'farm_name', element: 'Partner' },
               { localElement: 'farm_country', element: 'landx' },
               { localElement: 'farm_city', element: 'ort01' },
               { localElement: 'farm_adress', element: 'stras' },
               { localElement: 'telephon', element: 'telf1' },
               { localElement: 'e_mail', element: 'smtp_addr' }
               ]
               }]
       kunnr,

       @UI.lineItem: { position: 90, importance: #HIGH }
       user_who_changed,

       @UI.lineItem: { position: 100, importance: #HIGH }
       date_changed,

       @UI.lineItem: { position: 110, importance: #HIGH }
       time_changed,
       
       @UI.hidden: true
       @Search.defaultSearchElement: true
       @Search.ranking : #HIGH
       lower_farm_name,

       @UI.hidden: true
       @Search.defaultSearchElement: true
       @Search.ranking : #HIGH
       lower_farm_country,

       @UI.hidden: true
       @Search.defaultSearchElement: true
       @Search.ranking : #HIGH
       lower_farm_adress,
       
       
       /* Associations */
       @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
       _cropData,

       @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
       _parkData
}
