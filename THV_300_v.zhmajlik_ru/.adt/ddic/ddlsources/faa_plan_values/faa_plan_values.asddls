@AbapCatalog.sqlViewName: 'Faav_Plan_Values'
@EndUserText.label: 'Geplante und Gebuchte Werte pro Anlage und Werttyp'
@AccessControl.authorizationCheck: #NOT_REQUIRED
-- New with Note 2217483
define view Faa_Plan_Values as

select from faat_plan_values
{ key mandt  as mandt,
  key bukrs  as bukrs,
  key anln1  as anln1,
  key anln2  as anln2,
  key gjahr  as gjahr,
  key afabe  as afaber,
  key poper  as poper,
  key slalittype as SLALITTYPE,
      ldgrp  as ldgrp,
      anlgr  as anlgr,
      anlgr2 as anlgr2,
      movcat as movcat,
      poper  as depr_period,                      -- SIL new Ledger
      ' '    as posted,
      hsl    as HSL,
      ksl    as ksl,
      osl    as osl,
      vsl    as vsl,
      bsl    as bsl,
      csl    as csl,
      dsl    as dsl,
      esl    as esl,
      fsl    as fsl,
      gsl    as gsl,
      rhcur  as RHCUR,
      rkcur  as rkcur,
      rocur  as rocur,
      rvcur  as rvcur,
      rbcur  as rbcur,
      rccur  as rccur,
      rdcur  as rdcur,
      recur  as recur,
      rfcur  as rfcur,
      rgcur  as rgcur,
      recid  as RECID,
      xpost  as xpost,
      mig_source as MIG_SOURCE }

union all
   select from acdoca as acdoca
    inner join Faa_Rep_Ledger as rldnr
       on rldnr.bukrs      = acdoca.rbukrs
      and rldnr.rep_ledger = acdoca.rldnr
      and rldnr.lead_afabe = acdoca.afabe
{ key acdoca.rclnt  as mandt,
  key acdoca.rbukrs as bukrs,
  key acdoca.anln1  as anln1,
  key acdoca.anln2  as anln2,
  key acdoca.gjahr  as gjahr,
  key acdoca.afabe  as afaber,
  key acdoca.poper  as poper,
  key acdoca.slalittype as SLALITTYPE,
      rldnr.ldgrp   as ldgrp,
      acdoca.anlgr  as anlgr,
      acdoca.anlgr2 as anlgr2,
      acdoca.movcat as movcat,
      acdoca.depr_period as depr_period,            -- SIL new Ledger
      case
        when acdoca.awtyp = 'AS91' then 'A'
        else 'X'
      end as posted,
      acdoca.hsl    as HSL,
      acdoca.ksl    as ksl,
      acdoca.osl    as osl,
      acdoca.vsl    as vsl,
      acdoca.bsl    as bsl,
      acdoca.csl    as csl,
      acdoca.dsl    as dsl,
      acdoca.esl    as esl,
      acdoca.fsl    as fsl,
      acdoca.gsl    as gsl,
      acdoca.rhcur  as RHCUR,
      acdoca.rkcur  as rkcur,
      acdoca.rocur  as rocur,
      acdoca.rvcur  as rvcur,
      acdoca.rbcur  as rbcur,
      acdoca.rccur  as rccur,
      acdoca.rdcur  as rdcur,
      acdoca.recur  as recur,
      acdoca.rfcur  as rfcur,
      acdoca.rgcur  as rgcur,
      acdoca.recid  as RECID,
      'X'           as xpost,
      acdoca.mig_source as MIG_SOURCE }
where ( acdoca.awtyp = 'AMDP' or acdoca.awtyp = 'AS91' )
  and acdoca.slalittype between '07200' and '07299'




 
  
  
  
  
  
  
  
  
  
  
 