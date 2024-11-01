@AbapCatalog.sqlViewName: 'ZP_AA0101'
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #COMPOSITE
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZACDOCATEST'
@Analytics.dataCategory: #CUBE
define view ZP_AA01_01
  
 with parameters 
 //   @Environment.systemField: #CLIENT
 //               p_clnt : abap.clnt,  
                P_fromdate : dats,
                P_todate   : dats, 
                P_period   : poper,
                P_year     : gjahr,
//                P_date     : dats,

                p_bukrs_low  : bukrs,      // AK_BUTVILOVS #36910 Работы по параметризации источников данных 
                p_bukrs_high : bukrs       // AK_BUTVILOVS #36910 Работы по параметризации источников данных 
                              
 as select from ZT_CPI_FIAA_00 (p_clnt:    $session.client,  
                                P_date:    $parameters.P_todate, 
                                P_period:  $parameters.P_period, 
                                P_year:    $parameters.P_year, 
                                p_bukrs_low: $parameters.p_bukrs_low,             // AK_GUBAREVICH #36910 Работы по параметризации источников данных 
                                p_bukrs_high: $parameters.p_bukrs_high )  as zt1  // AK_GUBAREVICH #36910 Работы по параметризации источников данных 
                                
               join anla                         on anla.mandt = zt1.mandt
                                                and anla.bukrs = zt1.bukrs
                                                and anla.anln1 = zt1.anln1
                                                and anla.anln2 = zt1.anln2 
                                                
    left outer join zanlz                        on zanlz.mandt = anla.mandt 
                                                and zanlz.invnr = anla.invnr 
                                                and zanlz.adatu <= $parameters.P_todate 
                                                and zanlz.bdatu >= $parameters.P_todate  
                                
 left outer join zaa_asset_calc_dates (iv_clnt: $session.client) as zaa 
                                                 on zaa.BUKRS = zt1.bukrs
                                                and zaa.ANLN1 = zt1.anln1
                                                and zaa.ANLN2 = zt1.anln2
                                                and zaa.AFABE = zt1.afabe                                              
{
      zt1.bukrs       as bukrs,
      zt1.anln1       as anln1,
      zt1.anln2       as anln2,
      zt1.afabe       as afabe_d, 
      zt1.belnr       as belnr,
      zt1.slalittype  as slalittype,
      zt1.name        as set_name, 
      cast('980' as anbwa) as anbwa,
      zt1.budat       as budat,
      anla.lifnr      as lifnr,
      @DefaultAggregation: #SUM
      zt1.kansw       as kansw,
      @DefaultAggregation: #SUM
      zt1.knafa       as knafa,
      @DefaultAggregation: #SUM
      zt1.kaafa       as kaafa,
      @DefaultAggregation: #SUM
      zt1.kansw_infl  as kansw_infl,
      @DefaultAggregation: #SUM
      zt1.knafa_infl  as knafa_infl,
      @DefaultAggregation: #SUM
      zt1.kaafa_infl  as kaafa_infl,
      @DefaultAggregation: #SUM
      zt1.ksafa       as ksafa,
      @DefaultAggregation: #SUM
      zt1.ksafa_infl  as ksafa_infl,
      @DefaultAggregation: #SUM
      zt1.hsl         as hsl,
      zt1.xreversing  as xreversing,
      zt1.xreversed   as xreversed,
      zt1.fiscyearper as fiscyearper,
      zt1.cpi_fiaa    as cpi_fiaa,
      zaa.AFABG       as afabg,
      zaa.NDPER       as ndper,
      zaa.NDJAR       as ndjar,
      zaa.depEndDate  as depEndDate,
      case when zt1.hsl < 0 then 'N'
           else 'P'
      end             as Sign,
      '     '         as awtyp,
      '          '    as awsys,
      '          '    as aworg,
      '          '    as awref,
      '      '        as awitem,
      '      '        as awitgrp,
      zanlz.viduse    as viduse,
      'FIAA_00'       as datacode    
}
    where zt1.bukrs between :p_bukrs_low and :p_bukrs_high      // AK_BUTVILOVS #36910 Работы по параметризации источников данных      
         
union all
                
select from ZT_CPI_FIAA_01 (p_clnt:    $session.client,  
                            P_date:    $parameters.P_todate, 
                            P_period:  $parameters.P_period, 
                            P_year:    $parameters.P_year, 
                            p_bukrs_low: $parameters.p_bukrs_low,             // AK_GUBAREVICH #36910 Работы по параметризации источников данных 
                            p_bukrs_high: $parameters.p_bukrs_high )  as zt1  // AK_GUBAREVICH #36910 Работы по параметризации источников данных )

    left outer join zaa_asset_calc_dates (iv_clnt: $session.client) as zaa 
                                                 on zaa.BUKRS = zt1.bukrs
                                                and zaa.ANLN1 = zt1.anln1
                                                and zaa.ANLN2 = zt1.anln2
                                                and zaa.AFABE = zt1.afabe
                                               
{
      zt1.bukrs       as bukrs,
      zt1.anln1       as anln1,
      zt1.anln2       as anln2,
      zt1.afabe       as afabe_d,
      ' '             as belnr, 
      zt1.slalittype  as slalittype,
      zt1.name        as set_name,
      zt1.anbwa       as anbwa,
      zt1.budat       as budat,
      '          '    as lifnr,
      @DefaultAggregation: #SUM
      zt1.kansw       as kansw,
      @DefaultAggregation: #SUM
      zt1.knafa       as knafa,
      @DefaultAggregation: #SUM
      zt1.kaafa       as kaafa,
      @DefaultAggregation: #SUM
      zt1.kansw_infl  as kansw_infl,
      @DefaultAggregation: #SUM
      zt1.knafa_infl  as knafa_infl,
      @DefaultAggregation: #SUM
      zt1.kaafa_infl  as kaafa_infl,
      @DefaultAggregation: #SUM
      zt1.ksafa       as ksafa,
      @DefaultAggregation: #SUM
      zt1.ksafa_infl  as ksafa_infl,
      @DefaultAggregation: #SUM
      zt1.hsl         as hsl,
      ' '             as xreversing,
      ' '             as xreversed,
      zt1.fiscyearper as fiscyearper,
      zt1.cpi_fiaa    as cpi_fiaa,
      zaa.AFABG       as afabg,
      zaa.NDPER       as ndper,
      zaa.NDJAR       as ndjar,
      zaa.depEndDate  as depEndDate,
      case when zt1.hsl < 0 then 'N'
           else 'P'
      end             as Sign,
      '     '         as awtyp,
      '          '    as awsys,
      '          '    as aworg,
      '          '    as awref,
      '      '        as awitem,
      '      '        as awitgrp,
      '00'            as viduse,
      'FIAA_01'       as datacode    
}
    where zt1.bukrs between :p_bukrs_low and :p_bukrs_high    // AK_BUTVILOVS #36910 Работы по параметризации источников данных
         
union all

select from ZT_CPI_FIAA_02 (p_clnt:     $session.client,    
                            P_fromdate: $parameters.P_fromdate, 
                            P_todate:   $parameters.P_todate,
                            P_period:   $parameters.P_period, 
                            P_year:     $parameters.P_year, 
                            p_bukrs_low: $parameters.p_bukrs_low,             // AK_GUBAREVICH #36910 Работы по параметризации источников данных 
                            p_bukrs_high: $parameters.p_bukrs_high )  as zt2  // AK_GUBAREVICH #36910 Работы по параметризации источников данных )
                            
               join anla                         on anla.mandt = zt2.mandt
                                                and anla.bukrs = zt2.bukrs
                                                and anla.anln1 = zt2.anln1
                                                and zt2.anln2 = anla.anln2  
                                                
    left outer join zanlz                        on zanlz.mandt = anla.mandt 
                                                and zanlz.invnr = anla.invnr 
                                                and zanlz.adatu <= $parameters.P_todate 
                                                and zanlz.bdatu >= $parameters.P_todate      
                                                                  
    left outer join zaa_asset_calc_dates (iv_clnt: $session.client) as zaa 
                                                 on zaa.BUKRS = zt2.bukrs
                                                and zaa.ANLN1 = zt2.anln1
                                                and zaa.ANLN2 = zt2.anln2
                                                and zaa.AFABE = zt2.afabe 
                                                
    {
      zt2.bukrs       as bukrs,
      zt2.anln1       as anln1,
      zt2.anln2       as anln2,
      zt2.afabe       as afabe_d,
      zt2.belnr       as belnr, 
      zt2.slalittype  as slalittype,
      zt2.name        as set_name,
      zt2.anbwa       as anbwa,
      zt2.budat_last  as budat,
      anla.lifnr      as lifnr,
      @DefaultAggregation: #SUM
      zt2.kansw       as kansw,
      @DefaultAggregation: #SUM
      zt2.knafa       as knafa,
      @DefaultAggregation: #SUM
      zt2.kaafa       as kaafa,
      @DefaultAggregation: #SUM
      zt2.kansw_infl  as kansw_infl,
      @DefaultAggregation: #SUM
      zt2.knafa_infl  as knafa_infl,
      @DefaultAggregation: #SUM
      zt2.kaafa_infl  as kaafa_infl,
      @DefaultAggregation: #SUM
      zt2.ksafa       as ksafa,
      @DefaultAggregation: #SUM
      zt2.ksafa_infl  as ksafa_infl,
      @DefaultAggregation: #SUM
      zt2.hsl         as hsl,
      zt2.xreversing  as xreversing,
      zt2.xreversed   as xreversed,
      zt2.fiscyearper as fiscyearper,
      zt2.cpi_fiaa    as cpi_fiaa,
      zaa.AFABG       as afabg,
      zaa.NDPER       as ndper,
      zaa.NDJAR       as ndjar,
      zaa.depEndDate  as depEndDate,
      case when zt2.hsl < 0 then 'N'
           else 'P'
      end             as Sign,
      zt2.awtyp       as awtyp,
      zt2.awsys       as awsys,
      zt2.aworg       as aworg,
      zt2.awref       as awref,
      zt2.awitem      as awitem,
      zt2.awitgrp     as awitgrp,
      zanlz.viduse    as viduse,
      'FIAA_02'       as datacode
} 
    where zt2.bukrs between :p_bukrs_low and :p_bukrs_high    // AK_BUTVILOVS #36910 Работы по параметризации источников данных
 