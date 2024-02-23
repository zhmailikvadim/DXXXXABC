@AbapCatalog:{
    sqlViewName: 'PPRDVALUATION',
    compiler.compareFilter: true,
    preserveKey: true
}
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations:true
@ObjectModel:{
    usageType.serviceQuality: #A,
    usageType.sizeCategory : #L,
    usageType.dataClass: #MASTER
}
@VDM.viewType: #BASIC
@VDM.private: true

// Scope of this view is V_MBEW _MD no fields from redirect views should be added
define view P_ProductValuationBasic
  as select from mbew as Valuation
  association [1..1] to I_Product as _Product on $projection.Product = _Product.Product
{


  key cast ( Valuation.matnr as productnumber preserving type )              as Product,
  key Valuation.bwkey                                                        as ValuationArea,
  key Valuation.bwtar                                                        as ValuationType,
      Valuation.lvorm                                                        as IsMarkedForDeletion,
      cast (Valuation.vprsv as inventoryvaluationprocedure preserving type ) as InventoryValuationProcedure,
      Valuation.verpr                                                        as MovingAveragePrice,
      Valuation.stprs                                                        as StandardPrice,
      Valuation.peinh                                                        as PriceUnitQty,
      Valuation.bklas                                                        as ValuationClass,
      Valuation.vmstp                                                        as DairyPrevPerdStandardPrice,
      Valuation.vmpei                                                        as PriceUnitPrevPeriod,
      Valuation.vmbkl                                                        as ValuationClassInPrevPeriod,
      Valuation.vjstp                                                        as StandardPricePrevYear,
      Valuation.vjbkl                                                        as ValuationClassInPrevYear,
      Valuation.lfgja                                                        as FiscalYearCurrentPeriod,
      Valuation.lfmon                                                        as FiscalMonthCurrentPeriod,
      Valuation.bwtty                                                        as ValuationCategory,
      Valuation.stprv                                                        as PrevInvtryPriceInCoCodeCrcy,
      Valuation.laepr                                                        as PriceLastChangeDate,
      Valuation.zkprs                                                        as FuturePrice,
      Valuation.zkdat                                                        as FuturePriceValidityStartDate,
      Valuation.bwprs                                                        as TaxPricel1InCoCodeCrcy,
      Valuation.bwprh                                                        as CommercialPrice1InCoCodeCrcy,
      Valuation.vjbws                                                        as TaxPrice3InCoCodeCrcy,
      Valuation.vjbwh                                                        as CommercialPrice3InCoCodeCrcy,
      Valuation.zplpr                                                        as PlannedPrice,
      Valuation.zplp1                                                        as PlannedPrice1InCoCodeCrcy,
      Valuation.zplp2                                                        as PlannedPrice2InCoCodeCrcy,
      Valuation.zplp3                                                        as PlannedPrice3InCoCodeCrcy,
      Valuation.zpld1                                                        as FuturePlndPrice1ValdtyDate,
      Valuation.zpld2                                                        as FuturePlndPrice2ValdtyDate,
      Valuation.zpld3                                                        as FuturePlndPrice3ValdtyDate,
      Valuation.pperl                                                        as ProdSpecCompUpperLimitQuantity,
      Valuation.pperv                                                        as PCEctxPHScaleUprValTxt,
      Valuation.kalkz                                                        as OperationIsIncludedInCosting,
      Valuation.kalkl                                                        as HasStdCostEstForCurrentPeriod,
      Valuation.kalkv                                                        as HasStdCostEstForPreviousPeriod,
      cast (Valuation.xlifo  as boole_d preserving type)                     as IsLIFOAndFIFORelevant,
      Valuation.mypol                                                        as LIFOValuationPoolNumber,
      Valuation.bwph1                                                        as CommercialPrice2InCoCodeCrcy,
      Valuation.bwps1                                                        as TaxPrice2InCoCodeCrcy,
      Valuation.abwkz                                                        as DevaluationYearCount,
      Valuation.pstat                                                        as MaintenanceStatus,
      Valuation.kaln1                                                        as ProdCostEstNumber,
      Valuation.kalnr                                                        as CostEstimateNumberOfOutput,
      Valuation.bwva1                                                        as FutrCostEstValuationVariant,
      Valuation.bwva2                                                        as CurCostEstValuationVariant,
      Valuation.bwva3                                                        as PrevCostEstValuationVariant,
      Valuation.vers1                                                        as FutureCostEstCostingVersion,
      Valuation.vers2                                                        as CurrentCostEstCostingVersion,
      Valuation.vers3                                                        as PreviousCostEstCostingVersion,
      Valuation.hrkft                                                        as CostOriginGroup,
      Valuation.kosgr                                                        as CostingOverheadGroup,
      Valuation.pprdz                                                        as FutureCostEstimateFiscalPeriod,
      Valuation.pprdl                                                        as CurrentCostEstFiscalPeriod,
      Valuation.pprdv                                                        as PreviousCostEstFiscalPeriod,
      Valuation.pdatz                                                        as FutureCostEstFiscalYear,
      Valuation.pdatl                                                        as CurrentCostEstFiscalYear,
      Valuation.pdatv                                                        as PreviousCostEstFiscalYear,
      Valuation.ekalr                                                        as IsMaterialCostedWithQtyStruc,
      Valuation.vplpr                                                        as PreviousPlanPriceInCoCodeCrcy,
      Valuation.mlast                                                        as PriceDeterminationControl,
      Valuation.lplpr                                                        as DairyCurrentPlannedPrice,
      Valuation.hkmat                                                        as IsMaterialRelatedOrigin,
      Valuation.bwspa                                                        as ValuationMargin,
      Valuation.lplpx                                                        as FxdPortnOfPlanPrcInCoCodeCrcy,
      Valuation.vplpx                                                        as FxdPortOfPrevPlPrcInCoCodeCrcy,
      Valuation.lbwst                                                        as CurPlanProjSlsOrdValnStrategy,
      Valuation.vbwst                                                        as PrevPlanProjSlsOrdValnStrategy,
      Valuation.eklas                                                        as ValuationClassSalesOrderStock,
      Valuation.qklas                                                        as ProjectStockValuationClass,
      cast (Valuation.mtuse    as productusagetype  preserving type )        as ProductUsageType,
      cast (Valuation.mtorg    as productorigintype preserving type )        as ProductOriginType,
      Valuation.ownpr                                                        as IsProducedInhouse,
      Valuation.bwpei                                                        as TaxBasedPricesPriceUnitQty,
      Valuation.mlmaa                                                        as MLIsActiveAtProductLevel,

      _Product

}
