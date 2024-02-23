@AbapCatalog:{
    sqlViewName: 'PPRDSTORLOCBASIC',
    compiler.compareFilter: true,
    preserveKey: true
}
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations:true
@ObjectModel:{
    usageType.serviceQuality: #A,
    usageType.sizeCategory : #XL,
    usageType.dataClass: #MASTER
}
@VDM.viewType: #BASIC
@VDM.private: true

// Scope of this view is V_MBEW_MD no fields from redirect views should be added
define view P_ProductStorageLocationBasic
  as select from mard as StorageLocation
  association [1..1] to I_Product as _Product on $projection.Product = _Product.Product
{

  key cast ( StorageLocation.matnr as productnumber preserving type ) as Product,
  key StorageLocation.werks                                           as Plant,
  key StorageLocation.lgort                                           as StorageLocation,
      StorageLocation.pstat                                           as MaintenanceStatus,
      StorageLocation.lvorm                                           as IsMarkedForDeletion,
      StorageLocation.sperr                                           as PhysicalInventoryBlockInd,
      StorageLocation.kzill                                           as InvtryCurrentYearStockInd,
      StorageLocation.kzilq                                           as InvtryQualInspCurrentYrStkInd,
      StorageLocation.kzile                                           as InvtryRestrictedUseStockInd,
      StorageLocation.kzils                                           as InventoryBlockStockInd,
      StorageLocation.kzvll                                           as InventoryStockPrevPeriod,
      StorageLocation.kzvlq                                           as InvtryStockQltyInspPrevPeriod,
      StorageLocation.kzvle                                           as InvtryRestStockPrevPeriodInd,
      StorageLocation.kzvls                                           as HasInvtryBlockStockPrevPeriod,
      StorageLocation.diskz                                           as StorLocMRP,
      StorageLocation.lsobs                                           as StorLocSpecialProcurementType,
      StorageLocation.lbstf                                           as StorLocMRPReplnmtQtyInBaseUoM,
      StorageLocation.herkl                                           as CountryOfOrigin,
      StorageLocation.lgpbe                                           as WarehouseStorageBin,
      StorageLocation.dlinl                                           as DateOfLastPostedCntUnRstrcdStk,
      StorageLocation.ersda                                           as CreationDate,
      StorageLocation.lwmkb                                           as LeanWrhsManagementPickingArea,
      StorageLocation.bskrf                                           as InventoryCorrectionFactor,
      StorageLocation.mdjin                                           as FiscalYearCurrentInvtryPeriod,

      _Product

}
