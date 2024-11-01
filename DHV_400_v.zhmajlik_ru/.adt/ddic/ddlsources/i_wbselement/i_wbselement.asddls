@EndUserText.label: 'WBS Element Details'
@VDM.viewType: #BASIC
@Analytics: { dataCategory: #DIMENSION, dataExtraction.enabled: true }
@AbapCatalog.sqlViewName: 'IWBSElement'
@ObjectModel.representativeKey: 'WBSElement'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MIXED

define view I_WBSElement
  as select from    prps
    left outer join prte on  prps.pspnr = prte.posnr
                         and prps.psphi = prte.psphi
    left outer join /bic/tzwbs_desc as ltxt on prps.posid = ltxt./bic/zwbs_desc

  //association[1..1] to P_WBSElementStatus             as _WBSStatus                   on $projection.WBSElementInternalID = _WBSStatus.WBSElementInternalID
  association [1..1] to I_ProjectByInternalKey       as _Project                    on  $projection.ProjectInternalID = _Project.ProjectInternalID
  association [0..1] to I_UnitOfMeasure              as _BasicDurationUnit          on  $projection.BasicDurationUnit = _BasicDurationUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure              as _ActualDurationUnit         on  $projection.ActualDurationUnit = _ActualDurationUnit.UnitOfMeasure
  association [0..1] to I_UnitOfMeasure              as _ForecastedDurationUnit     on  $projection.ForecastedDurationUnit = _ForecastedDurationUnit.UnitOfMeasure
  association [1..1] to I_ControllingArea            as _ControllingArea            on  $projection.ControllingArea = _ControllingArea.ControllingArea
  association [1..1] to I_CompanyCode                as _CompanyCode                on  $projection.CompanyCode = _CompanyCode.CompanyCode
  association [1..*] to I_CostCenter                 as _CostCenter                 on  $projection.CostCenter      = _CostCenter.CostCenter
                                                                                    and $projection.ControllingArea = _CostCenter.ControllingArea
  association [1..1] to I_BusinessArea               as _BusinessArea               on  $projection.BusinessArea = _BusinessArea.BusinessArea
  association [1..1] to I_Plant                      as _Plant                      on  $projection.Plant = _Plant.Plant
  association [1..*] to I_ProfitCenter               as _ProfitCenter               on  $projection.ProfitCenter    = _ProfitCenter.ProfitCenter
                                                                                    and $projection.ControllingArea = _ProfitCenter.ControllingArea
  association [1..1] to I_ControllingObjectClass     as _ControllingObjectClass     on  $projection.ControllingObjectClass = _ControllingObjectClass.ControllingObjectClass
  association [1..1] to I_Projecttype                as _ProjectType                on  $projection.ProjectType = _ProjectType.ProjectType
  association [1..1] to I_Prioritycode               as _PriorityCode               on  $projection.PriorityCode = _PriorityCode.PriorityCode
  //association [0..*] to I_Wbselementtext             as _WBSElementLangBsdDesc      on  $projection.WBSElementObject = _WBSElementLangBsdDesc.WBSElementObject
  association [0..1] to I_Location                   as _Location                   on  $projection.Location = _Location.Location
                                                                                    and $projection.Plant    = _Location.Plant
  association [0..1] to I_Equipment                  as _Equipment                  on  $projection.Equipment = _Equipment.Equipment
  association [0..1] to I_FunctionalLocation         as _FunctionalLocation         on  $projection.FunctionalLocation = _FunctionalLocation.FunctionalLocation
  association [0..1] to I_FunctionalArea             as _FunctionalArea             on  $projection.FunctionalArea = _FunctionalArea.FunctionalArea
  association [0..1] to I_Interestcalculationprofile as _Interestcalculationprofile on  $projection.ProjInterestCalcProfile = _Interestcalculationprofile.ProjInterestCalcProfile
  association [0..1] to I_FactoryCalendar            as _FactoryCalendar            on  $projection.FactoryCalendar = _FactoryCalendar.FactoryCalendar
  association [0..1] to I_TaxJurisdiction            as _TaxJurisdiction            on  $projection.TaxJurisdiction = _TaxJurisdiction.TaxJurisdiction
                                                                                    and $projection.CostingSheet    = _TaxJurisdiction.TaxJurisdictionCalcProcedure
  association [1..1] to E_WBSElement                 as _Extension                  on  prps.posid = _Extension.WBSElement

{
      @ObjectModel.text.element: 'WBSDescription'
  key cast( prps.posid as ps_posid_edit )                                      as WBSElement,
      prps.posid_edit                                                          as WBSElementWithCodingMask,
      cast ( prps.pspnr as ps_posnr preserving type )                          as WBSElementInternalID,
      cast ( prps.psphi as ps_psphi preserving type )                          as ProjectInternalID,
      _Project.Project                                                         as Project,
      case
        when ltxt.txtlg is null then cast (prps.post1 as abap.char(1000))
        else cast(ltxt.txtlg as abap.char(1000)) end                           as WBSDescription,
//as ps_s4_post1 preserving type )   

      //@ObjectModel.text.association: '_WBSElementLangBsdDesc'
      prps.objnr                                                               as WBSElementObject,
      cast ( prps.ernam as ernam preserving type )                             as CreatedByUser,
      cast ( prps.erdat as erdat preserving type )                             as CreationDate,
      cast ( prps.aenam as ps_s4_aenam preserving type )                       as LastChangedByUser,
      cast ( prps.aedat as ps_s4_updat preserving type )                       as LastChangeDate,
      cast ( prps.vernr as ps_s4_vernr preserving type )                       as ResponsiblePerson,
      cast ( prps.verna as ps_s4_verna preserving type )                       as ResponsiblePersonName,
      cast ( prps.astnr as ps_s4_astnr preserving type )                       as ApplicantCode,
      prps.astna                                                               as ApplicantName,
      cast ( prps.pbukr as bukrs preserving type )                             as CompanyCode,
      cast ( prps.pgsbr as gsber preserving type )                             as BusinessArea,
      cast ( prps.pkokr as logbr_kokrs preserving type )                       as ControllingArea,
      prps.prctr                                                               as ProfitCenter,
      cast ( prps.prart as ps_s4_prart preserving type )                       as ProjectType,
      cast ( prps.plakz as ps_plakz preserving type )                          as WBSElementIsPlanningElement,
      cast ( prps.belkz as ps_s4_belkz preserving type )                       as WBSIsAccountAssignmentElement,
      cast ( prps.fakkz as ps_fakkz preserving type )                          as WBSElementIsBillingElement,
      prps.kalsm                                                               as CostingSheet,
      cast ( prps.akstl as ps_s4_akstl preserving type )                       as RequestingCostCenter,
      cast ( prps.fkstl as ps_s4_fkstl preserving type )                       as ResponsibleCostCenter,
      cast ( prps.fabkl as stkal preserving type )                             as FactoryCalendar,
      cast ( prps.pspri as nw_prio preserving type )                           as PriorityCode,
      cast ( prps.pwpos as ps_pwpos preserving type )                          as Currency,
      prps.werks                                                               as Plant,
      prps.slwid                                                               as FreeDefinedTableFieldSemantic,
      prps.xstat                                                               as WBSIsStatisticalWBSElement,
      cast( prps.txjcd as ps_s4_txjcd preserving type )                        as TaxJurisdiction,
      cast ( prps.plint as plint_t preserving type )                           as WBSIsMarkedForIntegratedPlng,
      cast ( prps.func_area as fkber preserving type )                         as FunctionalArea,
      prps.stort                                                               as Location,
      prps.equnr                                                               as Equipment,
      prps.tplnr                                                               as FunctionalLocation,
      prps.aennr                                                               as ProjectObjectChangeNumber,
      cast ( prps.adpsp as ps_s4_addcompare_core preserving type )             as ProjectObjectReferenceElement,
      prps.zschm                                                               as ProjInterestCalcProfile,
      prps.imprf                                                               as InvestmentProfile,
      cast ( case dats_is_valid( prte.pstrt )
                when 0
                then '00000000'
                else prte.pstrt
                end as ps_s4_pstrt preserving type )                           as BasicStartDate,
      cast ( case dats_is_valid( prte.estrt )
                when 0
                then '00000000'
                else prte.estrt
                end  as ps_s4_estrt preserving type )                          as ForecastedStartDate,

      cast ( case dats_is_valid ( prte.istrt )
                when 0
                then '00000000'
                else prte.istrt
                end as ps_s4_istrt preserving type )                           as ActualStartDate,

      cast ( case dats_is_valid( prte.pende )
                when 0
                then '00000000'
                else prte.pende
                end  as ps_s4_pende preserving type )                          as BasicEndDate,
      cast ( case dats_is_valid( prte.eende )
                when 0
                then '00000000'
                else prte.eende
                end  as ps_s4_eende preserving type )                          as ForecastedEndDate,
      cast ( case dats_is_valid( prte.iende )
                when 0
                then '00000000'
                else prte.iende
                end  as ps_s4_iende preserving type )                          as ActualEndDate,

      @Semantics.unitOfMeasure: true
      cast ( prte.ieinh as ps_ieinh preserving type )                          as ActualDurationUnit,
      @Semantics.unitOfMeasure: true
      cast ( prte.eeinh as ps_s4_eeinh preserving type )                       as ForecastedDurationUnit,
      @Semantics.unitOfMeasure: true
      cast ( prte.peinh as ps_s4_peinh preserving type )                       as BasicDurationUnit,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'BasicDurationUnit'
      cast ( prte.pdaur as ps_s4_pdaur preserving type )                       as BasicDuration,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'ForecastedDurationUnit'
      cast( prte.edaur as ps_s4_edaur preserving type )                        as ForecastedDuration,
      @DefaultAggregation: #NONE
      @Semantics.quantity.unitOfMeasure: 'ActualDurationUnit'
      cast ( prte.idaur as ps_s4_idaur preserving type )                       as ActualDuration,
      cast ( case dats_is_valid( prte.pstrm )
                when 0
                then '00000000'
                else prte.pstrm
                end  as ps_gstrs preserving type )                             as SchedldBasicEarliestStartDate,
      cast ( case dats_is_valid( prte.petrm )
                when 0
                then '00000000'
                else prte.petrm
                end  as ps_s4_gltrs preserving type )                          as ScheduledBasicLatestEndDate,
      cast ( case dats_is_valid( prte.estrm )
                when 0
                then '00000000'
                else prte.estrm
                end  as ps_s4_gstpp preserving type )                          as SchedldFcstdEarliestStartDate,
      cast ( case dats_is_valid( prte.eetrm )
                when 0
                then '00000000'
                else prte.eetrm
                end  as ps_s4_gltpp preserving type )                          as LatestSchedldFcstdEndDate,
      cast ( case dats_is_valid( prte.vistr )
                when 0
                then '00000000'
                else prte.vistr
                end  as ps_s4_istvorl preserving type )                        as TentativeActualStartDate,
      cast ( case dats_is_valid( prte.viend )
                when 0
                then '00000000'
                else prte.viend
                end  as ps_s4_ienvorl preserving type )                        as TentativeActualEndDate,
      case dats_is_valid( prte.pstrs )
                when 0
                then '00000000'
                else prte.pstrs
                end                                                            as SchedldBasicLatestStartDate,
      cast ( case dats_is_valid( prte.petrf )
                when 0
                then '00000000'
                else prte.petrf
                end  as ps_s4_getre preserving type )                          as SchedldBasicEarliestEndDate,
      cast ( case dats_is_valid( prte.estrs )
                when 0
                then '00000000'
                else prte.estrs
                end  as ps_s4_gstrp preserving type )                          as LatestSchedldFcstdStartDate,
      cast ( case dats_is_valid( prte.eetrf )
                when 0
                then '00000000'
                else prte.eetrf
                end  as ps_s4_gltrp preserving type )                          as SchedldFcstdEarliestEndDate,
      @EndUserText.label: 'Level' //annotation used since cast to abap.char(3) has no label and UI is showing field name as it is
      prps.stufe                                                               as WBSElementHierarchyLevel,
      cast ( prps.zschl as fin_ovhkey preserving type )                        as OverheadCode,
      cast ( prps.abgsl as psb_bo_abgr_schl_de preserving type )               as ResultAnalysisInternalID,
      @DefaultAggregation: #NONE
      cast ( prps.evgew as ev_weightd preserving type )                        as ProgressAnlysAggregationWeight,


      //Below fields not in excel for fields of WBS overview app
      prps.poski                                                               as WBSElementShortID,
      prps.akokr                                                               as ReqgCostCenterControllingArea,
      prps.fkokr                                                               as RespCostCenterControllingArea,
      prps.txtsp                                                               as Language,
      cast ( prps.kostl as ps_kostl preserving type )                          as CostCenter,
      prps.ktrg                                                                as CostObject,
      prps.clasf                                                               as WBSElementIsUsedInProjSmmry,
      cast( prps.loevm as ps_s4_loevm )                                        as IsMarkedForDeletion,
      prps.kzbws                                                               as InventorySpecialStockValnType,
      prps.fplnr                                                               as BillingPlan,
      prps.grpkz                                                               as WBSElementIsGroupingWBSElement,
      prps.klvar                                                               as CostingVariant,
      prps.vname                                                               as JointVenture,
      prps.recid                                                               as JointVentureRecoveryCode,
      prps.etype                                                               as JointVentureEquityType,
      cast ( prps.otype as jv_otype preserving type )                          as JointVentureObjectType,
      prps.jibcl                                                               as JointVentureClass,
      prps.jibsa                                                               as JointVentureSubClass,
      prte.flgvg                                                               as WBSElementHasActivities,
      prte.flgew                                                               as WBSHasFcstdDateFromActivity,
      prte.flgem                                                               as WBSHasFcstdDateSetManually,
      prte.flgvm                                                               as WBSHasBasicDateManuallySet,
      prte.flgim                                                               as WBSHasActualDateSetManually,
      prte.flgvi                                                               as WBSElmntHasActualDateFromActy,
      prps.scope                                                               as ControllingObjectClass,
      //Above fields not in excel for fields of WBS overview app





      // Following fields deprecated as per excel, but used in other views
      cast ( prps.usr00 as usr00prps preserving type )                         as FreeDefinedAttribute01,
      cast ( prps.usr01 as usr01prps preserving type )                         as FreeDefinedAttribute02,
      cast ( prps.usr02 as usr02prps preserving type )                         as FreeDefinedAttribute03,
      cast ( prps.usr03 as usr03prps preserving type )                         as FreeDefinedAttribute04,
      cast ( prps.usr04 as usr04prps preserving type )                         as FreeDefinedQuantity1,
      cast ( prps.use04 as use04prps preserving type )                         as FreeDefinedQuantity1Unit,
      cast ( prps.usr05 as usr05prps preserving type )                         as FreeDefinedQuantity2,
      cast ( prps.use05 as use05prps preserving type )                         as FreeDefinedQuantity2Unit,
      cast ( prps.usr06 as usr06prps preserving type )                         as FreeDefinedAmount1,
      cast ( prps.use06 as use06prps preserving type )                         as FreeDefinedAmount1Currency,
      cast ( prps.usr07 as usr07prps preserving type )                         as FreeDefinedAmount2,
      cast ( prps.use07 as use07prps preserving type )                         as FreeDefinedAmount2Currency,
      cast ( prps.usr08 as usr08prps preserving type )                         as FreeDefinedDate1,
      cast ( prps.usr09 as usr09prps preserving type )                         as FreeDefinedDate2,
      cast ( prps.usr10 as usr10prps preserving type )                         as FreeDefinedIndicator1,
      cast ( prps.usr11 as usr11prps preserving type )                         as FreeDefinedIndicator2,
      // Above fields deprecated as per excel


      _Project,
      _BasicDurationUnit,
      _ActualDurationUnit,
      _ForecastedDurationUnit,
      _ControllingArea,
      _Plant,
      _CostCenter,
      _BusinessArea,
      _CompanyCode,
      _ProfitCenter,
      _ControllingObjectClass,
      _ProjectType,
      _PriorityCode,
      //_WBSElementLangBsdDesc,
      _Location,
      _Equipment,
      _FunctionalLocation,
      _FunctionalArea,
      _Interestcalculationprofile,
      _FactoryCalendar,
      _TaxJurisdiction

}; 
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 