@AbapCatalog: {
sqlViewName: 'IPRDROOTSTORAGE2',
compiler.compareFilter: true,
preserveKey: true
}
@VDM.viewType: #BASIC
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product Storage'
@ObjectModel.representativeKey: 'Product'
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations:true
@Metadata.allowExtensions:true

@Analytics:{
    dataCategory: #DIMENSION,
    internalName: #LOCAL,
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture.automatic: true
    }
}


@ObjectModel.supportedCapabilities: [ #SQL_DATA_SOURCE,
                                     #CDS_MODELING_DATA_SOURCE,
                                     #CDS_MODELING_ASSOCIATION_TARGET,
                                      #EXTRACTION_DATA_SOURCE
]
@AccessControl.personalData.blocking: #NOT_REQUIRED

define view I_ProductStorage_2
  as select from mara
  association [1..1] to I_Product                      as _Product                       on $projection.Product = _Product.Product
  association [0..1] to E_Product                      as _ProdStorageExt                on $projection.Product = _ProdStorageExt.Product
  association [0..1] to I_Storagecondition             as _StorageCondition              on $projection.StorageConditions = _StorageCondition.StorageConditions
  association [0..1] to I_Tempindcndn                  as _TemperatureConditionInd       on $projection.TemperatureConditionInd = _TemperatureConditionInd.TemperatureConditionInd
  association [0..*] to I_Tempindcndntext              as _TemperatureConditionText      on $projection.TemperatureConditionInd = _TemperatureConditionText.TemperatureConditionInd
  association [0..1] to I_ShelfLifeExprtnDateRndngRule as _ShelfLifeExprtnDateRndngRule  on $projection.ShelfLifeExprtnDateRndngRule = _ShelfLifeExprtnDateRndngRule.ShelfLifeExprtnDateRndngRule
  association [0..1] to I_CtnRqmtsForProduct           as _StorageBinInstruction         on $projection.StorageBinInstruction = _StorageBinInstruction.StorageBinInstruction
  association [0..1] to I_LabelForm                    as _LabelForm                     on $projection.LabelForm = _LabelForm.LabelForm
  association [0..1] to I_ProdShelfLifeExprtnDtePerdVH as _ShelfLifeExpirationDatePeriod on $projection.ShelfLifeExpirationDatePeriod = _ShelfLifeExpirationDatePeriod.ShelfLifeExpirationDatePeriod
  association [0..1] to I_LabelType                    as _LabelType                     on $projection.LabelType = _LabelType.LabelType
  association [0..1] to I_ProductExpirationDateCode    as _ProductExpirationDateCode     on $projection.ProductExpirationDateCode = _ProductExpirationDateCode.ProductExpirationDateCode
  association [0..1] to I_UnitOfMeasure                as _BaseUnitOfMeasure             on $projection.BaseUnit = _BaseUnitOfMeasure.UnitOfMeasure
{
  key mara.matnr                                                          as Product,
      @ObjectModel.foreignKey.association:'_Storagecondition'
      mara.raube                                                          as StorageConditions,
      _StorageCondition,
      @ObjectModel.text.association: '_TemperatureConditionText'
      mara.tempb                                                          as TemperatureConditionInd,
      _TemperatureConditionInd,
      _TemperatureConditionText,
      mara.stoff                                                          as HazardousMaterialNumber,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      mara.wesch                                                          as NmbrOfGROrGISlipsToPrintQty,
      @ObjectModel.foreignKey.association:'_LabelType'
      mara.etiar                                                          as LabelType,
      @ObjectModel.foreignKey.association:'_LabelForm'
      mara.etifo                                                          as LabelForm,
      mara.mhdrz                                                          as MinRemainingShelfLife,
      @ObjectModel.foreignKey.association:'_ProductExpirationDateCode'
      mara.sled_bbd                                                       as ProductExpirationDateCode,

      //    Retail Field
      @ObjectModel.foreignKey.association:'_StorageBinInstruction'
      mara.behvo                                                          as StorageBinInstruction,
      _StorageBinInstruction,
      //      mara.mhdhb                                      as TotalShelfLife, //pstat changes
      mara.mhdlp                                                          as TotalShelfLifeStoragePercent,

      @ObjectModel.foreignKey.association:'_ShelfLifeExpirationDatePeriod'
      @ObjectModel.sapObjectNodeTypeReference:'ShelfLifeExpirationDatePeriod'
      cast(mara.iprkz as shelflifeexpirationdateperiod  preserving type ) as ShelfLifeExpirationDatePeriod,

      @ObjectModel.foreignKey.association:'_ShelfLifeExprtnDateRndngRule'
      mara.rdmhd                                                          as ShelfLifeExprtnDateRndngRule,
      mara.begru                                                          as AuthorizationGroup,
      cast( 'X' as sdraft_is_active preserving type )                     as IsActiveEntity, // to enbale extensibility in Draft 2.0
      mara.mhdhb                                                          as TotalShelfLife, // as per mdg model the field should be part of storage

      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_BaseUnitOfMeasure'
      mara.meins                                                          as BaseUnit,
      _ShelfLifeExprtnDateRndngRule,
      _LabelForm,
      _ShelfLifeExpirationDatePeriod,
      _LabelType,
      _ProductExpirationDateCode,
      _Product,
      _BaseUnitOfMeasure

}
