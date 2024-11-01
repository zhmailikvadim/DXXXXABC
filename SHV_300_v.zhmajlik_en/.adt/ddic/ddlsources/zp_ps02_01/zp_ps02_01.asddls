@AbapCatalog.sqlViewName: 'ZP_PS0201'
@AbapCatalog.compiler.compareFilter: true
@VDM.viewType: #COMPOSITE
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZACDOCATEST'
@Analytics.dataCategory: #CUBE
define view ZP_PS02_01 

 with parameters 
 //   @Environment.systemField: #CLIENT
//    p_clnt : abap.clnt,  
    p_period: fis_jahrper,
    p_period1: fis_jahrper,  
   P_fromdate : dats, 
   P_todate   : dats,
   P_period2  : poper,
   P_year     : gjahr,
   
   p_bukrs_low  : bukrs,      // AK_BUTVILOVS #36910 Работы по параметризации источников данных 
   p_bukrs_high : bukrs       // AK_BUTVILOVS #36910 Работы по параметризации источников данных 
    
/* as select from ZP_PS02_02 ( p_period:  $parameters.p_period ) as zp2 
{
    zp2.belnr            as belnr, 
    zp2.docln            as docln,
    zp2.anln1            as anln1,
    zp2.anln2            as anln2,
    zp2.racct            as racct,
    zp2.gkont            as gkont,
    zp2.gjahr            as gjahr,
    zp2.ktopl            as ktopl,
    zp2.co_belnr         as co_belnr,
    zp2.rbukrs           as rbukrs,
    zp2.objnr            as objnr,
    zp2.ps_posid         as ps_posid,
    zp2.pps_posid        as pps_posid,
    zp2.afabe            as afabe,
    zp2.drcrk            as drcrk,
    @DefaultAggregation: #SUM
    zp2.hsl              as hsl,
    zp2.fiscyearper      as fiscyearper,
    zp2.gkont_infl       as gkont_infl,
    zp2.awtyp            as awtyp,    
    zp2.date_infl        as date_infl,
    zp2.belnr_first      as belnr_first,
    zp2.buzei_first      as buzei_first,
    @DefaultAggregation: #SUM
    zp2.cpi              as cpi,
    @DefaultAggregation: #SUM
    zp2.fiscyearper_infl as fiscyearper_infl,         
    zp2.hsl_infl         as hsl_infl,
    zp2.Sign             as sign,
    zp2.same_acc         as same_acc,
    zp2.datacode         as datacode,
    zp2.pps_imprf        as pps_imprf,
    zp2.bttype           as bttype, 
    zp2.budat            as budat,
    zp2.vptnr,
    zp2.vrgng,
    '     '              as slalittype,
    zp2.set_name         as set_name,
    ' '                  as anbwa,
    ' '                  as afabg,
    zp2.depEndDate       as depEndDate,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kansw,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as knafa,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kaafa,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kansw_infl,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as knafa_infl,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kaafa_infl 

}    
 
  union all
   
  select from ZP_PS02_03 ( p_period:  $parameters.p_period ) as zp3 
  
  {
    zp3.belnr            as belnr,
    zp3.docln            as docln,
    zp3.anln1            as anln1,
    zp3.anln2            as anln2,
    zp3.racct            as racct,
    zp3.gkont            as gkont,
    zp3.gjahr            as gjahr,
    zp3.ktopl            as ktopl,
    zp3.co_belnr         as co_belnr,
    zp3.rbukrs           as rbukrs,
    zp3.objnr            as objnr,
    zp3.ps_posid         as ps_posid,
    zp3.pps_posid        as pps_posid,
    zp3.afabe            as afabe,
    zp3.drcrk            as drcrk,
    @DefaultAggregation: #SUM
    zp3.hsl         as hsl,
    zp3.fiscyearper      as fiscyearper,
    zp3.gkont_infl       as gkont_infl,
    zp3.awtyp            as awtyp,
    zp3.date_infl        as date_infl,
    zp3.belnr_first      as belnr_first,
    zp3.buzei_first      as buzei_first,
    @DefaultAggregation: #SUM 
    zp3.cpi              as cpi,
    @DefaultAggregation: #SUM
    zp3.fiscyearper_infl as fiscyearper_infl,
    zp3.hsl_infl         as hsl_infl,
    zp3.Sign             as sign,
    zp3.same_acc         as same_acc,
    zp3.datacode         as datacode,
    ''                   as pps_imprf,
    zp3.bttype           as bttype, 
    zp3.budat            as budat,   
    zp3.vptnr,
    zp3.vrgng,
    '      '             as slalittype,
    zp3.set_name         as set_name,
    ' '                  as anbwa,
    ' '                  as afabg,
    zp3.depEndDate       as depEndDate,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kansw,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as knafa,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kaafa,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kansw_infl,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as knafa_infl,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kaafa_infl             
} 
 
 union all 
 
 select from ZP_PS02_02 (p_period:  $parameters.p_period1 ) as zp2 
{
    zp2.belnr            as belnr,
    zp2.docln            as docln,
    zp2.anln1            as anln1,
    zp2.anln2            as anln2,
    zp2.racct            as racct,
    zp2.gkont            as gkont,
    zp2.gjahr            as gjahr,
    zp2.ktopl            as ktopl,
    zp2.co_belnr         as co_belnr,
    zp2.rbukrs           as rbukrs,
    zp2.objnr            as objnr,
    zp2.ps_posid         as ps_posid,
    zp2.pps_posid        as pps_posid,
    zp2.afabe            as afabe,
    zp2.drcrk            as drcrk,
    @DefaultAggregation: #SUM
    zp2.hsl              as hsl,
    zp2.fiscyearper      as fiscyearper,
    zp2.gkont_infl       as gkont_infl,
    zp2.awtyp            as awtyp,    
    zp2.date_infl        as date_infl,
    zp2.belnr_first      as belnr_first,
    zp2.buzei_first      as buzei_first,
    @DefaultAggregation: #SUM
    zp2.cpi              as cpi,
    @DefaultAggregation: #SUM
    zp2.fiscyearper_infl as fiscyearper_infl,         
    zp2.hsl_infl         as hsl_infl,
    zp2.Sign             as sign,
    ''                   as same_acc,
    'BAL_PRE'            as datacode,
    ''                   as pps_imprf,
    zp2.bttype           as bttype, 
    zp2.budat            as budat,
    zp2.vptnr,
    zp2.vrgng,
    '      '             as slalittype,
    zp2.set_name         as set_name,
    ' '                  as anbwa,
    ' '                  as afabg,
    zp2.depEndDate       as depEndDate,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kansw,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as knafa,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kaafa,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kansw_infl,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as knafa_infl,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kaafa_infl 
  
} 
*/

as select from ZP_PS02_07 ( p_period   : $parameters.p_period,  
                            p_period1  : $parameters.p_period1,
                            p_bukrs_low  : $parameters.p_bukrs_low,        // AK_BUTVILOVS #36910 Работы по параметризации источников данных
                            p_bukrs_high : $parameters.p_bukrs_high        // AK_BUTVILOVS #36910 Работы по параметризации источников данных 
                          ) as zps

  {
    'ORIG'               as dstream,
    zps.belnr            as belnr, 
    zps.docln            as docln,
    zps.anln1            as anln1,
    zps.anln2            as anln2,
    '            '       as p_anln1,
    '    '               as p_anln2,
    zps.racct            as racct,
    zps.gkont            as gkont,
    zps.gkont1           as gkont1,
    zps.gjahr            as gjahr,
    zps.ktopl            as ktopl,
    zps.co_belnr         as co_belnr,
    zps.rbukrs           as rbukrs,
    '    '               as p_rbukrs,
    zps.objnr            as objnr,
    zps.ps_posid         as ps_posid,
    zps.pps_posid        as pps_posid,
    zps.afabe            as afabe,
    zps.drcrk            as drcrk,
    @DefaultAggregation: #SUM
    zps.hsl              as hsl,
    zps.fiscyearper      as fiscyearper,
    zps.gkont_infl       as gkont_infl,
    zps.awtyp            as awtyp,    
    zps.date_infl        as date_infl,
    zps.belnr_first      as belnr_first,
    zps.buzei_first      as buzei_first,
    @DefaultAggregation: #SUM
    zps.cpi              as cpi,
    @DefaultAggregation: #SUM
    zps.fiscyearper_infl as fiscyearper_infl,         
    zps.hsl_infl         as hsl_infl,
    zps.sign             as sign,
    zps.same_acc         as same_acc,
    zps.datacode         as datacode,
    zps.pps_imprf        as pps_imprf,
    zps.bttype           as bttype, 
    zps.budat            as budat,
    zps.vptnr,
    zps.vrgng,
    '     '              as slalittype,
    zps.set_name         as set_name,
    '   '                as anbwa,
    '         '          as afabg,
    zps.depEndDate       as depEndDate,
    zps.xreversing       as xreversing,
    zps.xreversed        as xreversed,
    zps.aufnr            as aufnr,
    zps.pbukrs           as pbukrs,
    zps.tcode            as tcode,   
    //Признаки корректировки МСФО  
    ' '                  as same_grmsfo,  
    '  '                 as p_grmsfo,  
    '   '                as m_rule, 
    '   '                as m_tvo,
    '   '                as m_vo,
    '            '       as m_corr,
    '          '         as m_msfocor,
    '  '                 as m_rparty,
    ' '                  as m_trans,
    ' '                  as m_onaono,
    '          '         as m_msfoacc,
    '          '         as m_aggcost,
    '  '                 as m_ttygrp,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kansw,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as knafa,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kaafa,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kansw_infl,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as knafa_infl,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kaafa_infl 
  }
 
  
union all

 select from ZP_PS02_08 ( p_period   : $parameters.p_period,  
                          p_period1  : $parameters.p_period1,
                          p_bukrs_low  : $parameters.p_bukrs_low,        // AK_BUTVILOVS #36910 Работы по параметризации источников данных
                          p_bukrs_high : $parameters.p_bukrs_high        // AK_BUTVILOVS #36910 Работы по параметризации источников данных
                         ) as zps

  {
    'CORR'               as dstream,
    zps.belnr            as belnr, 
    zps.docln            as docln,
    zps.anln1            as anln1,
    zps.anln2            as anln2,
    '             '      as p_anln1,
    '    '               as p_anln2,
    zps.racct            as racct,
    zps.gkont            as gkont,
    zps.gkont1           as gkont1,
    zps.gjahr            as gjahr,
    zps.ktopl            as ktopl,
    zps.co_belnr         as co_belnr,
    zps.rbukrs           as rbukrs,
    '    '               as p_rbukrs,
    zps.objnr            as objnr,
    zps.ps_posid         as ps_posid,
    zps.pps_posid        as pps_posid,
    zps.afabe            as afabe,
    zps.drcrk            as drcrk,
    @DefaultAggregation: #SUM
    zps.hsl              as hsl,
    zps.fiscyearper      as fiscyearper,
    zps.gkont_infl       as gkont_infl,
    zps.awtyp            as awtyp,    
    zps.date_infl        as date_infl,
    zps.belnr_first      as belnr_first,
    zps.buzei_first      as buzei_first,
    @DefaultAggregation: #SUM
    zps.cpi              as cpi,
    @DefaultAggregation: #SUM
    zps.fiscyearper_infl as fiscyearper_infl,         
    zps.hsl_infl         as hsl_infl,
    zps.Sign             as sign,
    zps.same_acc         as same_acc,
    zps.datacode         as datacode,
    zps.pps_imprf        as pps_imprf,
    zps.bttype           as bttype, 
    zps.budat            as budat,
    zps.vptnr,
    zps.vrgng,
    '     '              as slalittype,
    zps.set_name         as set_name,
    '   '                as anbwa,
    '         '          as afabg,
    zps.depEndDate       as depEndDate,
    zps.xreversing       as xreversing,
    zps.xreversed        as xreversed,
    zps.aufnr            as aufnr,
    zps.pbukrs           as pbukrs,
    zps.tcode            as tcode,   
    //Признаки корректировки МСФО  
    ' '                  as same_grmsfo,  
    '  '                 as p_grmsfo,  
    zps.m_rule           as m_rule,
    zps.m_tvo            as m_tvo,
    zps.m_vo             as m_vo,
    zps.m_corr           as m_corr,
    zps.m_msfocor        as m_msfocor,
    zps.m_rparty         as m_rparty,
    zps.m_trans          as m_trans,
    zps.m_onaono         as m_onaono,
    zps.m_msfoacc        as m_msfoacc,
    zps.m_aggcost        as m_aggcost,
    zps.m_ttygrp         as m_ttygrp,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kansw,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as knafa,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kaafa,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kansw_infl,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as knafa_infl,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kaafa_infl 
  } 

 union all
 
   
  select from ZP_AA01_01 ( P_fromdate: $parameters.P_fromdate, 
                           P_todate: $parameters.P_todate,
                           P_period:  $parameters.P_period2, 
                           P_year: $parameters.P_year,
                           p_bukrs_low  : $parameters.p_bukrs_low,        // AK_BUTVILOVS #36910 Работы по параметризации источников данных
                           p_bukrs_high : $parameters.p_bukrs_high        // AK_BUTVILOVS #36910 Работы по параметризации источников данных 
                          ) as zp4
  
  join anla as anla on zp4.mandt = anla.mandt
                               and zp4.anln1 = anla.anln1
                               and zp4.anln2 = anla.anln2
                               and zp4.bukrs = anla.bukrs
  
  left outer join prps on anla.posnr = prps.pspnr
  
  {
  
    'ORIG'               as dstream,
    '0000000000'         as belnr,
    '000000'             as docln,
    zp4.anln1            as anln1,
    zp4.anln2            as anln2,
    '             '      as p_anln1,
    '    '               as p_anln2,
    '0000000000'         as racct,
    '0000000000'         as gkont,
    '0000000000'         as gkont1,
    '0000'               as gjahr,
    'BNFT'               as ktopl,
    '0000000000'         as co_belnr,
    zp4.bukrs            as rbukrs,
    '    '               as p_rbukrs,
    prps.objnr           as objnr,
    prps.posid           as ps_posid,
    ''                   as pps_posid,
    zp4.afabe_d          as afabe,
    ''                   as drcrk,
    @DefaultAggregation: #SUM
    zp4.hsl              as hsl,
    zp4.fiscyearper      as fiscyearper,
    ''                   as gkont_infl,
    '00000'              as awtyp,
    ''                   as date_infl,
    '0000000000'         as belnr_first,
    '000'                as buzei_first,
    @DefaultAggregation: #SUM 
    zp4.cpi_fiaa         as cpi,
    @DefaultAggregation: #SUM
    '0000000'            as fiscyearper_infl,
    0                    as hsl_infl,
    Sign                 as sign,
    ''                   as same_acc,
    zp4.datacode         as datacode,
    ''                   as pps_imprf,
    ''                   as bttype, 
    '00000000'           as budat,   
    ''                   as vptnr,
    ''                   as vrgng,
    zp4.slalittype       as slalittype,
    zp4.set_name         as set_name,
    zp4.anbwa            as anbwa,
    zp4.afabg            as afabg,
    zp4.depEndDate       as depEndDate,
    ' '                  as xreversing,
    ' '                  as xreversed,
    '            '       as aufnr,
    '    '               as pbukrs,
    '                    ' as tcode,   
    //Признаки корректировки МСФО 
    ' '                  as same_grmsfo,
    '  '                 as p_grmsfo,  
    '   '                as m_rule,   
    '   '                as m_tvo,
    '   '                as m_vo,
    '            '       as m_corr,
    '          '         as m_msfocor,
    '  '                 as m_rparty,
    ' '                  as m_trans,
    ' '                  as m_onaono,
    '          '         as m_msfoacc,
    '          '         as m_aggcost,
    '  '                 as m_ttygrp,
    @DefaultAggregation: #SUM
    zp4.kansw            as kansw,
    @DefaultAggregation: #SUM
    zp4.knafa            as knafa,
    @DefaultAggregation: #SUM
    zp4.kaafa            as kaafa,
    @DefaultAggregation: #SUM
    zp4.kansw_infl       as kansw_infl,
    @DefaultAggregation: #SUM
    zp4.knafa_infl       as knafa_infl,
    @DefaultAggregation: #SUM
    zp4.kaafa_infl       as kaafa_infl
}   

 union all

  select from ZP_AA01_02 ( P_fromdate: $parameters.P_fromdate, 
                           P_todate: $parameters.P_todate,
                           P_period:  $parameters.P_period2, 
                           P_year: $parameters.P_year,
                           p_bukrs_low  : $parameters.p_bukrs_low,        // AK_BUTVILOVS #36910 Работы по параметризации источников данных
                           p_bukrs_high : $parameters.p_bukrs_high        // AK_BUTVILOVS #36910 Работы по параметризации источников данных  
                         ) as zp4
  
    {
    'CORR'               as dstream,
    '0000000000'         as belnr,
    '000000'             as docln,
    zp4.anln1            as anln1,
    zp4.anln2            as anln2,
    zp4.p_anln1          as p_anln1,
    zp4.p_anln2          as p_anln2,
    '0000000000'         as racct,
    '0000000000'         as gkont,
    '0000000000'         as gkont1,
    '0000'               as gjahr,
    'BNFT'               as ktopl,
    '0000000000'         as co_belnr,
    zp4.bukrs            as rbukrs,
    zp4.p_bukrs          as p_rbukrs,
    zp4.objnr            as objnr,
    zp4.ps_posid         as ps_posid,
    ''                   as pps_posid,
    zp4.afabe_d          as afabe,
    ''                   as drcrk,
    @DefaultAggregation: #SUM
    zp4.hsl              as hsl,
    zp4.fiscyearper      as fiscyearper,
    ''                   as gkont_infl,
    '00000'              as awtyp,
    ''                   as date_infl,
    '0000000000'         as belnr_first,
    '000'                as buzei_first,
    @DefaultAggregation: #SUM 
    zp4.cpi_fiaa         as cpi,
    @DefaultAggregation: #SUM
    '0000000'            as fiscyearper_infl,
    0                    as hsl_infl,
    Sign                 as sign,
    ''                   as same_acc,
    zp4.datacode         as datacode,
    ''                   as pps_imprf,
    ''                   as bttype, 
    '00000000'           as budat,   
    ''                   as vptnr,
    ''                   as vrgng,
    zp4.slalittype       as slalittype,
    zp4.set_name         as set_name,
    zp4.anbwa            as anbwa,
    zp4.afabg            as afabg,
    zp4.depEndDate       as depEndDate,
    ' '                  as xreversing,
    ' '                  as xreversed,
    '            '       as aufnr,
    '    '               as pbukrs,
    '                    ' as tcode,
    //Признаки корректировки МСФО   
    zp4.same_grmsfo      as same_grmsfo, 
    zp4.p_grmsfo         as p_grmsfo, 
    zp4.m_rule           as m_rule,
    zp4.m_tvo            as m_tvo,
    zp4.m_vo             as m_vo,
    zp4.m_corr           as m_corr,
    zp4.m_msfocor        as m_msfocor,
    zp4.m_rparty         as m_rparty,
    zp4.m_trans          as m_trans,
    zp4.m_onaono         as m_onaono,
    zp4.m_msfoacc        as m_msfoacc,
    zp4.m_aggcost        as m_aggcost,
    zp4.m_ttygrp         as m_ttygrp,
    @DefaultAggregation: #SUM
    zp4.kansw            as kansw,
    @DefaultAggregation: #SUM
    zp4.knafa            as knafa,
    @DefaultAggregation: #SUM
    zp4.kaafa            as kaafa,
    @DefaultAggregation: #SUM
    zp4.kansw_infl       as kansw_infl,
    @DefaultAggregation: #SUM
    zp4.knafa_infl       as knafa_infl,
    @DefaultAggregation: #SUM
    zp4.kaafa_infl       as kaafa_infl
}    

   union all


 select from ZP_PS02_09 ( p_period   : $parameters.p_period,  
                          p_period1  : $parameters.p_period1,
                          p_bukrs_low  : $parameters.p_bukrs_low,        // AK_BUTVILOVS #36910 Работы по параметризации источников данных
                          p_bukrs_high : $parameters.p_bukrs_high        // AK_BUTVILOVS #36910 Работы по параметризации источников данных
                         ) as zps

  {
    'C803'               as dstream,
    zps.belnr            as belnr, 
    zps.docln            as docln,
    zps.anln1            as anln1,
    zps.anln2            as anln2,
    '             '      as p_anln1,
    '    '               as p_anln2,
    zps.racct            as racct,
    zps.gkont            as gkont,
    zps.gkont1           as gkont1,
    zps.gjahr            as gjahr,
    zps.ktopl            as ktopl,
    zps.co_belnr         as co_belnr,
    zps.rbukrs           as rbukrs,
    '    '               as p_rbukrs,
    zps.objnr            as objnr,
    zps.ps_posid         as ps_posid,
    zps.pps_posid        as pps_posid,
    zps.afabe            as afabe,
    zps.drcrk            as drcrk,
    @DefaultAggregation: #SUM
    zps.hsl              as hsl,
    zps.fiscyearper      as fiscyearper,
    zps.gkont_infl       as gkont_infl,
    zps.awtyp            as awtyp,    
    zps.date_infl        as date_infl,
    zps.belnr_first      as belnr_first,
    zps.buzei_first      as buzei_first,
    @DefaultAggregation: #SUM
    zps.cpi              as cpi,
    @DefaultAggregation: #SUM
    zps.fiscyearper_infl as fiscyearper_infl,         
    zps.hsl_infl         as hsl_infl,
    zps.Sign             as sign,
    zps.same_acc         as same_acc,
    zps.datacode         as datacode,
    zps.pps_imprf        as pps_imprf,
    zps.bttype           as bttype, 
    zps.budat            as budat,
    zps.vptnr,
    zps.vrgng,
    '     '              as slalittype,
    zps.set_name         as set_name,
    '   '                as anbwa,
    '         '          as afabg,
    zps.depEndDate       as depEndDate,
    zps.xreversing       as xreversing,
    zps.xreversed        as xreversed,
    zps.aufnr            as aufnr,
    zps.pbukrs           as pbukrs,
    zps.tcode            as tcode,
    //Признаки корректировки МСФО  
    ' '                  as same_grmsfo,  
    '  '                 as p_grmsfo,  
    zps.m_rule           as m_rule,
    zps.m_tvo            as m_tvo,
    zps.m_vo             as m_vo,
    zps.m_corr           as m_corr,
    zps.m_msfocor        as m_msfocor,
    zps.m_rparty         as m_rparty,
    zps.m_trans          as m_trans,
    zps.m_onaono         as m_onaono,
    zps.m_msfoacc        as m_msfoacc,
    zps.m_aggcost        as m_aggcost,
    zps.m_ttygrp         as m_ttygrp,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kansw,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as knafa,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kaafa,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kansw_infl,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as knafa_infl,
    @DefaultAggregation: #SUM
    cast(0 as abap.dec( 16, 2 ))  as kaafa_infl 
  }
   
