@AbapCatalog:{
               sqlViewName: 'IPLANT',
               preserveKey: true,
               compiler.compareFilter: true
             }
@EndUserText.label: 'Plant'
@ObjectModel:{
               usageType:{
                           sizeCategory: #S,
                           serviceQuality: #A,
                           dataClass:#CUSTOMIZING
                         },
               representativeKey: 'Plant',
               sapObjectNodeType: {
                                    name: 'Plant'
                                  },
               modelingPattern: #ANALYTICAL_DIMENSION,
               supportedCapabilities: [#ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE, #EXTRACTION_DATA_SOURCE]
             }
@AccessControl:{
                 authorizationCheck: #NOT_REQUIRED,
                 personalData.blocking: #NOT_REQUIRED,
                 privilegedAssociations: ['_Address', '_OrganizationAddress']
               }
@VDM:{
       viewType: #BASIC,
       lifecycle.contract.type: #PUBLIC_LOCAL_API
     }
@ClientHandling.algorithm: #SESSION_VARIABLE
@Analytics:{
             dataCategory: #DIMENSION,
             dataExtraction.enabled: true
           }
@Search.searchable: true
@Metadata:{
            allowExtensions: true,
            ignorePropagatedAnnotations: true
          }

define view I_Plant
  as select from t001w
  association [0..1] to I_Address                     as _Address                on $projection.AddressID = _Address.AddressID
  association [0..*] to I_OrganizationAddress         as _OrganizationAddress    on $projection.AddressID = _OrganizationAddress.AddressID and _OrganizationAddress.AddressPersonID = ''
  association [0..1] to I_Customer                    as _Customer               on $projection.PlantCustomer = _Customer.Customer
  association [0..1] to I_Supplier                    as _Supplier               on $projection.PlantSupplier = _Supplier.Supplier
  association [0..*] to I_PlantPurchasingOrganization as _ResponsiblePurchaseOrg on $projection.Plant = _ResponsiblePurchaseOrg.Plant
  association [0..*] to I_PlantCategoryT              as _PlantCategoryText      on $projection.PlantCategory = _PlantCategoryText.PlantCategory
  association [0..1] to I_ValuationArea               as _ValuationArea          on $projection.ValuationArea = _ValuationArea.ValuationArea
  association [0..*] to I_MRPArea                     as _MRPArea                on $projection.Plant = _MRPArea.MRPAreaPlant
{
      @ObjectModel.text.element: 'PlantName'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
  key werks                                      as Plant,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      cast(name1 as werks_name preserving type ) as PlantName,
      bwkey                                      as ValuationArea,
      @ObjectModel.foreignKey.association: '_Customer'
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_Customer_VH',
                     element: 'Customer' }
        }]
      kunnr                                      as PlantCustomer,
      @ObjectModel.foreignKey.association: '_Supplier'
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_Supplier_VH',
                     element: 'Supplier' }
        }]
      lifnr                                      as PlantSupplier,
      fabkl                                      as FactoryCalendar,
      ekorg                                      as DefaultPurchasingOrganization,
      vkorg                                      as SalesOrganization,
      @ObjectModel.foreignKey.association: '_Address'
      adrnr                                      as AddressID,
      vlfkz                                      as PlantCategory,
      vtweg                                      as DistributionChannel,
      spart                                      as Division,
      spras                                      as Language,
      achvm                                      as IsMarkedForArchiving,  //2949107
      _Address,
      _OrganizationAddress,
      _Customer,
      _Supplier,
      _ResponsiblePurchaseOrg,
      _PlantCategoryText,
      _ValuationArea,
      _MRPArea
}





