@AbapCatalog: {
                sqlViewName: 'IMATDOCHEADER2',
                preserveKey: true,
                compiler.compareFilter: true
               }
               
@EndUserText.label: 'Material Document Header'

@AccessControl: {
                    authorizationCheck: #CHECK,
                    personalData.blocking: #NOT_REQUIRED,
                    privilegedAssociations: ['_User']
                 }
                 
@ClientHandling.algorithm: #SESSION_VARIABLE

@ObjectModel: {
                usageType: {
                             sizeCategory: #XXL,
                             serviceQuality: #B,
                             dataClass:#TRANSACTIONAL
                           },
                compositionRoot: true,
                representativeKey: 'MaterialDocument',
                semanticKey: ['MaterialDocumentYear', 'MaterialDocument'],
                modelingPattern: #ANALYTICAL_DIMENSION,
                supportedCapabilities: [#ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE]
} 

@Search.searchable: true
@VDM: {
        viewType: #COMPOSITE,
        lifecycle.contract.type: #PUBLIC_LOCAL_API
      }
@Analytics: {
                dataCategory: #DIMENSION,
                internalName:#LOCAL
             }

@Metadata: {
             ignorePropagatedAnnotations: true,
             allowExtensions: true
           }
-- This view is the successor view for the view I_MaterialDocumentHeader
define view I_MaterialDocumentHeader_2
  as select from I_MaterialDocumentRecord
  association [1..1] to I_MaterialDocumentYear   as _MaterialDocumentYear          on $projection.MaterialDocumentYear = _MaterialDocumentYear.MaterialDocumentYear
  association [1..*] to I_MaterialDocumentItem_2 as _MaterialDocumentItem          on $projection.MaterialDocumentYear = _MaterialDocumentItem.MaterialDocumentYear
                                                                                  and $projection.MaterialDocument     = _MaterialDocumentItem.MaterialDocument
  association [0..1] to I_DeliveryDocument       as _DeliveryDocument              on $projection.DeliveryDocument = _DeliveryDocument.DeliveryDocument

  association [0..1] to I_StorageLocation        as _StorageLocation               on $projection.StorageLocation = _StorageLocation.StorageLocation
                                                                                  and $projection.Plant           = _StorageLocation.Plant
  association [0..1] to I_StorageLocation        as _IssuingOrReceivingStorageLoc  on $projection.IssuingOrReceivingStorageLoc = _IssuingOrReceivingStorageLoc.StorageLocation
                                                                                  and $projection.IssuingOrReceivingPlant      = _IssuingOrReceivingStorageLoc.Plant
  association [0..*] to E_MaterialDocumentItem    as _ItemExtension               on  $projection.MaterialDocument     = _ItemExtension.MaterialDocument
                                                                                  and $projection.MaterialDocumentYear = _ItemExtension.MaterialDocumentYear
                                                                                  and _ItemExtension.MaterialDocumentRecordType = 'MDOC'                                                                              

  -- the association to the DeliveryDocument would also be available as _DeliveryInMatlDocumentHeader in I_MaterialDocumentRecord,
  -- but since the field is rebranded as DeliveryDocument in the header view, the repeated association seems to make sense
{
      @ObjectModel.foreignKey.association: '_MaterialDocumentYear'
  key MaterialDocumentYear,
      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #HIGH
                }
  key MaterialDocument,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
                }
      @Semantics.businessDate.at: true
      DocumentDate,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
                }
      @Semantics.businessDate.at: true
      PostingDate,
      AccountingDocumentType,
      InventoryTransactionType,

      CreatedByUser,
      CreationDate,
      CreationTime,
      MaterialDocumentHeaderText,

      @Search: {
                    defaultSearchElement: true,
                    fuzzinessThreshold: 0.9,
                    ranking: #MEDIUM
                }
      @ObjectModel.foreignKey.association: '_DeliveryDocument'
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_DeliveryDocumentStdVH',
                     element: 'DeliveryDocument' }
        }]
      DeliveryInMatlDocumentHeader as DeliveryDocument,
      ReferenceDocument,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #MEDIUM
      BillOfLading,

// Authorization check 
      @Consumption.hidden: true
      Plant,
      @Consumption.hidden: true
      StorageLocation,
      @Consumption.hidden: true
      IssuingOrReceivingPlant,
      @Consumption.hidden: true
      IssuingOrReceivingStorageLoc,
// Authorization check 

      _MaterialDocumentYear,
      @ObjectModel.association.type:#TO_COMPOSITION_CHILD
      _MaterialDocumentItem,

      _User,
      _AccountingDocumentType,
      _InventoryTransactionType,

      _DeliveryDocument,
// Authorization check 
      @Consumption.hidden: true
      _StorageLocation,
      @Consumption.hidden: true
      _IssuingOrReceivingStorageLoc
// Authorization check 
      
}
where
      MaterialDocumentRecordType = 'MDOC'
  and IsMaterialDocumentHeader   = 1
 