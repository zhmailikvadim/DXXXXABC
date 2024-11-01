@AbapCatalog.sqlViewName: 'ZHA_CQ_SPR_PRTS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for ZHA_I_T_SPARE_PARTS'

@OData.publish: true

@Metadata.allowExtensions: true

@ObjectModel:{
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    semanticKey: ['matnr','werks','lgort'],
    representativeKey: ['matnr','werks','lgort']
//    updateEnabled: true
}

@UI.presentationVariant: [{sortOrder: [{by: 'matnr',direction: #DESC }]}]
@UI.headerInfo: { typeName: 'Запчасть',typeNamePlural: 'Запчасти'}
@Search.searchable: true
define view ZHA_C_SPARE_PARTS
  as select from ZHA_I_T_SPARE_PARTS
 /* association[0..*] to ZHA_I_CURRENCY as _currency
                       on $projection.meins = _currency.currency*/
{


            @UI.lineItem: { position: 10, importance: #HIGH }
            @Search.defaultSearchElement: true
            @Search.ranking : #HIGH
  key       matnr,

            @UI.hidden: true
  key       werks,

            @UI.hidden: true
  key       lgort,

            @UI.lineItem: { position: 30, importance: #HIGH }
            @Search.defaultSearchElement: true
            @Search.ranking : #HIGH
            maktx,

            @UI.lineItem: {label:'Название завода', position: 50, importance: #HIGH }
            @Search.defaultSearchElement: true
            @Search.ranking : #HIGH
            name1,

            @UI.lineItem: {label:'Название склада', position: 70, importance: #HIGH }
            @Search.defaultSearchElement: true
            @Search.ranking : #HIGH
            lgobe,

            @UI.lineItem: { position: 80, importance: #HIGH}
            amount,

            /*//@UI.hidden: true
            @Consumption.valueHelp: '_currency'
            @EndUserText.label: 'Валюта'
            meins,*/

            @UI.lineItem: { position: 90, importance: #HIGH}
            cost,

            @UI.hidden: true
            waers,

           @Search.defaultSearchElement: true
           lower ( lgobe ) as lgobe_lower,
           @Search.defaultSearchElement: true          
           upper ( lgobe ) as lgobe_upper,
           
           @Search.defaultSearchElement: true
           lower ( maktx ) as maktx_lower,
           @Search.defaultSearchElement: true          
           upper ( maktx ) as maktx_upper,           
           
           @Search.defaultSearchElement: true
           lower ( matnr ) as matnr_lower,
           @Search.defaultSearchElement: true          
           upper ( matnr ) as matnr_upper
           
}
