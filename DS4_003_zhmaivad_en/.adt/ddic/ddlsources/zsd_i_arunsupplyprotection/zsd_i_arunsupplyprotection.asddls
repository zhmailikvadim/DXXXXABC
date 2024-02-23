/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SHNIPALI     | 02.12.2022 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl: {
  authorizationCheck: #CHECK
}
@EndUserText.label: 'I_ARunSupplyProtection Custom View'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel: {
   usageType: {
     dataClass:      #MASTER,
     serviceQuality: #C,
     sizeCategory:   #L
   }
}
define view entity ZSD_I_ARunSupplyProtection
  as select from            sup_object                   as SupProt
    inner join              I_SupDmndMaterialPlant       as MaterialPlant     on  SupProt.material = MaterialPlant.Material
                                                                              and SupProt.plant    = MaterialPlant.Plant
    left outer to many join sup_cvc                      as SupProtGroup      on SupProt.uuid = SupProtGroup.supobjectuuid
    left outer to many join I_SupplyProtectionTimeBucket as SupProtTimeBucket on SupProtGroup.uuid = SupProtTimeBucket.SupplyProtectionGroupUUID
  association [1..1] to I_ProdAllocCharcCatalogPath as _SupProtCharc01 on  $projection.SupProtCharc01CtlgPathUUID       = _SupProtCharc01.ProdAllocCharcCtlgPathUUID
                                                                       and _SupProtCharc01.ABAPDataElement              = 'SGT_RCAT'   //Requirment Segment
                                                                       and _SupProtCharc01.ProdAllocCharcCatalogUseType = '05'         //Supply Protection
                                                                       and MaterialPlant.SegmentationStrategy           is not initial //Relevant for Segmentation
  association [1..1] to I_ProdAllocCharcCatalogPath as _SupProtCharc02 on  $projection.SupProtCharc02CtlgPathUUID       = _SupProtCharc02.ProdAllocCharcCtlgPathUUID
                                                                       and _SupProtCharc02.ABAPDataElement              = 'SGT_RCAT'
                                                                       and _SupProtCharc02.ProdAllocCharcCatalogUseType = '05'
                                                                       and MaterialPlant.SegmentationStrategy           is not initial
  association [1..1] to I_ProdAllocCharcCatalogPath as _SupProtCharc03 on  $projection.SupProtCharc03CtlgPathUUID       = _SupProtCharc03.ProdAllocCharcCtlgPathUUID
                                                                       and _SupProtCharc03.ABAPDataElement              = 'SGT_RCAT'
                                                                       and _SupProtCharc03.ProdAllocCharcCatalogUseType = '05'
                                                                       and MaterialPlant.SegmentationStrategy           is not initial
  association [1..1] to I_ProdAllocCharcCatalogPath as _SupProtCharc04 on  $projection.SupProtCharc04CtlgPathUUID       = _SupProtCharc04.ProdAllocCharcCtlgPathUUID
                                                                       and _SupProtCharc04.ABAPDataElement              = 'SGT_RCAT'
                                                                       and _SupProtCharc04.ProdAllocCharcCatalogUseType = '05'
                                                                       and MaterialPlant.SegmentationStrategy           is not initial
  association [1..1] to I_ProdAllocCharcCatalogPath as _SupProtCharc05 on  $projection.SupProtCharc05CtlgPathUUID       = _SupProtCharc05.ProdAllocCharcCtlgPathUUID
                                                                       and _SupProtCharc05.ABAPDataElement              = 'SGT_RCAT'
                                                                       and _SupProtCharc05.ProdAllocCharcCatalogUseType = '05'
                                                                       and MaterialPlant.SegmentationStrategy           is not initial
  association [1..1] to I_ProdAllocCharcCatalogPath as _SupProtCharc06 on  $projection.SupProtCharc06CtlgPathUUID       = _SupProtCharc06.ProdAllocCharcCtlgPathUUID
                                                                       and _SupProtCharc06.ABAPDataElement              = 'SGT_RCAT'
                                                                       and _SupProtCharc06.ProdAllocCharcCatalogUseType = '05'
                                                                       and MaterialPlant.SegmentationStrategy           is not initial
  association [1..1] to I_ProdAllocCharcCatalogPath as _SupProtCharc07 on  $projection.SupProtCharc07CtlgPathUUID       = _SupProtCharc07.ProdAllocCharcCtlgPathUUID
                                                                       and _SupProtCharc07.ABAPDataElement              = 'SGT_RCAT'
                                                                       and _SupProtCharc07.ProdAllocCharcCatalogUseType = '05'
                                                                       and MaterialPlant.SegmentationStrategy           is not initial
  association [1..1] to I_ProdAllocCharcCatalogPath as _SupProtCharc08 on  $projection.SupProtCharc08CtlgPathUUID       = _SupProtCharc08.ProdAllocCharcCtlgPathUUID
                                                                       and _SupProtCharc08.ABAPDataElement              = 'SGT_RCAT'
                                                                       and _SupProtCharc08.ProdAllocCharcCatalogUseType = '05'
                                                                       and MaterialPlant.SegmentationStrategy           is not initial
  association [1..1] to I_ProdAllocCharcCatalogPath as _SupProtCharc09 on  $projection.SupProtCharc09CtlgPathUUID       = _SupProtCharc09.ProdAllocCharcCtlgPathUUID
                                                                       and _SupProtCharc09.ABAPDataElement              = 'SGT_RCAT'
                                                                       and _SupProtCharc09.ProdAllocCharcCatalogUseType = '05'
                                                                       and MaterialPlant.SegmentationStrategy           is not initial
  association [1..1] to I_ProdAllocCharcCatalogPath as _SupProtCharc10 on  $projection.SupProtCharc10CtlgPathUUID       = _SupProtCharc10.ProdAllocCharcCtlgPathUUID
                                                                       and _SupProtCharc10.ABAPDataElement              = 'SGT_RCAT'
                                                                       and _SupProtCharc10.ProdAllocCharcCatalogUseType = '05'
                                                                       and MaterialPlant.SegmentationStrategy           is not initial
{

  key SupProtTimeBucket.SupProtTimeBucketUUID,
      SupProt.name                        as SupplyProtectionName,
      SupProt.material                    as Material,
      SupProt.plant                       as Plant,
      SupProt.status                      as SupProtLifecycleStatus,
      // RequestedDeliveryDate ==> Start Date will be considered
      cast(tstmp_to_dats( cast( SupProtTimeBucket.SupProtPeriodStartUTCDateTime as tzntstmps), 'UTC', $session.client, 'NULL' )
      as vdm_v_start_date)                as ProductAvailabilityDate,
      cast(tstmp_to_dats( cast( SupProtTimeBucket.SupProtPeriodStartUTCDateTime as tzntstmps), 'UTC', $session.client, 'NULL' )
      as vdm_v_start_date)                as RequestedDeliveryDate,
      cast(tstmp_to_dats( cast( SupProtTimeBucket.SupProtPeriodStartUTCDateTime as tzntstmps), 'UTC', $session.client, 'NULL' )
      as vdm_v_start_date)                as StartDate,
      cast(tstmp_to_dats( cast( SupProtTimeBucket.SupProtPeriodEndUTCDateTime as tzntstmps),'UTC', $session.client, 'NULL' )
      as vdm_v_end_date)                  as EndDate,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      SupProtTimeBucket.SupProtProtectedQuantity,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      SupProtTimeBucket.SupProtConsumedQuantity,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      case
        when SupProtTimeBucket.SupProtConsumedQuantity > 0
          then
            case
              when SupProtTimeBucket.SupProtProtectedQuantity > SupProtTimeBucket.SupProtConsumedQuantity
                then ( SupProtTimeBucket.SupProtProtectedQuantity - SupProtTimeBucket.SupProtConsumedQuantity )
              else cast(0 as abap.quan(15,3) )
            end
          else  SupProtTimeBucket.SupProtProtectedQuantity
      end                                 as ARunSupProtUnconsumedQty,
      SupProtTimeBucket.SupProtProtectedQuantityUnit,
      SupProtTimeBucket.UnitOfMeasure     as BaseUnit,
      'SP'                                as RequirementType,
      MaterialPlant.MaterialGroup,
      MaterialPlant.MaterialType,
      MaterialPlant.CrossPlantConfigurableProduct,
      MaterialPlant.SegmentationStrategy,
      MaterialPlant.SegmentationStrategyScope,
      case
        when _SupProtCharc01.ProdAllocCharcCatalogType <> ''
          then cast( SupProtGroup.characteristic01 as sgt_rcat )
        when _SupProtCharc02.ProdAllocCharcCatalogType <> ''
          then cast( SupProtGroup.characteristic02 as sgt_rcat )
        when _SupProtCharc03.ProdAllocCharcCatalogType <> ''
          then cast( SupProtGroup.characteristic03 as sgt_rcat )
        when _SupProtCharc04.ProdAllocCharcCatalogType <> ''
          then cast( SupProtGroup.characteristic04 as sgt_rcat )
        when _SupProtCharc05.ProdAllocCharcCatalogType <> ''
          then cast( SupProtGroup.characteristic05 as sgt_rcat )
        when _SupProtCharc06.ProdAllocCharcCatalogType <> ''
          then cast( SupProtGroup.characteristic06 as sgt_rcat )
        when _SupProtCharc07.ProdAllocCharcCatalogType <> ''
          then cast( SupProtGroup.characteristic07 as sgt_rcat )
        when _SupProtCharc08.ProdAllocCharcCatalogType <> ''
          then cast( SupProtGroup.characteristic08 as sgt_rcat )
        when _SupProtCharc09.ProdAllocCharcCatalogType <> ''
          then cast( SupProtGroup.characteristic09 as sgt_rcat )
        when _SupProtCharc10.ProdAllocCharcCatalogType <> ''
          then cast( SupProtGroup.characteristic10 as sgt_rcat )
        else cast ( '' as sgt_rcat )
      end                                 as RequirementSegment,
      SupProt.uuid                        as SupplyProtectionUUID,
      SupProtGroup.uuid                   as SupplyProtectionGroupUUID,
      SupProtGroup.cvcpriority            as SupProtGroupPriorityValue,
      SupProtGroup.charc01catalogpathuuid as SupProtCharc01CtlgPathUUID,
      SupProtGroup.charc01catalogpathid   as SupProtCharc01CtlgPathIntID,
      SupProtGroup.characteristic01       as SupProtCharc01ValueID,
      SupProtGroup.charc02catalogpathuuid as SupProtCharc02CtlgPathUUID,
      SupProtGroup.charc01catalogpathid   as SupProtCharc02CtlgPathIntID,
      SupProtGroup.characteristic02       as SupProtCharc02ValueID,
      SupProtGroup.charc03catalogpathuuid as SupProtCharc03CtlgPathUUID,
      SupProtGroup.charc01catalogpathid   as SupProtCharc03CtlgPathIntID,
      SupProtGroup.characteristic03       as SupProtCharc03ValueID,
      SupProtGroup.charc04catalogpathuuid as SupProtCharc04CtlgPathUUID,
      SupProtGroup.charc01catalogpathid   as SupProtCharc04CtlgPathIntID,
      SupProtGroup.characteristic04       as SupProtCharc04ValueID,
      SupProtGroup.charc05catalogpathuuid as SupProtCharc05CtlgPathUUID,
      SupProtGroup.charc01catalogpathid   as SupProtCharc05CtlgPathIntID,
      SupProtGroup.characteristic05       as SupProtCharc05ValueID,
      SupProtGroup.charc06catalogpathuuid as SupProtCharc06CtlgPathUUID,
      SupProtGroup.charc01catalogpathid   as SupProtCharc06CtlgPathIntID,
      SupProtGroup.characteristic06       as SupProtCharc06ValueID,
      SupProtGroup.charc07catalogpathuuid as SupProtCharc07CtlgPathUUID,
      SupProtGroup.charc01catalogpathid   as SupProtCharc07CtlgPathIntID,
      SupProtGroup.characteristic07       as SupProtCharc07ValueID,
      SupProtGroup.charc08catalogpathuuid as SupProtCharc08CtlgPathUUID,
      SupProtGroup.charc01catalogpathid   as SupProtCharc08CtlgPathIntID,
      SupProtGroup.characteristic08       as SupProtCharc08ValueID,
      SupProtGroup.charc09catalogpathuuid as SupProtCharc09CtlgPathUUID,
      SupProtGroup.charc01catalogpathid   as SupProtCharc09CtlgPathIntID,
      SupProtGroup.characteristic09       as SupProtCharc09ValueID,
      SupProtGroup.charc10catalogpathuuid as SupProtCharc10CtlgPathUUID,
      SupProtGroup.charc01catalogpathid   as SupProtCharc10CtlgPathIntID,
      SupProtGroup.characteristic10       as SupProtCharc10ValueID,
      SupProt.createdbyuser               as CreatedByUser,
      MaterialPlant.EAN,
      MaterialPlant._EANs.ean11           as UPC,
      MaterialPlant[inner].PlannedDeliveryTime
}
where
  SupProt.status <> '03' -- Deactivated
