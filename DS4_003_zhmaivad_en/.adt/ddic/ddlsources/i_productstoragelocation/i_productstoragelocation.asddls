// Product Storage Location (active)
@AbapCatalog.sqlViewName: 'IPRDSTORAGELOC'
@VDM:{
  viewType: #BASIC,
  lifecycle: {
    status: #DEPRECATED,
    successor: 'I_ProductStorageLocationBasic'
  }
}
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Storage Location'
// performance related
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #XL
@ObjectModel.usageType.dataClass: #MIXED
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE,
                                      #CDS_MODELING_DATA_SOURCE,
                                      #CDS_MODELING_ASSOCIATION_TARGET
                                    ]

define view I_ProductStorageLocation
  as select from nsdm_e_mard as StorageLocation

  association [1..1] to I_Product                as _Product         on  $projection.Product = _Product.Product
  association [0..1] to E_Productstoragelocation as _ActiveExtension on  $projection.Product         = _ActiveExtension.Product
                                                                     and $projection.Plant           = _ActiveExtension.Plant
                                                                     and $projection.StorageLocation = _ActiveExtension.StorageLocation
  association [0..*] to I_MaterialStock          as _Stock           on  $projection.Product         = _Stock.Material
                                                                     and $projection.Plant           = _Stock.Plant
                                                                     and $projection.StorageLocation = _Stock.StorageLocation
  //Start: enterprise search help (ESH) related associations------------------------------------------------------------------------------------
  //These associations are required in I_ProductStorageLocation as N_ProductStorageLocation has these associations
  //There can be no associations in N_ProductStorageLocation which are not present in I_ProductStorageLocation
  association [1..1] to I_StorageLocation        as _StorageLocation on  $projection.Plant           = _StorageLocation.Plant
                                                                     and $projection.StorageLocation = _StorageLocation.StorageLocation
  //End of ESH related associations-------------------------------------------------------------------------------------------------------------

{

  key StorageLocation.matnr                           as Product,
  key StorageLocation.werks                           as Plant,
  key StorageLocation.lgort                           as StorageLocation,
      StorageLocation.lgpbe                           as WarehouseStorageBin,
      StorageLocation.pstat                           as MaintenanceStatus,
      StorageLocation.lvorm                           as IsMarkedForDeletion,
      StorageLocation.sperr                           as PhysicalInventoryBlockInd,
      StorageLocation.ersda                           as CreationDate,
      StorageLocation.dlinl                           as DateOfLastPostedCntUnRstrcdStk,
      StorageLocation.bskrf                           as InventoryCorrectionFactor,
      StorageLocation.kzile                           as InvtryRestrictedUseStockInd,
      StorageLocation.kzill                           as InvtryCurrentYearStockInd,
      StorageLocation.kzilq                           as InvtryQualInspCurrentYrStkInd,
      StorageLocation.kzils                           as InventoryBlockStockInd,
      StorageLocation.kzvle                           as InvtryRestStockPrevPeriodInd,
      StorageLocation.kzvll                           as InventoryStockPrevPeriod,
      StorageLocation.kzvlq                           as InvtryStockQltyInspPrevPeriod,
      StorageLocation.kzvls                           as HasInvtryBlockStockPrevPeriod,
      StorageLocation.lfgja                           as FiscalYearCurrentPeriod,
      StorageLocation.lfmon                           as FiscalMonthCurrentPeriod,
      StorageLocation.mdjin                           as FiscalYearCurrentInvtryPeriod,
      cast( 'X' as sdraft_is_active preserving type ) as IsActiveEntity, // to enbale extensibility in Draft 2.0
      //            StorageLocation.labst                     as VltdUnrestrictedUseStkQty -- deprecated field ATC error 26.4.16

      // New fields from MDG model, as part of unified API development
      StorageLocation.lwmkb                           as LeanWrhsManagementPickingArea,

      _Product,
      _Stock,

      //Start of ESH related associations---------------------------
      _StorageLocation
      //End of ESH related associations------------------------------
}
