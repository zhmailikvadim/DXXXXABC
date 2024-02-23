@AbapCatalog.preserveKey: true
@AbapCatalog.sqlViewName: 'IPURGSHIP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@EndUserText.label: 'CDS View for Purg Document Shipping Data'
@VDM.viewType : #BASIC
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #L
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
define view I_PurchasingDocumentShipping as select from ekpv 
  association [1..1] to I_PurchasingDocument as _PurchasingDocument on $projection.PurchasingDocument = _PurchasingDocument.PurchasingDocument
  association [1..1] to I_PurchasingDocumentItem as _PurchasingDocumentItem on $projection.PurchasingDocument = _PurchasingDocumentItem.PurchasingDocument
                                                                            and $projection.PurchasingDocumentItem = _PurchasingDocumentItem.PurchasingDocumentItem
  association [0..1] to I_Customer  as _ShipToParty on  $projection.ShipToParty = _ShipToParty.Customer 
  association [0..1] to I_SalesOrganization as _SalesOrganization on  $projection.SalesOrganization = _SalesOrganization.SalesOrganization
  association [0..1] to I_DistributionChannel as _DistributionChannel on  $projection.DistributionChannel = _DistributionChannel.DistributionChannel
  association [0..1] to I_Division as _OrganizationDivision on  $projection.OrganizationDivision = _OrganizationDivision.Division
  association [0..1] to I_ShippingCondition as _ShippingCondition on  $projection.ShippingCondition = _ShippingCondition.ShippingCondition
  association [0..1] to I_ShippingPoint as _ShippingPoint on  $projection.ShippingPoint = _ShippingPoint.ShippingPoint
  association [0..1] to I_ShippingType as _ShippingType on  $projection.ShippingType = _ShippingType.ShippingType
{
    @ObjectModel.foreignKey.association: '_PurchasingDocument'
    key ebeln as PurchasingDocument,
    
    @ObjectModel.foreignKey.association: '_PurchasingDocumentItem'
    key ebelp as PurchasingDocumentItem,
    
    kunag as SoldToParty,
    
    @ObjectModel.foreignKey.association: '_ShipToParty'
    kunnr as ShipToParty,
    
    @ObjectModel.foreignKey.association: '_SalesOrganization'
    vkorg as SalesOrganization,
    
    @ObjectModel.foreignKey.association: '_DistributionChannel'
    vtweg as DistributionChannel,
    
    @ObjectModel.foreignKey.association: '_OrganizationDivision'
    spart as OrganizationDivision,
    
    @ObjectModel.foreignKey.association: '_ShippingCondition'
    vsbed as ShippingCondition,
    
    @ObjectModel.foreignKey.association: '_ShippingPoint'
    vstel as ShippingPoint,
    route as Route,
    ladgr as LoadingGroup,
    tragr as TransportationGroup,
    lprio as DeliveryPriority,
    
    @ObjectModel.foreignKey.association: '_ShippingType'
    vsart as ShippingType,
    ablad as UnloadingPointName,
    ledat as DeliveryCreationDate,
    plifz as PlannedDeliveryDuration,
    
    _PurchasingDocument,   
    _PurchasingDocumentItem,
    _ShipToParty,
    _SalesOrganization,
    _DistributionChannel,
    _OrganizationDivision,
    _ShippingCondition,
    _ShippingPoint,
    _ShippingType


}
