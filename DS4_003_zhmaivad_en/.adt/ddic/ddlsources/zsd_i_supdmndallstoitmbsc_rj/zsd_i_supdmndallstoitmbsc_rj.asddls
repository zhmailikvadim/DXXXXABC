/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.01.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 04.04.2023 | 19667     : SD_Feature - [Defect]-Feature - SDO  Enhance *
*              |            | DS4K949084                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic View for Stock Transport Order'
define view entity zsd_i_supdmndallstoitmbsc_rj
  as select from    ekko                           as ekko
    inner join      ekpo                           as ekpo                 on ekko.ebeln = ekpo.ebeln
    inner join      eket                           as eket                 on  ekpo.ebeln = eket.ebeln
                                                                           and ekpo.ebelp = eket.ebelp
    left outer join I_PurchasingDocumentShipping   as shipping             on  ekpo.ebeln = shipping.PurchasingDocument
                                                                           and ekpo.ebelp = shipping.PurchasingDocumentItem
    inner join      ZSD_I_SUPDMNDMATERIALPLANT     as marc                 on  ekpo.matnr = marc.Material
                                                                           and ekko.reswk = marc.Plant
    left outer join ZPE_I_HM( iv_id: '0000000789') as Language             on Language.sequence = '001'
    left outer join ZSD_I_SupDmndSalesArea         as SalesArea            on  shipping.ShipToParty          = SalesArea.Customer
                                                                           and shipping.SalesOrganization    = SalesArea.SalesOrganization
                                                                           and shipping.DistributionChannel  = SalesArea.DistributionChannel
                                                                           and shipping.OrganizationDivision = SalesArea.OrganizationDivision
    left outer join I_ProductSalesDelivery         as ProductSalesDelivery on  ekpo.matnr                   = ProductSalesDelivery.Product
                                                                           and shipping.SalesOrganization   = ProductSalesDelivery.ProductSalesOrg
                                                                           and shipping.DistributionChannel = ProductSalesDelivery.ProductDistributionChnl
  association [0..1] to I_SalesDocumentRjcnReasonText as _RejectionReasonText on  $projection.SalesDocumentRjcnReason = _RejectionReasonText.SalesDocumentRjcnReason
                                                                              and $projection.Language                = _RejectionReasonText.Language
{
  ekpo.ebeln                                as RequirementDocumentNumber,
  lpad(ekpo.ebelp,6,'0')                    as RequirementDocumentItem,
  'U1'                                      as RequirementType,
  eket.arun_req_dlvdate                     as RequestedDate,
  case
    when eket.mbdat = '00000000'
    then eket.dat01
    else eket.mbdat
  end                                       as ProductAvailabilityDate,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  eket.menge                                as ScheduleLineOrderQuantity,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  eket.mng02                                as ConfdOrderQtyByMatlAvailCheck,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  eket.glmng                                as DeliveredQuantityInBaseUnit,
  ekpo.meins                                as BaseUnit,
  ekpo.matnr                                as Material,
  ekpo.matkl                                as MaterialGroup,
  ekko.reswk                                as Plant,
  ekko.bsart                                as OrderType,
  ekko.aedat                                as LastChangeDate,
  marc.CrossPlantConfigurableProduct,
  marc.MaterialType,
  ekpo.sgt_rcat                             as RequirementSegment,
  ekko.ekorg                                as PurchasingOrganization,
  ekko.ekgrp                                as PurchasingGroup,
  shipping.SalesOrganization                as SalesOrganization,
  shipping.DistributionChannel              as DistributionChannel,
  shipping.OrganizationDivision             as Division,
  SalesArea.SalesDistrict                   as SalesDistrict,
  shipping.ShipToParty                      as SoldToParty,
  ekpo.bukrs                                as CompanyCode,
  ekpo.lgort                                as StorageLocation,
  ekko.frgzu                                as PurgReleaseSequenceStatus,
  @Semantics.amount.currencyCode: 'DocumentCurrency'
  ekpo.netpr                                as NetPriceAmount,
  ekko.waers                                as DocumentCurrency,
  marc.SegmentationStrategy,
  marc.SegmentationStrategyScope,
  shipping._PurchasingDocument.Supplier     as Vendor,
  ekpo.fsh_collection                       as ProductCollection,
  eket.zz1_zcsd                             as ConfirmedShelvedDate,
  ekko.ernam                                as CreatedByUser,
  SalesArea.CustomerGroup,
  SalesArea.AdditionalCustomerGroup1,
  SalesArea.AdditionalCustomerGroup5,
  SalesArea.AdditionalCustomerGroup6,
  ekko.zz1_delivery_prio_pdh                as DeliveryPriority,
  ProductSalesDelivery.ProductSalesStatus   as DistribChainSpecifMatStat,
  ekpo.ean11                                as EAN,
  ekpo.wrf_charstc2                         as ProductCharacteristic2,
  ekpo.txz01                                as SalesDocumentItemText,
  shipping._ShipToParty.OrganizationBPName1 as SoldToPartyName,
  @DefaultAggregation: #SUM
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  ekpo.netwr                                as NetAmount,
  ekko.waers                                as TransactionCurrency,
  ekko.zz1_zorderreason_pdh                 as SDDocumentReason,
  shipping.PlannedDeliveryDuration          as PlannedDeliveryTime,
  ekko.bsart                                as PurchaseOrderType,
  ekko.bstyp                                as PurchaseOrderCategory,
  @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
  ekpo.menge                                as OrderQuantity,
  ekpo.meins                                as OrderQuantityUnit,
  ekko.zz1_zrsd_pdh                         as RequestedShelfDate,
  eket.etenr                                as ScheduleLine,
  ekpo.fsh_season                           as ProductSeason,
  ekpo.fsh_season_year                      as ProductSeasonYear,
  ekpo.evers                                as ShippingInstruction,
  shipping.ShipToParty,
  shipping._ShipToParty.OrganizationBPName1 as ShipToPartyName,
  ekpo.creationdate                         as CreationDate,
  ekpo.fsh_theme                            as ProductTheme,
  marc._EANs.ean11                          as UPC,
  shipping.ShippingPoint,
  ekpo.zz1_abgru_pdi                        as SalesDocumentRjcnReason,
  Language.field1                           as Language,
  _RejectionReasonText.SalesDocumentRjcnReasonName
}
where
      ekko.reswk         <> '' -- Supplying Plant should be present
  and(
      ekko.loekz != 'X'
  ) -- deletion indicator
  and ekko.iseopblocked  =  ''
  and ekpo.zz1_abgru_pdi is not initial
