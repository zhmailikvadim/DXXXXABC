@AbapCatalog.sqlViewName: 'APRODSTORAGELOC'
@AbapCatalog.compiler.compareFilter: true
@EndUserText.label: 'Storage Location Data'
@AccessControl.authorizationCheck: #CHECK
@VDM.viewType:#COMPOSITE
@VDM.lifecycle.contract.type: #PUBLIC_REMOTE_API
@Metadata.ignorePropagatedAnnotations:true
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.createEnabled: true
@ObjectModel.updateEnabled: true
//@ObjectModel.deleteEnabled: true



define view A_ProductStorageLocation
  as select from I_ProductStorageLocation as StorageLocation
  association [0..1] to E_Productstoragelocation as _StorageLocationExt on  $projection.Product         = _StorageLocationExt.Product
                                                                        and $projection.Plant           = _StorageLocationExt.Plant
                                                                        and $projection.StorageLocation = _StorageLocationExt.StorageLocation

  association [1..1] to A_Product                as _Product            on  $projection.Product = _Product.Product
{

  key    Product,
  key    Plant,
         @ObjectModel.sapObjectNodeTypeReference:'StorageLocation'
  key    StorageLocation,
         WarehouseStorageBin,
         @ObjectModel.readOnly: true
         MaintenanceStatus,
         PhysicalInventoryBlockInd,
         @ObjectModel.readOnly: true
         CreationDate,
         IsMarkedForDeletion,
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
         FiscalYearCurrentPeriod,
         FiscalMonthCurrentPeriod,
         FiscalYearCurrentInvtryPeriod,
         //         new field as part of 2005 release
         LeanWrhsManagementPickingArea,
         _Product


}
