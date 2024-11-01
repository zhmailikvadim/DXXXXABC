@AbapCatalog.sqlViewName: 'ZHA_CQ_FLR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZHA_I_T_FAILURE'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    transactionalProcessingDelegated: true,
    writeActivePersistence: 'ZHA_D_FAILURE',
    semanticKey: ['failure_id'],
    representativeKey: 'failure_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

@UI.presentationVariant: [{sortOrder: [{by: 'failure_id',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Отказ',typeNamePlural: 'Отказы'}
@Search.searchable: true

define view ZHA_C_FAILURE
  as select from    ZHA_I_T_FAILURE
    left outer join ZHA_I_FAILURE_MESSAGE on ZHA_I_FAILURE_MESSAGE.message_id = ZHA_I_T_FAILURE.message_id
  association [1..1] to ZHA_C_MALFUNCTION as _malfuncData on $projection.malfunc_id = _malfuncData.malfunc_id
{
       @UI.hidden: true
  key  failure_id,

       @UI.hidden: true
       ZHA_I_T_FAILURE.malfunc_id,

       @UI.hidden: true
       ZHA_I_T_FAILURE.message_id,

       @UI.hidden: true
       @ObjectModel.readOnly: true
       _malfuncData.farm_name,

       @UI.lineItem: { label: 'Сообщение о неисправности',position: 10, importance: #HIGH }
       @Consumption.valueHelpDefinition: [{ entity:
            {name: 'ZHA_I_FAILURE_MESSAGE' , element: 'failure_message' },
            additionalBinding: [{localElement: 'measures', element: 'measures' },
                                {localElement: 'description', element: 'description' }
                               ]

            }]
       ZHA_I_T_FAILURE.failure_message,

       @UI.lineItem: { position: 20, importance: #HIGH }
       ZHA_I_T_FAILURE.measures,

       @UI.lineItem: { position: 30, importance: #HIGH }
       @Search.defaultSearchElement: true
       @Search.ranking : #HIGH
       @Consumption.valueHelpDefinition: [{ entity:
             {name: 'ZHA_I_MAKT' , element: 'matnr_ext' }
             }]
       matnr,

       @UI.hidden: true
       malfunc_number,

       @UI.lineItem: { position: 60, importance: #HIGH }
       ZHA_I_T_FAILURE.description,

       /* Associations */
       @ObjectModel.association.type: [#TO_COMPOSITION_PARENT,#TO_COMPOSITION_ROOT]
       _malfuncData
}
