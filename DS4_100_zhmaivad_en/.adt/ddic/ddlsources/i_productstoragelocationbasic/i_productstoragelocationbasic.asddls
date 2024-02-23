@AbapCatalog:{
    sqlViewName: 'IPRDSTORLOCBASIC',
    compiler.compareFilter: true,
    preserveKey: true
}
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Product Storage Location'
@Metadata.ignorePropagatedAnnotations:true
@Metadata.allowExtensions:true
@ObjectModel:{
    usageType.serviceQuality: #A,
    usageType.sizeCategory : #XL,
    usageType.dataClass: #MASTER,
    representativeKey: 'Product'
}
@VDM.viewType: #BASIC

@Analytics:{
   dataCategory: #DIMENSION,
   dataExtraction: {
        enabled: true,
        delta.changeDataCapture.automatic: true
    },
    internalName: #LOCAL
}
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE,
                                      #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET,
                                      #EXTRACTION_DATA_SOURCE
]
// Scope of this view is V_MARD_MD no aggreated fields should be added to this view.

define view I_ProductStorageLocationBasic
  as select from P_ProductStorageLocationBasic as StorageLocation

  association [1..1] to I_Product                as _Product         on  $projection.Product = _Product.Product
  association [0..1] to E_Productstoragelocation as _ProdStorLocExt  on  $projection.Product         = _ProdStorLocExt.Product
                                                                     and $projection.Plant           = _ProdStorLocExt.Plant
                                                                     and $projection.StorageLocation = _ProdStorLocExt.StorageLocation
  association [0..*] to I_MaterialStock          as _Stock           on  $projection.Product         = _Stock.Material
                                                                     and $projection.Plant           = _Stock.Plant
                                                                     and $projection.StorageLocation = _Stock.StorageLocation
  association [1..1] to I_Plant                  as _Plant           on  $projection.Plant = _Plant.Plant
  //Start: enterprise search help (ESH) related associations------------------------------------------------------------------------------------
  //These associations are required in I_ProductStorageLocation as N_ProductStorageLocation has these associations
  //There can be no associations in N_ProductStorageLocation which are not present in I_ProductStorageLocation
  association [1..1] to I_StorageLocation        as _StorageLocation on  $projection.Plant           = _StorageLocation.Plant
                                                                     and $projection.StorageLocation = _StorageLocation.StorageLocation
  //End of ESH related associations-------------------------------------------------------------------------------------------------------------
{
  key Product,
      @ObjectModel.foreignKey.association: '_Plant'
  key Plant,
      @ObjectModel.foreignKey.association: '_StorageLocation'
  key StorageLocation,
      WarehouseStorageBin,
      MaintenanceStatus,
      IsMarkedForDeletion,
      PhysicalInventoryBlockInd,
      CreationDate,
      DateOfLastPostedCntUnRstrcdStk,
      InventoryCorrectionFactor,
      InvtryRestrictedUseStockInd,
      InvtryCurrentYearStockInd,
      InvtryQualInspCurrentYrStkInd,
      InventoryBlockStockInd,
      InvtryRestStockPrevPeriodInd,
      InventoryStockPrevPeriod,
      InvtryStockQltyInspPrevPeriod,
      HasInvtryBlockStockPrevPeriod,
      FiscalYearCurrentInvtryPeriod,
      LeanWrhsManagementPickingArea,
      cast( 'X' as sdraft_is_active preserving type ) as IsActiveEntity,

      _Product,
      _Stock,
      _Plant,
      _StorageLocation //ESH related associations

}
