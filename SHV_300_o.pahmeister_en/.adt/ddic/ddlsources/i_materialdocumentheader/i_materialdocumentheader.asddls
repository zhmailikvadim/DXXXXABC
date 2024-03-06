@AbapCatalog.sqlViewName: 'IMatDocHeader'
@EndUserText.label: 'Material Document Header'

@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.dataClass:#TRANSACTIONAL
@ClientHandling.algorithm: #SESSION_VARIABLE

@ObjectModel.modelCategory: #BUSINESS_OBJECT
@ObjectModel.compositionRoot: true
@ObjectModel.representativeKey: 'MaterialDocument'

@Search.searchable: true
@VDM.private: false
@VDM.viewType: #COMPOSITE
@Analytics.dataCategory: #DIMENSION

define view I_MaterialDocumentHeader
  as select from I_MaterialDocumentRecord
  association [1..1] to I_MaterialDocumentYear as _MaterialDocumentYear on  $projection.MaterialDocumentYear = _MaterialDocumentYear.MaterialDocumentYear
  association [1..*] to I_MaterialDocumentItem as _MaterialDocumentItem on  $projection.MaterialDocumentYear = _MaterialDocumentItem.MaterialDocumentYear
                                                                        and $projection.MaterialDocument     = _MaterialDocumentItem.MaterialDocument
  association [0..1] to I_DeliveryDocument     as _DeliveryDocument     on  $projection.DeliveryDocument = _DeliveryDocument.DeliveryDocument
  -- the association to the DeliveryDocument would also be available as _DeliveryInMatlDocumentHeader in I_MaterialDocumentRecord,
  -- but since the field is rebranded as DeliveryDocument in the header view, the repeated association seems to make sense
{
      @ObjectModel.foreignKey.association: '_MaterialDocumentYear'
  key MaterialDocumentYear,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
  key MaterialDocument,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
      DocumentDate,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
      PostingDate,
      AccountingDocumentType,
      InventoryTransactionType,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
      CreatedByUser,
      MaterialDocumentHeaderText,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
      @ObjectModel.foreignKey.association: '_DeliveryDocument'
      DeliveryInMatlDocumentHeader as DeliveryDocument,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      BillOfLading,

      _MaterialDocumentYear,
      @ObjectModel.association.type:#TO_COMPOSITION_CHILD
      _MaterialDocumentItem,

      _User,
      _AccountingDocumentType,
      _InventoryTransactionType,

      _DeliveryDocument
}
where
      MaterialDocumentRecordType = 'MDOC'
  and IsMaterialDocumentHeader   = 1                  
  
  
  
  
  
  
 