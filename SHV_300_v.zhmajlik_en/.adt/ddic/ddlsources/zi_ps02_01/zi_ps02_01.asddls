@AbapCatalog.sqlViewName: 'ZI_PS0201'
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #COMPOSITE
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZACDOCATEST'
@Analytics: { dataCategory: #CUBE, dataExtraction.enabled: true }
define view ZI_PS02_01

 with parameters 
//   @Environment.systemField: #CLIENT
//    p_clnt : abap.clnt,  
    p_period: fis_jahrper,
    p_period1: fis_jahrper, 
    
    P_fromdate : dats,
    P_todate   : dats,
    P_period2  : poper,
                           //  P_date     : dats,
    P_year     : gjahr,
    
    p_bukrs_low  : bukrs,      // AK_BUTVILOVS #36910 Работы по параметризации источников данных 
    p_bukrs_high : bukrs       // AK_BUTVILOVS #36910 Работы по параметризации источников данных 
           
as select from ZP_PS02_01 ( p_period     : $parameters.p_period,   
                            p_period1    : $parameters.p_period1,
                            P_fromdate   : $parameters.P_fromdate,
                            P_todate     : $parameters.P_todate,
                            P_period2    : $parameters.P_period2,
                            P_year       : $parameters.P_year,
                            p_bukrs_low  : $parameters.p_bukrs_low,        // AK_BUTVILOVS #36910 Работы по параметризации источников данных
                            p_bukrs_high : $parameters.p_bukrs_high        // AK_BUTVILOVS #36910 Работы по параметризации источников данных
                           ) as zt 
left outer join ZP_PS02_04 (p_clnt     : $session.client,
                            p_period   : $parameters.p_period, 
                            p_period1  : $parameters.p_period1,
                            p_bukrs_low  : $parameters.p_bukrs_low,        // AK_BUTVILOVS #36910 Работы по параметризации источников данных
                            p_bukrs_high : $parameters.p_bukrs_high        // AK_BUTVILOVS #36910 Работы по параметризации источников данных
                           ) as zp4 on zp4.objnr = zt.objnr
left outer join tvarvc as v
                on zt.mandt = v.mandt
               and zt.anbwa = v.low
               and ( v.name = 'ZAA_BWASL_PARTNER' or v.name = 'ZAA_BWASL_RET_PARTNER' )
                                  
association [1]    to ZI_WBS_FIAA                    as _WBSElement            on  $projection.WBSElement = _WBSElement.WBSElement
association [0..1] to I_GLAccountInChartOfAccounts   as _GLAccount             on  $projection.ChartOfAccounts = _GLAccount.ChartOfAccounts
                                                                               and $projection.GLAccount = _GLAccount.GLAccount
association [1]    to I_DebitCreditCode              as _DebitCreditCode       on  $projection.DebitCreditCode = _DebitCreditCode.DebitCreditCode
association [1]    to I_ChartOfAccounts              as _ChartOfAccounts       on  $projection.ChartOfAccounts = _ChartOfAccounts.ChartOfAccounts
association [1]    to I_DepreciationArea             as _DepreciationArea      on  $projection.ChartOfDepreciation= _DepreciationArea.ChartOfDepreciation 
                                                                               and $projection.AssetDepreciationArea = _DepreciationArea.AssetDepreciationArea
association [1]    to I_DepreciationArea             as _DepreciationArea50    on  $projection.ChartOfDepreciation= _DepreciationArea50.ChartOfDepreciation 
                                                                               and $projection.AssetDepreciationArea50 = _DepreciationArea50.AssetDepreciationArea
association [1]    to I_DepreciationArea             as _DepreciationArea52    on  $projection.ChartOfDepreciation= _DepreciationArea52.ChartOfDepreciation 
                                                                               and $projection.AssetDepreciationArea52 = _DepreciationArea52.AssetDepreciationArea
association [0..1] to I_GLAccountInChartOfAccounts   as _GLOffAccount          on  $projection.ChartOfAccounts = _GLOffAccount.ChartOfAccounts
                                                                               and $projection.OffAccnt = _GLOffAccount.GLAccount
association [0..1] to I_GLAccountInChartOfAccounts   as _GLCorrAccount         on  $projection.ChartOfAccounts = _GLCorrAccount.ChartOfAccounts
                                                                               and $projection.m_msfocor = _GLCorrAccount.GLAccount
association [0..1] to I_GLAccountInChartOfAccounts   as _GLOffCorrAccount      on  $projection.ChartOfAccounts = _GLOffCorrAccount.ChartOfAccounts
                                                                               and $projection.m_msfoacc = _GLOffCorrAccount.GLAccount
association [0..1] to I_GLAccountInChartOfAccounts   as _GLOffAccountBSBU      on  $projection.ChartOfAccounts = _GLOffAccountBSBU.ChartOfAccounts
                                                                               and $projection.ktansw1 = _GLOffAccountBSBU.GLAccount         
association [0..1] to I_GLAccountInChartOfAccounts   as _GLOffAccountMSFO      on  $projection.ChartOfAccounts = _GLOffAccountMSFO.ChartOfAccounts
                                                                               and $projection.ktansw50 = _GLOffAccountMSFO.GLAccount                                                                                                                                                       
association [1]    to I_ChartOfDepreciation          as _ChartOfDepreciation   on  $projection.ChartOfDepreciation = _ChartOfDepreciation.ChartOfDepreciation
association [1]    to ZI_AssetTransactionType        as _ZAssetTransactionType on  $projection.AssetTransactionType = _ZAssetTransactionType.AssetTransactionType
association [0..1] to I_Project                      as _Project               on  $projection.Project = _Project.Project
association [1]    to ZI_FixedAsset                  as _FixedAsset            on  $projection.FixedAsset = _FixedAsset.FixedAsset
                                                                               and $projection.MasterFixedAsset= _FixedAsset.MasterFixedAsset
                                                                               and $projection.CompanyCode = _FixedAsset.CompanyCode
association [1]    to I_MasterFixedAsset             as _MasterFixedAsset      on  $projection.MasterFixedAsset = _MasterFixedAsset.MasterFixedAsset
                                                                               and $projection.CompanyCode = _MasterFixedAsset.CompanyCode     
association [1]    to I_CompanyCode                  as _CompanyCode           on  $projection.CompanyCode = _CompanyCode.CompanyCode     
association [1]    to I_CompanyCode                  as _CompanyCodeWBS        on  $projection.CompanyCodeWBS = _CompanyCodeWBS.CompanyCode 
association [0..1] to ZI_IFRS_CORR                   as _IFRSCorr              on  $projection.m_corr = _IFRSCorr.IFRSCorr 
//                                                                               and $projection.m_rule = _IFRSCorr.m_rule      
association [1]    to ZI_IFRS_TVO                    as _IFRSTvo               on  $projection.m_tvo = _IFRSTvo.IFRSTvo  
//association [1]    to ZI_IFRS_RULE                   as _IFRSRule              on  $projection.m_rule = _IFRSRule.IFRSRule   
association [1]    to ZI_IFRS_VO                     as _IFRSVo                on  $projection.m_vo = _IFRSVo.IFRSVo
association [1]    to ZI_IFRS_TYPE                   as _IFRS_GRP              on  $projection.grmsfo1 = _IFRS_GRP.ifrs_grp
association [1]    to ZI_IFRS_TYPE                   as _IFRS_GRPFI            on  $projection.grmsfo2 = _IFRS_GRPFI.ifrs_grp
association [1]    to I_BusinessPartner              as _BusinessPartner       on  $projection.BusinessPartner = _BusinessPartner.BusinessPartner
association [0..1] to I_Supplier                     as _Supplier              on  $projection.Supplier = _Supplier.Supplier
association [1]    to ZI_IFRS_TTYGRP                 as _IFRSTtygrp            on  $projection.m_ttygrp = _IFRSTtygrp.IFRSTtygrp
association [1]    to ZI_MSFOTYPE                    as _MsfoType              on  $projection.msfotype = _MsfoType.MsfoType
association [1]    to ZI_AGGCOST                     as _AggCost               on  $projection.m_aggcost = _AggCost.AggCost
association [0..1] to ZI_MAT_EQUIPMENT               as  _MatEquipment         on  $projection.MatEquipment    = _MatEquipment.MatEquipment                                                                             
association [1]    to ZI_RUNMODE_YEAR                as _RunModeYear           on  $projection.RunModeYear = _RunModeYear.RunModeYear
association [0..1] to I_AssetClass                   as _AssetClass            on  $projection.AssetClass = _AssetClass.AssetClass
association [0..1] to I_AssetClass                   as _AssetClassWBS         on  $projection.AssetClassWBS = _AssetClassWBS.AssetClass
association [0..1] to I_AssetClass                   as _AssetClassCase        on  $projection.AssetClassCASE = _AssetClassCase.AssetClass
  
{

    dstream             as DStream,
    zt.belnr            as AccountingDocument,
    zt.docln            as LedgerGLLineItem,
    @ObjectModel.foreignKey.association: '_ChartOfAccounts'
    'BNFT'            as ChartOfAccounts, //zt.ktopl
    @ObjectModel.foreignKey.association: '_ChartOfDepreciation'
    'BNFT'              as ChartOfDepreciation,
    @ObjectModel.foreignKey.association: '_GLAccount'
    zt.racct            as GLAccount, 
    @ObjectModel.foreignKey.association: '_GLOffAccount'
    zt.gkont            as OffAccnt,
    zt.gkont1           as OffAccnt1,
    cast ( zt.gjahr as fis_gjahr) as FiscalYear,
    zt.co_belnr         as Co_AccountingDocument, 
    @ObjectModel.foreignKey.association: '_CompanyCode'
    zt.rbukrs           as CompanyCode,
    @ObjectModel.foreignKey.association: '_CompanyCodeWBS'
    _WBSElement.CompanyCode as CompanyCodeWBS,
    @ObjectModel.foreignKey.association: '_WBSElement'  
    zt.ps_posid         as WBSElement,
    zt.pps_posid        as P_WBS,
    @ObjectModel.foreignKey.association: '_DepreciationArea'
    zt.afabe            as AssetDepreciationArea,
    @EndUserText.label: 'Область оценки для 52'
    @ObjectModel.foreignKey.association: '_DepreciationArea52'
    case when zt.afabe = '00' then '52'
         when zt.afabe = '50' and (zt.m_tvo = '60' or zt.m_tvo = '61' or zt.m_tvo = '11' or zt.m_tvo = '51') then '52'
         when zt.afabe = '51' and (zt.m_tvo = '60' or zt.m_tvo = '61' or zt.m_tvo = '11' or zt.m_tvo = '51') then '53'
         else zt.afabe
    end                 as AssetDepreciationArea52,
    @EndUserText.label: 'Область оценки для 50'
    @ObjectModel.foreignKey.association: '_DepreciationArea50'
    case when zt.afabe = '00' then '50'
         else zt.afabe
    end                 as AssetDepreciationArea50,
    @ObjectModel.foreignKey.association: '_DebitCreditCode'
    zt.drcrk            as DebitCreditCode,
    @DefaultAggregation: #SUM
    zt.hsl              as AmountInCompanyCodeCurrency,
    zt.fiscyearper      as FiscalYearPeriod,
    //@EndUserText.label: '№ документа 1'
   // zt.belnr_first      as AccountingDocument_First,
    zt.fiscyearper_infl as FiscalYearPeriod_infl,
    @DefaultAggregation: #SUM
    zt.hsl_infl         as hsl_infl,
    @DefaultAggregation: #SUM
    zt.cpi              as cpi,
    @EndUserText.label: 'Индикатор +/-'
    zt.sign             as sign,
    @EndUserText.label: 'Принадлежит одной БЕ'
    case when _WBSElement.CompanyCode = zt.pbukrs
         then 'X' else ' ' 
    end                 as same_bukrs,
    zt.datacode         as datecode,
    zt.awtyp            as awtyp,
    @EndUserText.label: 'Индикатор общего счета'
    zt.same_acc         as same_acc,
    @EndUserText.label: 'Дата инфлирования'
    zt.date_infl        as date_infl,
    @EndUserText.label: 'Профиль инвестиций партнера'
    zt.pps_imprf        as pps_imprf,
    @EndUserText.label: 'Индикатор одинаковой группы профиля'
    case when _WBSElement.InvestmentProfile like '8%' and zt.pps_imprf like '8%' then 'X'
         when _WBSElement.InvestmentProfile = zt.pps_imprf                       then 'X'
    end  as imprf_group,     
    zt.bttype           as bttype,
    zt.budat            as budat,
    @ObjectModel.foreignKey.association: '_BusinessPartner'
    zt.vptnr            as BusinessPartner,
    @ObjectModel.foreignKey.association: '_Supplier'
    case when v.name = 'ZAA_BWASL_PARTNER'     then _FixedAsset.Supplier
         when v.name = 'ZAA_BWASL_RET_PARTNER' then _FixedAsset.bu_partner
         else '          '
    end                 as Supplier,    
    zt.vrgng            as vrgng,
    zt.objnr            as objnr,
    zt.xreversing       as IsReversal,
    zt.xreversed        as IsReversed,
    zt.aufnr            as aufnr,
    @ObjectModel.foreignKey.association: '_Project'
    _WBSElement.Project as Project,    
    
    @EndUserText.label: 'Бух счет учета по БСБУ'
    @ObjectModel.foreignKey.association: '_GLOffAccountBSBU'
    case when zt.datacode like 'FIAA%' then _FixedAsset.ktansw1 
         else _WBSElement.ktansw1 
    end as ktansw1,    
    @EndUserText.label: 'Бух счет учета по MCФО'
    @ObjectModel.foreignKey.association: '_GLOffAccountMSFO'
    case when zt.datacode like 'FIAA%' then _FixedAsset.ktansw50
         else _WBSElement.ktansw50
    end as ktansw50,
    @EndUserText.label: 'Критерий признания МСФО'
    _WBSElement.msfoaccept_ifrs as msfoaccept,
    @EndUserText.label: 'Критерий признания'
    case when _FixedAsset.msfoaccept = 'X' then  'Да'
         else 'Нет' end as MSFO,

    @EndUserText.label: 'Признак будущие ОС/ НМА/прочие'
    _WBSElement.description,
    @EndUserText.label: 'Будущий ОС/будущий НМА'
    @ObjectModel.foreignKey.association: '_MsfoType'
    _WBSElement.msfotype as msfotype,
    @EndUserText.label: 'Наименование ОС (НМА)'
    _WBSElement.WBSDescription,    
    
    @EndUserText.label: 'Индикатор группы МСФО'
    case when _WBSElement.ktansw1 like '9722%' then 
         'X'
         else ''
    end as is_grouped_msfo,
    
    @DefaultAggregation: #MAX
    @EndUserText.label: 'Дата ввода по БСБУ'
    case when zp4.released like '01%' or zp4.released like '04%' or zp4.released like '08%' 
         then (DATS_DAYS_BETWEEN(cast('19000101' as aktivd),zp4.aktiv) + 2)
         else (DATS_DAYS_BETWEEN(cast('19000101' as aktivd),_WBSElement.activ) + 2) end as aktiv,
    zp4.aktiv as test_aktiv,
    @DefaultAggregation: #MAX
    @EndUserText.label: 'Дата начала эксплуатации по МСФО'    
    case when zp4.released like '01%' or zp4.released like '04%' or zp4.released like '08%' 
         then (DATS_DAYS_BETWEEN(cast('19000101' as zexpdate), zp4.expdate) + 2)                                                                                      
         else (DATS_DAYS_BETWEEN(cast('19000101' as zexpdate), _WBSElement.expdate) + 2) end as expdate,
    
    --Используется???
    case when zp4.released like '01%' or zp4.released like '04%' or zp4.released like '08%'  then zp4.expdate
         else _WBSElement.expdate end as text_expdate,
    
    @EndUserText.label: 'Дата начала эксплуатации по МСФО - карточка НКС'
    _WBSElement.expdate as WBSExpDate,
         
    @EndUserText.label: 'Инвентарный номер'
    case when zp4.released like '01%' or zp4.released like '04%' or zp4.released like '08%'  then zp4.invnr
         when zt.anln1 like '0008%' or zt.datacode not like 'FIAA%'
         then _WBSElement.invnr
         else _FixedAsset.Inventory
    end as invnr,
    
    @EndUserText.label: 'Дата начала эксплуатации по МСФО (0818)'
    _FixedAsset.expdate as expdate2,

/* УДАЛИТЬ ПОСЛЕ ТЕСТИРОВАНИЯ */
    zp4.invnr as invnr_numb,
    @EndUserText.label: 'Инвентарный номер (ОС)'
    _FixedAsset.Inventory as invnr2,
    @EndUserText.label: 'Инвентарный номер (0818)'
    _WBSElement.invnr as invnr3,
/* УДАЛИТЬ ПОСЛЕ ТЕСТИРОВАНИЯ */    
    
    @DefaultAggregation: #SUM
    kansw as kansw,
    @DefaultAggregation: #SUM
    knafa as knafa,
    @DefaultAggregation: #SUM
    kaafa as kaafa,
    @DefaultAggregation: #SUM
    kansw_infl as kansw_infl,
    @DefaultAggregation: #SUM
    knafa_infl as knafa_infl,
    @DefaultAggregation: #SUM
    kaafa_infl as kaafa_infl,
    
    @EndUserText.label: 'Основное средство (НКС)'
    case when zt.datacode not like 'FIAA%' then _WBSElement.MasterFixedAsset
         else zt.anln1 end as MasterFixedAsset2,
    @EndUserText.label: 'Субномер основного средства (НКС)'
    case when zt.datacode not like 'FIAA%' then _WBSElement.FixedAsset
         else zt.anln2 end as FixedAsset2,
         
    @ObjectModel.foreignKey.association: '_AssetClass'
    _FixedAsset.AssetClass as AssetClass,
    @ObjectModel.foreignKey.association: '_AssetClassWBS'
    _WBSElement.AssetClass as AssetClassWBS,
    @EndUserText.label: 'Класс основных средств'
    @ObjectModel.foreignKey.association: '_AssetClassCase'
    case when _WBSElement.ktansw1 like '0818%'
         then _WBSElement.AssetClass
         else _FixedAsset.AssetClass
    end as AssetClassCASE,
    
    @ObjectModel.foreignKey.association: '_MasterFixedAsset'
    zt.anln1       as MasterFixedAsset,
    @ObjectModel.text.element: ['FixedAssetDescription']
    zt.anln2       as FixedAsset,
    
    zt.slalittype as slalittype,
    zt.set_name   as set_name,
    @ObjectModel.foreignKey.association: '_ZAssetTransactionType'
    @EndUserText.label: 'Вид движения'
    zt.anbwa      as AssetTransactionType,
    @EndUserText.label: 'Дата окончания начисления амортизации'
    case when _WBSElement.ktansw1 like '0818%'
         then dats_add_days(_WBSElement.depEndDate, -1, 'UNCHANGED')
         else dats_add_days(depEndDate, -1, 'UNCHANGED')
    end as depEndDate,
    
    zt.tcode       as tcode,
    zp4.released   as released,
    zp4.released50 as released50,
        
    //Признаки корректировки МСФО   
    zt.m_rule    as m_rule,   
    @ObjectModel.foreignKey.association: '_IFRSTvo'
    zt.m_tvo     as m_tvo,
    @ObjectModel.foreignKey.association: '_IFRSVo'
    zt.m_vo      as m_vo,
    @ObjectModel.foreignKey.association: '_IFRSCorr'
    zt.m_corr    as m_corr,   
    @ObjectModel.foreignKey.association: '_GLCorrAccount'
    zt.m_msfocor as m_msfocor,
    zt.m_rparty  as m_rparty,
    zt.m_trans   as m_trans,
    zt.m_onaono  as m_onaono,
    @ObjectModel.foreignKey.association: '_GLOffCorrAccount'
    zt.m_msfoacc as m_msfoacc,
    @EndUserText.label: 'Агрегированные затраты'
    @ObjectModel.foreignKey.association: '_AggCost'
    zt.m_aggcost as m_aggcost,
    @EndUserText.label: 'Группа видов двжения'
    @ObjectModel.foreignKey.association: '_IFRSTtygrp'
    zt.m_ttygrp  as m_ttygrp,
    
    @ObjectModel.foreignKey.association: '_MatEquipment'
    '                    ' as MatEquipment,
    '50'         as msfo50,
    '52'         as msfo52,
    @ObjectModel.foreignKey.association: '_RunModeYear'
    cast( 'X' as abap.char( 1 )) as RunModeYear,
   
   
    _IFRSCorr,
    _IFRSTvo,
    _IFRSVo,
    _IFRS_GRP,
    _IFRS_GRPFI,
    _AggCost,
    _IFRSTtygrp,
    _FixedAsset,
    @EndUserText.label: 'Счет по БСБУ' 
    _FixedAsset.ktansw1 as ktansw,
    @EndUserText.label: 'Шифр нормы'
    _FixedAsset.OKOFCode,
    @EndUserText.label: 'Группа ОС'
    @ObjectModel.foreignKey.association: '_IFRS_GRPFI'
    case when zt.datacode not like 'FIAA%' then _WBSElement.grmsfo
         when zt.datacode like 'FIAA%' and _FixedAsset.msfoaccept = 'X' then _FixedAsset.grmsfo  //AK_POLOCHANI RM27433 расхождение с 220 отчетом (ZI_AA01_01)
         else '00' end as grmsfo2,
    @ObjectModel.foreignKey.association: '_IFRS_GRP'
    _WBSElement.grmsfo as grmsfo1,
    @EndUserText.label: 'Группа ОС партнера'
    zt.p_grmsfo        as p_grmsfo,
    @EndUserText.label: 'Индикатор одинаковой группы'
    zt.same_grmsfo     as same_grmsfo, 
    
    @EndUserText.label: 'Полное наименование'
    _FixedAsset.FullName3,    
    _WBSElement.deakt,    
    @EndUserText.label: 'Дата ввода по БСБУ'
    _FixedAsset.AssetCapitalizationDate,
    _MasterFixedAsset,    
    _BusinessPartner,
    _Supplier,
    _ZAssetTransactionType,
    _ZAssetTransactionType.GroupTransactionType,
    _ZAssetTransactionType.ClassificationTransactionType,
    _WBSElement,
    @EndUserText.label: 'Профиль инвестиций СПП-элемента'
    _WBSElement.InvestmentProfile,
    _ChartOfDepreciation,
    _GLAccount,
    _GLOffCorrAccount,
    _GLCorrAccount,
    _GLOffAccountBSBU,
    _GLOffAccountMSFO,
    _CompanyCode,
    _CompanyCodeWBS,
    _DebitCreditCode,
    _GLOffAccount,
    _DepreciationArea,
    _DepreciationArea50,
    _DepreciationArea52,
    _ChartOfAccounts,
    _Project,
    _MsfoType,
    _MatEquipment,
    _RunModeYear,
    _AssetClassCase,
    _AssetClass,
    _AssetClassWBS
}
/*group by
dstream,
zt.belnr,
zt.docln,
zt.racct, 
zt.gkont,
zt.gkont1, 
zt.co_belnr, 
zt.rbukrs,   
_WBSElement.CompanyCode,
zt.ps_posid,
zt.pps_posid,
zt.afabe,
zt.gjahr,     
zt.drcrk,   
zt.fiscyearper,
zt.fiscyearper_infl,
zt.sign,
zt.datacode,
zt.awtyp,
zt.same_acc,
zt.date_infl,
zt.pps_imprf,
zt.bttype,
zt.budat,
zt.vptnr,
zt.vrgng,
zt.objnr,
zt.xreversing,
zt.xreversed,
zt.aufnr,
_WBSElement.Project,    
_WBSElement.msfoaccept_ifrs,
_WBSElement.description,
_WBSElement.msfotype,
_WBSElement.WBSDescription,    
_WBSElement.expdate,
_FixedAsset.expdate,
_FixedAsset.AssetClass,
_WBSElement.AssetClass,
zt.anln1,
zt.anln2,
zt.slalittype,
zt.set_name,
zt.anbwa,
zt.tcode,
zp4.released,
zp4.released50,
zt.m_rule,   
zt.m_tvo,
zt.m_vo,
zt.m_corr,   
zt.m_msfocor,
zt.m_rparty,
zt.m_trans,
zt.m_onaono,
zt.m_msfoacc,
zt.m_aggcost,
zt.m_ttygrp,
_WBSElement.activ,
zp4.aktiv,
_FixedAsset.AssetCapitalizationDate,
_FixedAsset.bu_partner,
_ZAssetTransactionType.ClassificationTransactionType,
_WBSElement.deakt,
_WBSElement.depEndDate,
depEndDate,
zp4.expdate,
_WBSElement.FixedAsset,
_FixedAsset.FullName3,
_WBSElement.grmsfo,
_FixedAsset.grmsfo,
_ZAssetTransactionType.GroupTransactionType,
_FixedAsset.Inventory,
_WBSElement.InvestmentProfile,
zp4.invnr,
_WBSElement.invnr,
_FixedAsset.Supplier,
zt.same_grmsfo,
zt.pbukrs,
zt.p_grmsfo,
_FixedAsset.OKOFCode,
v.name,
_FixedAsset.msfoaccept,
_WBSElement.MasterFixedAsset,
_FixedAsset.ktansw1,
_WBSElement.ktansw1,
_FixedAsset.ktansw50,
_WBSElement.ktansw50
*/
union all 

select from /bic/az_aarc_ps2 as arch 

    join tvarvc as arch_mark on arch_mark.name = 'ZIFRS_ARCH_MARK_NKS' and arch_mark.low = 'X'

association [1]    to ZI_WBS_FIAA                    as _WBSElement            on  $projection.WBSElement = _WBSElement.WBSElement
association [0..1] to I_GLAccountInChartOfAccounts   as _GLAccount             on  $projection.ChartOfAccounts = _GLAccount.ChartOfAccounts
                                                                               and $projection.GLAccount = _GLAccount.GLAccount
association [1]    to I_DebitCreditCode              as _DebitCreditCode       on  $projection.DebitCreditCode = _DebitCreditCode.DebitCreditCode
association [1]    to I_ChartOfAccounts              as _ChartOfAccounts       on  $projection.ChartOfAccounts = _ChartOfAccounts.ChartOfAccounts
association [1]    to I_DepreciationArea             as _DepreciationArea      on  $projection.ChartOfDepreciation= _DepreciationArea.ChartOfDepreciation 
                                                                               and $projection.AssetDepreciationArea = _DepreciationArea.AssetDepreciationArea
association [1]    to I_DepreciationArea             as _DepreciationArea50    on  $projection.ChartOfDepreciation= _DepreciationArea50.ChartOfDepreciation 
                                                                               and $projection.AssetDepreciationArea50 = _DepreciationArea50.AssetDepreciationArea
association [1]    to I_DepreciationArea             as _DepreciationArea52    on  $projection.ChartOfDepreciation= _DepreciationArea52.ChartOfDepreciation 
                                                                               and $projection.AssetDepreciationArea52 = _DepreciationArea52.AssetDepreciationArea
association [0..1] to I_GLAccountInChartOfAccounts   as _GLOffAccount          on  $projection.ChartOfAccounts = _GLOffAccount.ChartOfAccounts
                                                                               and $projection.OffAccnt = _GLOffAccount.GLAccount
association [0..1] to I_GLAccountInChartOfAccounts   as _GLCorrAccount         on  $projection.ChartOfAccounts = _GLCorrAccount.ChartOfAccounts
                                                                               and $projection.m_msfocor = _GLCorrAccount.GLAccount
association [0..1] to I_GLAccountInChartOfAccounts   as _GLOffCorrAccount      on  $projection.ChartOfAccounts = _GLOffCorrAccount.ChartOfAccounts
                                                                               and $projection.m_msfoacc = _GLOffCorrAccount.GLAccount
association [0..1] to I_GLAccountInChartOfAccounts   as _GLOffAccountBSBU      on  $projection.ChartOfAccounts = _GLOffAccountBSBU.ChartOfAccounts
                                                                               and $projection.ktansw1 = _GLOffAccountBSBU.GLAccount         
association [0..1] to I_GLAccountInChartOfAccounts   as _GLOffAccountMSFO      on  $projection.ChartOfAccounts = _GLOffAccountMSFO.ChartOfAccounts
                                                                               and $projection.ktansw50 = _GLOffAccountMSFO.GLAccount                                                                                                                                                       
association [1]    to I_ChartOfDepreciation          as _ChartOfDepreciation   on  $projection.ChartOfDepreciation = _ChartOfDepreciation.ChartOfDepreciation
association [1]    to ZI_AssetTransactionType        as _ZAssetTransactionType on  $projection.AssetTransactionType = _ZAssetTransactionType.AssetTransactionType
association [0..1] to I_Project                      as _Project               on  $projection.Project = _Project.Project
association [1]    to ZI_FixedAsset                  as _FixedAsset            on  $projection.FixedAsset = _FixedAsset.FixedAsset
                                                                               and $projection.MasterFixedAsset= _FixedAsset.MasterFixedAsset
                                                                               and $projection.CompanyCode = _FixedAsset.CompanyCode
association [1]    to I_MasterFixedAsset             as _MasterFixedAsset      on  $projection.MasterFixedAsset = _MasterFixedAsset.MasterFixedAsset
                                                                               and $projection.CompanyCode = _MasterFixedAsset.CompanyCode     
association [1]    to I_CompanyCode                  as _CompanyCode           on  $projection.CompanyCode = _CompanyCode.CompanyCode     
association [1]    to I_CompanyCode                  as _CompanyCodeWBS        on  $projection.CompanyCodeWBS = _CompanyCodeWBS.CompanyCode 
association [0..1] to ZI_IFRS_CORR                   as _IFRSCorr              on  $projection.m_corr = _IFRSCorr.IFRSCorr 
//                                                                               and $projection.m_rule = _IFRSCorr.m_rule      
association [1]    to ZI_IFRS_TVO                    as _IFRSTvo               on  $projection.m_tvo = _IFRSTvo.IFRSTvo  
//association [1]    to ZI_IFRS_RULE                   as _IFRSRule              on  $projection.m_rule = _IFRSRule.IFRSRule   
association [1]    to ZI_IFRS_VO                     as _IFRSVo                on  $projection.m_vo = _IFRSVo.IFRSVo
association [1]    to ZI_IFRS_TYPE                   as _IFRS_GRP              on  $projection.grmsfo1 = _IFRS_GRP.ifrs_grp
association [1]    to ZI_IFRS_TYPE                   as _IFRS_GRPFI            on  $projection.grmsfo2 = _IFRS_GRPFI.ifrs_grp
association [1]    to I_BusinessPartner              as _BusinessPartner       on  $projection.BusinessPartner = _BusinessPartner.BusinessPartner
association [0..1] to I_Supplier                     as _Supplier              on  $projection.Supplier = _Supplier.Supplier
association [1]    to ZI_IFRS_TTYGRP                 as _IFRSTtygrp            on  $projection.m_ttygrp = _IFRSTtygrp.IFRSTtygrp
association [1]    to ZI_MSFOTYPE                    as _MsfoType              on  $projection.msfotype = _MsfoType.MsfoType
association [1]    to ZI_AGGCOST                     as _AggCost               on  $projection.m_aggcost = _AggCost.AggCost
association [0..1] to ZI_MAT_EQUIPMENT               as  _MatEquipment         on  $projection.MatEquipment    = _MatEquipment.MatEquipment                                                                             
association [1]    to ZI_RUNMODE_YEAR                as _RunModeYear           on  $projection.RunModeYear = _RunModeYear.RunModeYear
association [0..1] to I_AssetClass                   as _AssetClass            on  $projection.AssetClass = _AssetClass.AssetClass
association [0..1] to I_AssetClass                   as _AssetClassWBS         on  $projection.AssetClassWBS = _AssetClassWBS.AssetClass
association [0..1] to I_AssetClass                   as _AssetClassCase        on  $projection.AssetClassCASE = _AssetClassCase.AssetClass

{

    arch.dstream                 as DStream,
    arch.accountingdocument      as AccountingDocument,
    arch.ledgergllineitem        as LedgerGLLineItem,
    @ObjectModel.foreignKey.association: '_ChartOfAccounts'
    'BNFT'                       as ChartOfAccounts,
    @ObjectModel.foreignKey.association: '_ChartOfDepreciation'
    'BNFT'                       as ChartOfDepreciation,
    @ObjectModel.foreignKey.association: '_GLAccount'
    arch.glaccount               as GLAccount, 
    @ObjectModel.foreignKey.association: '_GLOffAccount'
    arch.offaccnt                as OffAccnt,
    arch.offaccnt1               as OffAccnt1,
    cast (arch.fiscalyear as fis_gjahr) as FiscalYear,
    arch.co_accountingdocument   as Co_AccountingDocument, 
    @ObjectModel.foreignKey.association: '_CompanyCode'
    arch.companycode             as CompanyCode,
    @ObjectModel.foreignKey.association: '_CompanyCodeWBS'
    arch.companycodewbs          as CompanyCodeWBS,
    @ObjectModel.foreignKey.association: '_WBSElement'  
    arch.wbselement              as WBSElement,
    arch.p_wbs                   as P_WBS,
    @ObjectModel.foreignKey.association: '_DepreciationArea'
    arch.assetdepreciationarea   as AssetDepreciationArea,
    @EndUserText.label: 'Область оценки для 52'
    @ObjectModel.foreignKey.association: '_DepreciationArea52'
    arch.assetdepreciationarea52 as AssetDepreciationArea52,
    @EndUserText.label: 'Область оценки для 50'
    @ObjectModel.foreignKey.association: '_DepreciationArea50'
    arch.assetdepreciationarea50 as AssetDepreciationArea50,
    @ObjectModel.foreignKey.association: '_DebitCreditCode'
    arch.debitcreditcode         as DebitCreditCode,
    @DefaultAggregation: #SUM
    arch./bic/zhsl              as AmountInCompanyCodeCurrency, //sum(arch./bic/zhsl)              as AmountInCompanyCodeCurrency,
    arch.fiscalyearperiod        as FiscalYearPeriod,
    arch.fiscalyearperiod_infl   as FiscalYearPeriod_infl,
    @DefaultAggregation: #SUM
    arch./bic/zhsl_infl         as hsl_infl, //sum(arch./bic/zhsl_infl)         as hsl_infl,
    @DefaultAggregation: #SUM
    arch./bic/zcpi              as cpi, //sum(arch./bic/zcpi)              as cpi,
    @EndUserText.label: 'Индикатор +/-'
    arch.sign                    as sign,
    @EndUserText.label: 'Принадлежит одной БЕ'
    arch.same_bukrs              as same_bukrs,
    arch.datecode                as datecode,
    arch.awtyp                   as awtyp,
    @EndUserText.label: 'Индикатор общего счета'
    arch.same_acc                as same_acc,
    @EndUserText.label: 'Дата инфлирования'
    arch.date_infl               as date_infl,
    @EndUserText.label: 'Профиль инвестиций партнера'
    arch.pps_imprf               as pps_imprf,
    @EndUserText.label: 'Индикатор одинаковой группы профиля'
    arch.imprf_group             as imprf_group,     
    arch.bttype                  as bttype,
    arch.budat                   as budat,
    @ObjectModel.foreignKey.association: '_BusinessPartner'
    arch.businesspartner         as BusinessPartner,
    @ObjectModel.foreignKey.association: '_Supplier'
    arch.supplier                as Supplier,    
    arch.vrgng                   as vrgng,
    arch.objnr                   as objnr,
    arch.isreversal              as IsReversal,
    arch.isreversed              as IsReversed,
    arch.aufnr                   as aufnr,
    @ObjectModel.foreignKey.association: '_Project'
    arch.project                 as Project,    
    
    @EndUserText.label: 'Бух счет учета по БСБУ'
    @ObjectModel.foreignKey.association: '_GLOffAccountBSBU'
    arch.ktansw1 as ktansw1,    
    @EndUserText.label: 'Бух счет учета по MCФО'
    @ObjectModel.foreignKey.association: '_GLOffAccountMSFO'
    arch.ktansw50 as ktansw50,
    @EndUserText.label: 'Критерий признания МСФО'
    arch.msfoaccept as msfoaccept,
    @EndUserText.label: 'Критерий признания'
    arch.msfo as MSFO,

    @EndUserText.label: 'Признак будущие ОС/ НМА/прочие'
    _WBSElement.description,
    @EndUserText.label: 'Будущий ОС/будущий НМА'
    @ObjectModel.foreignKey.association: '_MsfoType'
    _WBSElement.msfotype as msfotype,
    @EndUserText.label: 'Наименование ОС (НМА)'
    _WBSElement.WBSDescription,    
    
    @EndUserText.label: 'Индикатор группы МСФО'
    arch.is_grouped_msfo as is_grouped_msfo,
    
    @DefaultAggregation: #MAX
    @EndUserText.label: 'Дата ввода по БСБУ'
    arch.aktiv as aktiv,
    arch.test_aktiv as test_aktiv,
    @DefaultAggregation: #MAX
    @EndUserText.label: 'Дата начала эксплуатации по МСФО'    
    arch.expdate as expdate,
    
    arch.text_expdate as text_expdate,
    
    @EndUserText.label: 'Дата начала эксплуатации по МСФО - карточка НКС'
    arch.wbsexpdate as WBSExpDate,
         
    @EndUserText.label: 'Инвентарный номер'
    arch.invnr as invnr,
    
    @EndUserText.label: 'Дата начала эксплуатации по МСФО (0818)'
    arch.expdate2 as expdate2,

/* УДАЛИТЬ ПОСЛЕ ТЕСТИРОВАНИЯ */
    arch.invnr_numb as invnr_numb,
    @EndUserText.label: 'Инвентарный номер (ОС)'
    arch.invnr2 as invnr2,
    @EndUserText.label: 'Инвентарный номер (0818)'
    arch.invnr3 as invnr3, 
/* УДАЛИТЬ ПОСЛЕ ТЕСТИРОВАНИЯ */    
   
    @DefaultAggregation: #SUM
    arch./bic/zkansw as kansw, //sum(arch./bic/zkansw) as kansw,
    @DefaultAggregation: #SUM
    arch./bic/zknafa as knafa, //sum(arch./bic/zknafa) as knafa,
    @DefaultAggregation: #SUM
    arch./bic/zkaafa as kaafa, //sum(arch./bic/zkaafa) as kaafa,
    @DefaultAggregation: #SUM
    arch./bic/zkansw_in as kansw_infl, //sum(arch./bic/zkansw_in) as kansw_infl,
    @DefaultAggregation: #SUM
    arch./bic/zknafa_in as knafa_infl, //sum(arch./bic/zknafa_in) as knafa_infl,
    @DefaultAggregation: #SUM
    arch./bic/zkaafa_in as kaafa_infl, //sum(arch./bic/zkaafa_in) as kaafa_infl,
    
    @EndUserText.label: 'Основное средство (НКС)'
    arch.masterfixedasset2 as MasterFixedAsset2,
    @EndUserText.label: 'Субномер основного средства (НКС)'
    arch.fixedasset2 as FixedAsset2,
         
    @ObjectModel.foreignKey.association: '_AssetClass'
    arch.assetclass as AssetClass,
    @ObjectModel.foreignKey.association: '_AssetClassWBS'
    arch.assetclasswbs as AssetClassWBS,
    @EndUserText.label: 'Класс основных средств'
    @ObjectModel.foreignKey.association: '_AssetClassCase'
    arch.assetclasscase as AssetClassCASE,
    
    @ObjectModel.foreignKey.association: '_MasterFixedAsset'
    arch.masterfixedasset       as MasterFixedAsset,
    @ObjectModel.text.element: ['FixedAssetDescription']
    arch.fixedasset       as FixedAsset,
    
    arch.slalittype as slalittype,
    arch.set_name   as set_name,
    @ObjectModel.foreignKey.association: '_ZAssetTransactionType'
    @EndUserText.label: 'Вид движения'
    arch.assettransactiontype      as AssetTransactionType,
    @EndUserText.label: 'Дата окончания начисления амортизации'
    arch.dependdate as depEndDate,
    
    arch.tcode       as tcode,
    arch.released   as released,
    arch.released50 as released50,
        
    //Признаки корректировки МСФО   
    arch.m_rule    as m_rule,   
    @ObjectModel.foreignKey.association: '_IFRSTvo'
    arch.m_tvo     as m_tvo,
    @ObjectModel.foreignKey.association: '_IFRSVo'
    arch.m_vo      as m_vo,
    @ObjectModel.foreignKey.association: '_IFRSCorr'
    arch.m_corr    as m_corr,   
    @ObjectModel.foreignKey.association: '_GLCorrAccount'
    arch.m_msfocor as m_msfocor,
    arch.m_rparty  as m_rparty,
    arch.m_trans   as m_trans,
    arch.m_onaono  as m_onaono,
    @ObjectModel.foreignKey.association: '_GLOffCorrAccount'
    arch.m_msfoacc as m_msfoacc,
    @EndUserText.label: 'Агрегированные затраты'
    @ObjectModel.foreignKey.association: '_AggCost'
    arch.m_aggcost as m_aggcost,
    @EndUserText.label: 'Группа видов двжения'
    @ObjectModel.foreignKey.association: '_IFRSTtygrp'
    arch.m_ttygrp  as m_ttygrp,
    
    @ObjectModel.foreignKey.association: '_MatEquipment'
    '                    ' as MatEquipment,
    '50'         as msfo50,
    '52'         as msfo52,
    @ObjectModel.foreignKey.association: '_RunModeYear'
    cast( 'X' as abap.char( 1 )) as RunModeYear,
   
   
    _IFRSCorr,
    _IFRSTvo,
    _IFRSVo,
    _IFRS_GRP,
    _IFRS_GRPFI,
    _AggCost,
    _IFRSTtygrp,
    _FixedAsset,
    @EndUserText.label: 'Счет по БСБУ' 
    arch.ktansw as ktansw,
    @EndUserText.label: 'Шифр нормы'
    _FixedAsset.OKOFCode,
    @EndUserText.label: 'Группа ОС'
    @ObjectModel.foreignKey.association: '_IFRS_GRPFI'
    arch.grmsfo2 as grmsfo2,
    @ObjectModel.foreignKey.association: '_IFRS_GRP'
    _WBSElement.grmsfo as grmsfo1,
    @EndUserText.label: 'Группа ОС партнера'
    arch.p_grmsfo        as p_grmsfo,
    @EndUserText.label: 'Индикатор одинаковой группы'
    arch.same_grmsfo     as same_grmsfo, 
    
    @EndUserText.label: 'Полное наименование'
    _FixedAsset.FullName3,    
    _WBSElement.deakt,    
    @EndUserText.label: 'Дата ввода по БСБУ'
    _FixedAsset.AssetCapitalizationDate,
    _MasterFixedAsset,    
    _BusinessPartner,
    _Supplier,
    _ZAssetTransactionType,
    _ZAssetTransactionType.GroupTransactionType,
    _ZAssetTransactionType.ClassificationTransactionType,
    _WBSElement,
    @EndUserText.label: 'Профиль инвестиций СПП-элемента'
    _WBSElement.InvestmentProfile,
    _ChartOfDepreciation,
    _GLAccount,
    _GLOffCorrAccount,
    _GLCorrAccount,
    _GLOffAccountBSBU,
    _GLOffAccountMSFO,
    _CompanyCode,
    _CompanyCodeWBS,
    _DebitCreditCode,
    _GLOffAccount,
    _DepreciationArea,
    _DepreciationArea50,
    _DepreciationArea52,
    _ChartOfAccounts,
    _Project,
    _MsfoType,
    _MatEquipment,
    _RunModeYear,
    _AssetClassCase,
    _AssetClass,
    _AssetClassWBS

} where arch.fiscalyearperiod <= $parameters.p_period1
    and arch.companycode between $parameters.p_bukrs_low and $parameters.p_bukrs_high     // AK_BUTVILOVS #36910 Работы по параметризации источников данных 
  
/*
group by

arch.dstream,
    arch.accountingdocument,
    arch.ledgergllineitem,
    arch.glaccount,
    arch.offaccnt,
    arch.offaccnt1,
    arch.fiscalyear,
    arch.co_accountingdocument,
    arch.companycode,
    arch.companycodewbs,  
    arch.wbselement,
    arch.p_wbs,
    arch.assetdepreciationarea,
    arch.assetdepreciationarea52,
    arch.assetdepreciationarea50,
    arch.debitcreditcode,
    arch.fiscalyearperiod,
    arch.fiscalyearperiod_infl,
    arch.sign,
    arch.same_bukrs,
    arch.datecode,
    arch.awtyp,
    arch.same_acc,
    arch.date_infl,
    arch.pps_imprf,
    arch.imprf_group,    
    arch.bttype,
    arch.budat,
    arch.businesspartner,
    arch.supplier,
    arch.vrgng,
    arch.objnr,
    arch.isreversal,
    arch.isreversed,
    arch.aufnr,
    arch.project,
    arch.ktansw1,
    arch.ktansw50,
    arch.msfoaccept,
    arch.msfo,
    _WBSElement.description,
    _WBSElement.msfotype,
    _WBSElement.WBSDescription,    
    arch.is_grouped_msfo,
    arch.aktiv,
    arch.test_aktiv,  
    arch.expdate,
    arch.text_expdate,
    arch.wbsexpdate,
    arch.invnr,
    arch.expdate2,
    arch.invnr_numb,
    arch.invnr2,
    arch.invnr3,
    arch.masterfixedasset2,
    arch.fixedasset2,
    arch.assetclass,
    arch.assetclasswbs,
    arch.assetclasscase,
    arch.masterfixedasset,
    arch.fixedasset,
    arch.slalittype,
    arch.set_name,
    arch.assettransactiontype,
    arch.dependdate,
    arch.tcode,
    arch.released,
    arch.released50,
    arch.m_rule,
    arch.m_tvo,
    arch.m_vo,
    arch.m_corr,
    arch.m_msfocor,
    arch.m_rparty,
    arch.m_trans,
    arch.m_onaono,
    arch.m_msfoacc,
    arch.m_aggcost,
    arch.m_ttygrp,
    arch.ktansw,
    _FixedAsset.OKOFCode,
    arch.grmsfo2,
    _WBSElement.grmsfo,
    arch.p_grmsfo,
    arch.same_grmsfo,
    _FixedAsset.FullName3,    
    _WBSElement.deakt,    
    _FixedAsset.AssetCapitalizationDate,
    _ZAssetTransactionType.GroupTransactionType,
    _ZAssetTransactionType.ClassificationTransactionType,
    _WBSElement.InvestmentProfile 
 */
 