@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Test Kar'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI.headerInfo: { typeName: ' Test Program', typeNamePlural: 'Test Programs'}
@UI.presentationVariant : [{
    groupBy : [
        'AirportId'
    ]
}]
define view entity ztest_kar_1
  as select from /dmo/airport as airport
  association [1..*] to zI_fli_mod_dm as _conn on $projection.AirportId = _conn.AirportFromId
{
      @UI.facet: [{ id: 'Test', purpose: #STANDARD , type: #IDENTIFICATION_REFERENCE , position: 10, label: 'Test Iden'},
      {id:'conn',purpose: #STANDARD, type: #LINEITEM_REFERENCE ,position: 20, label: 'Carrier_Facet',targetElement: '_conn'  }]
      @UI.identification: [{ position: 10 }]
      @UI.selectionField: [{ position: 10  }]
      @UI.lineItem: [{ position: 10, label: 'Airport ID' }]
  key airport_id as AirportId,
      @UI.identification: [{ position: 20 }]
      @UI.selectionField: [{ position: 20  }]
      @UI.lineItem: [{ position: 20, label: 'Airport Name' }]

      name       as Name,
      @UI.identification: [{ position: 30 }]
      @UI.lineItem: [{ position: 30, label: 'City' }]
      @DefaultAggregation: #MIN
      city       as City,
      @UI.identification: [{ position: 40 , label: 'Nation'}]
      @UI.lineItem: [{ position: 40, label: 'Country' }]
      country    as Country,
      _conn




}
