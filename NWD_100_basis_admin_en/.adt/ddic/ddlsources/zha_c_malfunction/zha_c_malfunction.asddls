@AbapCatalog.sqlViewName: 'ZHA_CQ_MLFNCTN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZHA_I_T_MALFUNC'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_MALFUNC',
    semanticKey: ['malfunc_id'],
    representativeKey: 'malfunc_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

@UI.presentationVariant: [{sortOrder: [{by: 'malfunc_id',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Акт рекламации',typeNamePlural: 'Акты рекламации'}
@Search.searchable: true

define view ZHA_C_MALFUNCTION
  as select from    ZHA_I_T_MALFUNC
    left outer join ZHA_I_CODE_CONDITION on ZHA_I_CODE_CONDITION.code_condition = ZHA_I_T_MALFUNC.code_condition
  // left outer join ZHA_I_FARMS on ZHA_I_FARMS.farm_id = ZHA_I_T_MALFUNC.farm_id
  association [0..*] to ZHA_C_FAILURE as _failureData on $projection.malfunc_id = _failureData.malfunc_id
{
       @UI.hidden: true
  key  malfunc_id,

       @UI.lineItem: {position: 10, importance: #HIGH }
       @Search.defaultSearchElement: true
       @Search.ranking : #HIGH
       @ObjectModel.readOnly: true
       malfunc_number,

       @UI.lineItem: { position: 20, importance: #HIGH }
       @Search.defaultSearchElement: true
       @Search.ranking : #HIGH
       malfunc_paper_number,

       @UI.lineItem: { position: 30, importance: #HIGH }
       @Consumption.valueHelpDefinition: [{ entity:
            {name: 'ZHA_I_ARG_PARK_NAME' , element: 'model' },
            additionalBinding: [{localElement: 'farm_name',element: 'farm_name'},
            {localElement: 'batch',element: 'batch'}]
            }]
       model,

       @UI.lineItem: { position: 40, importance: #HIGH }
       @Consumption.valueHelpDefinition: [{ entity:
            {name: 'ZHA_I_ARG_PARK_NAME' , element: 'batch' },
            additionalBinding: [{localElement: 'model',element: 'model'}]
            }]
       batch,

//       @UI.hidden: true
       /*   @UI.lineItem: { position: 50}
          @Consumption.valueHelpDefinition: [{ entity:
               { name: 'ZHA_I_CODE_CONDITION' , element: 'code_condition' }
               }] */
       @UI.lineItem: { position: 50, importance: #HIGH }     
       ZHA_I_T_MALFUNC.code_condition,

       @UI.lineItem: { position: 55, importance: #HIGH }
       @ObjectModel.readOnly: true
       ZHA_I_CODE_CONDITION.code_name,

       @UI.lineItem: {label: 'Наработка на момент отказа', position: 60, importance: #HIGH }
       worktime,

       @UI.hidden: true
//       @UI.lineItem: {label:'ЕИ наработки', position: 70, importance: #HIGH }  
       meins,

       @UI.hidden: true
       @ObjectModel.readOnly: true
       mseht,

       @UI.lineItem: { position: 80, importance: #HIGH }
       repair_date,

       @UI.lineItem: { position: 90, importance: #HIGH }
       message_date,

       @UI.lineItem: { position: 100, importance: #HIGH }
       @Search.defaultSearchElement: true
       @Search.ranking : #HIGH
       @Consumption.valueHelpDefinition: [{ entity:
            {name: 'ZHA_I_FARM_NAME' , element: 'farm_name' },
            additionalBinding: [{localElement: 'model',element: 'model'}]
            }]
       farm_name,

       @UI.lineItem: { position: 110, importance: #HIGH, type: #WITH_URL, url: 'photo_link' }
       failure_photo,

       @UI.identification: {position: 120, importance: null}
       @UI.hidden: true
       photo_link,

       @UI.hidden: true
//       @UI.lineItem: { position: 130, importance: #HIGH, type: #WITH_URL,url: 'video_link' }
       failure_video,

       @UI.identification:  { position: 140, importance: null}
       @UI.hidden: true
       video_link,

       @UI.lineItem: { position: 150, importance: #HIGH }
       description,

       @UI.lineItem: { position: 160, importance: #HIGH }
       user_who_changed,

       @UI.lineItem: { position: 170, importance: #HIGH }
       date_changed,

       @UI.lineItem: { position: 160, importance: #HIGH }
       time_changed,

       /* Associations */
       @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
       _failureData
}
